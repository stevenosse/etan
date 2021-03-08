//
//  FavoritesListViewModel.swift
//  etan
//
//  Created by Nossedjou Steve on 08/03/2021.
//

import Foundation
import CoreData

class FavoritesListViewModel : BaseViewModel {
    var repository: FavoriteListRepository = FavoriteListRepository.instance
    var favoriteList: [NSManagedObject]!
    
    var elementAddedClosure: (()->())?
    
    var favoriteListNames: [String]! {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    func getFavoriteList() {
        favoriteList = repository.getFavoriteList()
        var names: [String] = []
        for favorite in favoriteList {
            names.append(favorite.value(forKeyPath: "stopName") as! String)
        }
        self.favoriteListNames = names
    }
    
    func removeFromFavorites(name: String) -> Bool {
        let favoriteObject = self.favoriteList.first(where: { (object) in
            return (object.value(forKeyPath: "stopName") as! String) == name
        })!
        return repository.removeFavorite(object: favoriteObject)
    }
}
