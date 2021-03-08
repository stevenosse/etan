//
//  BaseRepository.swift
//  etan
//
//  Created by Nossedjou Steve on 05/03/2021.
//

import Foundation
import Alamofire

class BaseRepository {
    let networkService: NetworkService = NetworkService.shared
    let storageService: StorageService = StorageService.shared
}
