import CoreData

// Manager

private let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "L1st")

    container.loadPersistentStores { storeDescription, error in
        if let error = error as NSError? {
            fatalError("Load Unresolved error \(error), \(error.userInfo)")
        }
    }
    return container
}()

private let kDatabaseContext = persistentContainer.viewContext

private func SaveDatabase() {
    if kDatabaseContext.hasChanges {
        do {
            try kDatabaseContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Save Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

// Objects

@objc(FavoriteEntry)
final class FavoriteEntry: NSManagedObject {
    @NSManaged var id: String

    static func fetchRequest() -> NSFetchRequest<FavoriteEntry> {
        return NSFetchRequest<FavoriteEntry>(entityName: "FavoriteEntry")
    }

    static var allItems: [FavoriteEntry]? {
        let request = FavoriteEntry.fetchRequest()

        return try? kDatabaseContext.fetch(request)
    }

    static func searchBy(id: String) -> FavoriteEntry? {
        let request = FavoriteEntry.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1

        return try? kDatabaseContext.fetch(request).first
    }

    static func insertBy(id: String) {
        let object = Self(context: kDatabaseContext)
        object.id = id
        
        SaveDatabase()
    }

    static func removeBy(id: String) {
        guard let object = searchBy(id: id) else {
            return
        }

        kDatabaseContext.delete(object)

        SaveDatabase()
    }
}
