//
//  AppDataRepository.swift
//  etan
//
//  Created by Nossedjou Steve on 09/03/2021.
//

import Foundation
import CoreData

typealias StopResponseCallback = (StopCoords, String?) -> Void

class AppDataRepository : BaseRepository {
    static let instance: AppDataRepository = AppDataRepository()
    fileprivate let service = TanDataService.instance
    
    func getStopList(onComplete: @escaping StopResponseCallback) {
        service.get(path: "&q=&rows=10000") { (data, error) in
            do {
                let stopCoords: StopCoords = try JSONDecoder().decode(StopCoords.self, from: data ?? Data())
                onComplete(stopCoords, nil)
            } catch {
                print("failed \(error)")
                onComplete(StopCoords(records: [], params: nil, nhits: 0), "Echec du chargement des données.")
            }
        }
    }
    
    func getLocalStopList() -> [NSManagedObject] {
        return storageService.fetch(entityName: Constants.stopEntityName)
    }
    
    func getCoordinatesFor(code: String) -> [NSManagedObject] {
        let predicate = NSPredicate(format: "code == %@", code)
        
        let results = storageService.executeQuery(entityName: Constants.stopEntityName, predicate: predicate) as! [NSManagedObject]
        return results
    }
    
    func saveStopData(code: String, latitude: Double, longitude: Double) {
        let stopEntity = storageService.entityFor(entityName: Constants.stopEntityName)
    
        let stop = NSManagedObject(entity: stopEntity, insertInto: storageService.managedContext)
        
        stop.setValue(latitude , forKey: "latitude")
        stop.setValue(longitude , forKey: "longitude")
        stop.setValue(code, forKey: "code")
        
        self.storageService.saveContext()
    }
}
