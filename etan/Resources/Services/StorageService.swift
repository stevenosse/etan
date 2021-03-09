//
//  StorageService.swift
//  etan
//
//  Created by Nossedjou Steve on 08/03/2021.
//

import Foundation
import CoreData
import UIKit

class StorageService {
    var appDelegate: AppDelegate!
    
    static let shared = StorageService()
    
    var managedContext: NSManagedObjectContext {
        return self.appDelegate.persistentContainer.viewContext
    }
    
    init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    func entityFor(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: self.managedContext)!
    }
    
    func fetch(entityName: String) -> [NSManagedObject] {
        do {
            let result = try self.managedContext.fetch(NSFetchRequest<NSManagedObject>(entityName: entityName))
            return result
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func executeQuery(entityName: String, predicate: NSPredicate) -> [Any] {
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
        request.predicate = predicate
        
        do {
            let results = try managedContext.fetch(request)
            return results
        } catch {
            let nserror = error as NSError
            fatalError("An error occured : \(nserror)")
        }
        
    }
    
    func saveContext() {
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = managedContext
        
        if privateMOC.hasChanges {
            privateMOC.perform {
                //operations
                do {
                    try privateMOC.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("An error occured : \(nserror)")
                }
            }
        }
    }
    
    func delete(object: NSManagedObject) -> Bool {
        self.managedContext.delete(object)
        self.saveContext()
        return true
    }
}
