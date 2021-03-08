//
//  StopListViewModel.swift
//  etan
//
//  Created by Nossedjou Steve on 05/03/2021.
//

import Foundation
import UIKit

class StopListViewModel : BaseViewModel {
    // MARK: - Repository
    let repository = StopListRepository.instance
    let favoriteRepository = FavoriteListRepository.instance
    
    var finalStopList: [Stop]!
    
    // MARK: - Data
    var stopList: [Stop]? = [] {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var stopCount: Int {
        return stopList?.count ?? 0
    }
    
    func searchStop(label: String) {
        if label.isEmpty {
            stopList = finalStopList
            return
        }
        self.stopList = self.finalStopList.filter({ (stop) in
            return (stop.libelle?.lowercased().split(separator: " ").joined(separator: "").contains(label.lowercased().split(separator: " ").joined(separator: "")) ?? false)
        })
    }
    
    // MARK: - Methods
    func getStopList() {
        self.isLoading = true
        repository.getStopList() { (stops, error) in
            if error != nil && !(error?.isEmpty ?? true) {
                self.errorMessage = error
                return
            }
            self.stopList = stops
            self.finalStopList = stops
            self.isLoading = false
        }
    }
    
    func saveStopToFavorites(stop: Stop?) -> Bool {
        if stop != nil {
            let favoriteList = FavoriteListRepository.instance.getFavoriteList()
            let match = favoriteList.first(where: { object in
                return object.value(forKeyPath: "stopName") as? String == stop?.libelle
            })
            if match != nil {
                return false
            }
            
            favoriteRepository.saveFavorite(name: (stop?.libelle)!, latitude: 0.0, longitude: 0.0)
            return true
        }
        return false
    }
}
