import Foundation
import CoreData

@objc(Note)
public final class Note: NSManagedObject {
    
}

extension Note {
    @NSManaged public var noteTitle: String?
    @NSManaged public var noteDescription: String?
    @NSManaged public var noteUrlToImage: String?
    @NSManaged public var noteDate: Date
}

extension Note: Identifiable {
    
}
