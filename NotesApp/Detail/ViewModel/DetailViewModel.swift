import Foundation

protocol DetailViewModelProtocol {
    func getTitle() -> String?
    func getDescription() -> String?
    func saveNote(title: String?, description: String?, urlToImage: String?, date: Date)
    func deleteNote()
    func getTitleAndDescription(from text: String) -> (String?, String?)
}
final class DetailViewModel: DetailViewModelProtocol {
    // MARK: - Properties
    private let note: NoteViewModel?
    private let coreDataManager = CoreDataManager.shared
    
    // MARK: - Init
    init(note: NoteViewModel?) {
        self.note = note
    }
    // MARK: - Methods
    func getTitle() -> String? {
        return self.note?.title
    }
    func getDescription() -> String? {
        return self.note?.description
    }
    // MARK: - Methods
    func saveNote(title: String?, description: String?, urlToImage: String?, date: Date) {
        if let note = self.note {
            let newNote = NoteViewModel(noteModel: NoteModel(title: title, description: description, urlToImage: urlToImage, date: date))
            self.coreDataManager.updateNote(note, newNote: newNote)
        } else {
            self.coreDataManager.createNote(title: title, description: description, urlToImage: urlToImage, date: date)
        }
    }
    func deleteNote() {
        guard let note = self.note else { return }
        self.coreDataManager.deleteNote(note: note)
    }
    func getTitleAndDescription(from text: String) -> (String?, String?) {
        let tulp: (String?, String?)
        
        let firstIndex = text.startIndex
        let lastIndex = text.firstIndex(where: {["?","!",".","\n"].contains($0)}) ?? text.endIndex
        let title = String(text[firstIndex..<lastIndex]).trimmingCharacters(in: .whitespacesAndNewlines)
        if lastIndex == text.endIndex || text.index(after: lastIndex) == text.endIndex {
            tulp.1 = nil
        } else {
            let description = String(text[text.index(after: lastIndex)..<text.endIndex]).trimmingCharacters(in: .whitespacesAndNewlines)
            tulp.1 = description.isEmpty ? nil : description
        }
        tulp.0 = title.isEmpty ? nil : title
        
        
        
        return tulp
    }
}
