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
        
        do {
            try context.save()
            self.postNotification()
        } catch {
            let nserror = error as NSError
            fatalError("Unsolved error \(nserror), \(nserror.userInfo)")
        }
    }
    func fetchNote(_ note: NoteViewModel) -> Note? {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.predicate = NSPredicate(format: "noteDate = %@", note.date as NSDate)
        let note = try? context.fetch(request).first
        return note
    }
    func fetchNotes() -> [Note] {
        let request = NSFetchRequest<Note>(entityName: "Note")
        guard let notes = try? context.fetch(request) else { return []}
        return notes
    }
    func updateNote(_ note: NoteViewModel, newNote: NoteViewModel) {
        guard let noteEntity = self.fetchNote(note) else { return }
        noteEntity.noteTitle = newNote.title
        noteEntity.noteDescription = newNote.description
        noteEntity.noteUrlToImage = newNote.urlToImage
        noteEntity.noteDate = newNote.date
        appDelegate.saveContext()
        postNotification()
    }
    func deleteNote(note: NoteViewModel) {
        guard let note = self.fetchNote(note) else { return }
        context.delete(note)
        appDelegate.saveContext()
        postNotification()
    }
    func deleteNotes() {
        let request = NSFetchRequest<Note>(entityName: "Note")
        guard let notes = try? context.fetch(request) else { return }
        notes.forEach({
            context.delete($0)
            self.postNotification()
        })
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unsolved error \(nserror), \(nserror.userInfo)")
        }
    }
    private func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("FetchNotes"), object: nil)
    }
}
