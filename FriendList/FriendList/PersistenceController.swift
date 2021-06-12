//
//  PersistenceController.swift
//  FriendList
//
//  Created by Peter Kostin on 2021-06-11.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "FriendModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error: \(error)")
            }
        }
    }
    
    func save(completion: @escaping (Error?) -> () = {_ in }) {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
}
