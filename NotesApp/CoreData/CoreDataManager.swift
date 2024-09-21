import UIKit
import CoreData

public final class CoreDataManager: NSObject {
    // MARK: - Properties
    static let shared = CoreDataManager()
    private var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    private var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Init
    private override init() {}
    
    // MARK: - CRUD
    func createNote(title: String?, description: String?, urlToImage: String?, date: Date) {
        let note = Note(context: context)
        note.noteTitle = title
        note.noteDescription = description
        note.noteUrlToImage = urlToImage
        note.noteDate = date
        
        appDelegate.saveContext()
    }
    func fetchNotes() -> [Note] {
        let request = NSFetchRequest<Note>(entityName: "Note")
        guard let notes = try? context.fetch(request) else { return []}
        return notes
    }
    func updateNote() {
        
    }
    func deleteNote() {
        
    }
}
