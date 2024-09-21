protocol DetailViewModelProtocol {
    func getTitle() -> String?
    func getDescription() -> String?
}
final class DetailViewModel: DetailViewModelProtocol {
    // MARK: - Properties
    private let note: NoteViewModel?
    
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
}
