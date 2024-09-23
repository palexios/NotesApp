import Foundation


protocol TableViewModelProtocol {
    func getNumberOfNotes(section: Int) -> Int
    func getNumberOfSections() -> Int
    func getNote(indexPath: IndexPath) -> NoteViewModel
    func getSectionTitle(section: Int) -> String
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
    @objc private func loadNotes() {
        //let firstSection = SectionViewModel()
        let notes = self.coreDataManager.fetchNotes().map {NoteViewModel(noteCoreDataModel: $0)}
        self.sections = self.groupByDay(with: notes)
        //firstSection.notes = notes
        //self.sections = [firstSection]
    }

    private func setMockNotes() {
//        let firstSection = SectionViewModel()
//        let firstMock = NoteModel(title: "Записаться к врачуЗаписаться к врачуЗаписаться к врачуЗаписаться к врачуЗаписаться к врачуЗаписаться к врачу", description: "На вечер. К терапевту", urlToImage: nil, date: Date())
//        let secondMock = NoteModel(title: "Пароль к телефону", description: "12345", urlToImage: nil, date: Date())
//        firstSection.notes = [NoteViewModel(noteModel: firstMock), NoteViewModel(noteModel: secondMock)]
//        self.sections = [firstSection]
        
        let firstSection = SectionViewModel()
//        self.coreDataManager.createNote(title: "Записаться к врачуЗаписаться к врачуЗаписаться к врачуЗаписаться к врачуЗаписаться к врачуЗаписаться к врачу", description: "На вечер. К терапевту", urlToImage: nil, date: Date())
//        self.coreDataManager.createNote(title: "Пароль к телефону", description: "12345", urlToImage: nil, date: Date())
        let notes = self.coreDataManager.fetchNotes().map {NoteViewModel(noteCoreDataModel: $0)}
        firstSection.notes = notes
        self.sections = [firstSection]
        
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
            section.title = "\(i as Date)"
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
}
