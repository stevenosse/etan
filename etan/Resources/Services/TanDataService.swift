//
//  TanDataService.swift
//  etan
//
//  Created by Nossedjou Steve on 09/03/2021.
//

import Foundation

class TanDataService : NetworkService {
    static let instance = TanDataService(baseUrl: Constants.datasetBaseUrl)
}
