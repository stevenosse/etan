//
//  Network.swift
//  etan
//
//  Created by Nossedjou Steve on 05/03/2021.
//

import Foundation
import Alamofire

class NetworkService {
    var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func post(path: String, data: [String: Any]) -> DataRequest {
        return AF.request("\(baseUrl)\(path)", method: .post, parameters: data)
    }
    
    func get(path: String, data: [String: Any]) -> DataRequest {
        return AF.request("\(baseUrl)\(path)", method: .get, parameters: data)
    }
    
    func put(path: String, data: [String: Any])-> DataRequest  {
        return AF.request("\(baseUrl)\(path)", method: .put, parameters: data)
    }
    
    func delete(path: String, data: [String: Any]) -> DataRequest  {
        return AF.request("\(baseUrl)\(path)", method: .delete, parameters: data)
    }
}
