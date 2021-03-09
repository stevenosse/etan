//
//  FavoriteListRepository.swift
//  etan
//
//  Created by Nossedjou Steve on 08/03/2021.
//

import Foundation
import CoreData

class FavoriteListRepository : BaseRepository {
    static let instance = FavoriteListRepository()
    
    func saveFavorite(name: String, latitude: Double, longitude: Double, code: String) {
        let stopEntity = storageService.entityFor(entityName: Constants.favoriteEntityName)
    
        let stop = NSManagedObject(entity: stopEntity, insertInto: storageService.managedContext)
        
        stop.setValue(name, forKey: "stopName")
        stop.setValue(latitude , forKey: "latitude")
        stop.setValue(longitude , forKey: "longitude")
        stop.setValue(code, forKey: "code")
        
        storageService.saveContext()
    }
    
    func getFavoriteList() -> [NSManagedObject]{
        return storageService.fetch(entityName: Constants.favoriteEntityName)
    }
    
    func removeFavorite(object: NSManagedObject?) -> Bool {
        if(object != nil) {
            return storageService.delete(object: object!)
        }
        return false
    }
}
