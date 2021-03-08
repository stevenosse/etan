//
//  HourListRepository.swift
//  etan
//
//  Created by Nossedjou Steve on 05/03/2021.
//

import Foundation
import Alamofire

typealias HourListResponseCallback = (Hour?, String?) -> Void

class HourListRepository : BaseRepository {
    static let instance = HourListRepository()
    
    func getNextHours(stopCode: String = "PIRA1", lineCode: String = "11", onComplete: @escaping HourListResponseCallback) {
        // TODO: allow choosing bus direction
        networkService.get(path: "/horairesarret.json/\(stopCode)/\(lineCode)/1") { json, error in
            do {
                let hours: Hour = try JSONDecoder().decode(Hour.self, from: json ?? Data())
                onComplete(hours, nil)
            } catch {
                print("failed \(error)")
                onComplete(nil, "Echech du chargement des données.")
            }
        }
    }
}
