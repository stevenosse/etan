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
    
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("An error occured : \(nserror)")
            }
        }
    }
    
    func delete(object: NSManagedObject) -> Bool {
        self.managedContext.delete(object)
        self.saveContext()
        return true
    }
}
