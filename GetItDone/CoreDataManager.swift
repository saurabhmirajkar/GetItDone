//
//  CoreDataManager.swift
//  GetItDone
//
//  Created by Saurabh Mirajkar on 10/10/20.
//  Copyright © 2020 Saurabh Mirajkar. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer : NSPersistentContainer = {
       let container = NSPersistentContainer(name: "GetItDone")
        container.loadPersistentStores { (storeDescription: NSPersistentStoreDescription, error: Error?) in
            if let error = error {
                fatalError("Failed: Loading Store Container - \(error)")
            }
        }
        return container
    }()
    
    func createToDo(id: Double, title: String, status: Bool) {
        let context = persistentContainer.viewContext
        let toDo = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context)
        
        toDo.setValue(id, forKey: "id")
        toDo.setValue(title, forKey: "title")
        toDo.setValue(status, forKey: "status")
        
        do {
            try context.save()
        } catch let error {
            print("Failed: Saving the data to context - \(error)")
        }
    }
    
    func fetchToDos() -> [ToDo] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ToDo>(entityName: "ToDo")
        
        do {
            let toDos = try context.fetch(fetchRequest)
            return toDos
        } catch let error {
            print("Failed: Fetching the data from context - \(error)")
            return []
        }
        
    }
    
    func fetchToDo(title: String) -> ToDo? {
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ToDo>(entityName: "ToDo")
        
        var toDo : ToDo?
        
        do {
            let toDos = try context.fetch(fetchRequest)
            toDos.forEach { fetchedToDo in
                if fetchedToDo.title == title {
                    toDo = fetchedToDo
                }
            }
        } catch let error {
            print("Failed: Fetching the data from context to update - \(error)")
        }
        
        return toDo
    }
    
    func deleteToDo(id: Double) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ToDo>(entityName: "ToDo")
        
        do {
            let toDos = try context.fetch(fetchRequest)
            toDos.forEach { fetchedToDo in
                if fetchedToDo.id == id {
                    context.delete(fetchedToDo)
                }
            }
        } catch let error {
            print("Failed: Fetching / Deleting the data from context - \(error)")
        }
        
        
    }
    
}
