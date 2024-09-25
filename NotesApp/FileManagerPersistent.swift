import Foundation

final class FileManagerPersistent {
    // MARK: - Properties
    static let shared = FileManagerPersistent()
    // MARK: - Init
    private init() {}
    // MARK: - Methods
    func save(_ data: Data?, name: String?) -> URL? {
        guard let name = name, let data = data else { return nil}
        let url = self.getDocumentDirectory().appending(path: name)
        do {
            try data.write(to: url)
            print("Image was saved = \(url)")
            return url
        } catch {
            let nserror = error as NSError
            print("Unsolved error \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    func read(from url: URL) -> Data? {
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                let nserror = error as NSError
                print("Unsolved error \(nserror), \(nserror.userInfo)")
                return nil
            }
        } else {
            print("Файл не существует по пути: \(url.path)")
            return nil
        }
    }
    func getDocumentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
