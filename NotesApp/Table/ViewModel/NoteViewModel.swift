import Foundation

final class NoteViewModel {
    var title: String?
    var description: String?
    var urlToImage: URL?
    var date: Date
    
    init(noteModel: NoteModel) {
        self.title = noteModel.title
        self.description = noteModel.description
        self.urlToImage = noteModel.urlToImage
        self.date = noteModel.date
    }
    init(noteCoreDataModel: Note) {
        self.title = noteCoreDataModel.noteTitle
        self.description = noteCoreDataModel.noteDescription
        self.urlToImage = noteCoreDataModel.noteUrlToImage
        self.date = noteCoreDataModel.noteDate
    }
}
