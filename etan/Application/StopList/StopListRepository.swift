//
//  StopListRepository.swift
//  etan
//
//  Created by Nossedjou Steve on 05/03/2021.
//

import Foundation
import Alamofire

typealias StopListResponseCallback = ([Stop], String?) -> Void

class StopListRepository : BaseRepository {
    static let instance = StopListRepository()
    
    func getStopList(onComplete: @escaping StopListResponseCallback) {
        networkService.get(path: "/arrets.json") { json, error in
            do {
                let stops: [Stop] = try JSONDecoder().decode([Stop].self, from: json ?? Data())
                onComplete(stops, nil)
            } catch {
                print("failed \(error)")
                onComplete([], "Echech du chargement des données.")
            }
        }
    }
}
