import Foundation

final class NoteViewModel {
    let title: String
    let description: String
    let urlToImage: String?
    let date: Date
    
    init(noteModel: NoteModel) {
        self.title = noteModel.title
        self.description = noteModel.description
        self.urlToImage = noteModel.urlToImage
        self.date = noteModel.date
    }
}
