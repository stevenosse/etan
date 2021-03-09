//
//  FavoriteMapViewModel.swift
//  etan
//
//  Created by Nossedjou Steve on 09/03/2021.
//

import Foundation
import CoreData

class FavoriteMapViewModel : BaseViewModel {
    
    func getFavorites() -> [NSManagedObject] {
        return FavoriteListRepository.instance.getFavoriteList()
        
    }
}
