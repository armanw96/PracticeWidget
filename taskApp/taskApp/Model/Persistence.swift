//
//  Persistence.swift
//  taskApp
//
//  Created by ArmanTW on 8/27/21.
//

import CoreData

struct PersistenceController {
    //MARK: - 1st. Persistence Controller singleton for entire app to use
    
    static let shared = PersistenceController()

//MARK: - 2nd. Persistence container storage property

    let container: NSPersistentContainer
    
    //MARK: - 3rd initialization (load persistent store)

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "taskApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    //MARK: - 4th. Preview
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "sample task no\(i)"
            newItem.completion = false
            newItem.id = UUID()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
