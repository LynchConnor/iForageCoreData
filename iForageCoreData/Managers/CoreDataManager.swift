//
//  CoreDataManager.swift
//  iForageCoreData
//
//  Created by Connor A Lynch on 11/11/2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    static var shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func save(){
        do {
            try viewContext.save()
        }catch {
            print("DEBUG: \(error.localizedDescription)")
            viewContext.rollback()
        }
    }
    
    func fetchPosts() -> [ForageEntity] {
        
        let request: NSFetchRequest = NSFetchRequest<ForageEntity>(entityName: "ForageEntity")
        
        do {
            return try viewContext.fetch(request)
        }catch let error {
            print("DEBUG: \(error.localizedDescription)")
            return []
        }
    }
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "ForageAppModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
            }
        }
    }
    
}
