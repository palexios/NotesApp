import Foundation


protocol TableViewModelProtocol {
    func getNumberOfNotes(section: Int) -> Int
    func getNumberOfSections() -> Int
    func getNote(indexPath: IndexPath) -> NoteViewModel
    func getSectionTitle(section: Int) -> String
    func getImage(from url: URL?) -> Data?
    var reloadTable: (()-> Void)? { get set }
}
final class TableViewModel: TableViewModelProtocol {
    var reloadTable: (() -> Void)?
    // MARK: - Properties
    private var sections: [SectionViewModel] = [] {
        didSet {
            self.reloadTable?()
        }
    }
    private let coreDataManager = CoreDataManager.shared
    private let fileManagerPersistent = FileManagerPersistent.shared
    
    // MARK: - Init
    init() {
        //self.setMockNotes()
        self.registerObserver()
        self.loadNotes()
    }
    
    // MARK: - Methods
    func getNumberOfNotes(section: Int) -> Int {
        return sections[section].notes.count
    }
    func getNumberOfSections() -> Int {
        return self.sections.count
    }
    func getNote(indexPath: IndexPath) -> NoteViewModel {
        return self.sections[indexPath.section].notes[indexPath.item]
    }
    func getSectionTitle(section: Int) -> String {
        return self.sections[section].title ?? ""
    }

    private func registerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadNotes), name: NSNotification.Name("FetchNotes"), object: nil)
    }
    func groupByDay(with notes: [NoteViewModel]) -> [SectionViewModel] {
        let calendar = Calendar.current
        let notesCopy = notes.map { NoteViewModel(noteModel: NoteModel(title: $0.title, description: $0.description, urlToImage: $0.urlToImage, date: $0.date))}
        //remove time
        notesCopy.forEach({ noteCopy in
            noteCopy.date = calendar.startOfDay(for: noteCopy.date)
        })
        
        var groupedObjects: [Date: [NoteViewModel]] = [:]
        
        for (index,note) in notesCopy.enumerated() {
            if groupedObjects[note.date] != nil {
                groupedObjects[note.date]?.append(notes[index])
            } else {
                groupedObjects[note.date] = [notes[index]]
            }
        }
        let dateKeys = Array(groupedObjects.keys).sorted(by: {$0 > $1})
        var sections : [SectionViewModel] = []
        for i in dateKeys {
            let section = SectionViewModel()
            let date = i as Date
            let dateString = self.convertDateToString(with: date)
            section.title = dateString
            let notes = groupedObjects[i] ?? []
            section.notes = notes
            sections.append(section)
        }
        //sort
        for i in sections {
            i.notes.sort(by: {$0.date > $1.date})
        }
        return sections
    }
    func getImage(from url: URL?) -> Data? {
        guard let url = url else { return nil }
        return self.fileManagerPersistent.read(from: url)
    }
    private func convertDateToString(with date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    // MARK: - @objc Methods
    
    @objc private func loadNotes() {
        let notes = self.coreDataManager.fetchNotes().map {NoteViewModel(noteCoreDataModel: $0)}
        self.sections = self.groupByDay(with: notes)
    }
}
