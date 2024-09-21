import Foundation


protocol TableViewModelProtocol {
    func getNumberOfNotes(section: Int) -> Int
    func getNumberOfSections() -> Int
    func getNote(indexPath: IndexPath) -> NoteViewModel
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
        #warning("mock")
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
    @objc private func loadNotes() {
        let firstSection = SectionViewModel()
        let notes = self.coreDataManager.fetchNotes().map {NoteViewModel(noteCoreDataModel: $0)}
        firstSection.notes = notes
        self.sections = [firstSection]
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
}
