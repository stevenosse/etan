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
    let queue = DispatchQueue(label: "requests.queue", qos: .utility)
    let mainQueue = DispatchQueue.main
    
    // MARK: - Singleton instance
    static let shared = NetworkService(baseUrl: Constants.apiBaseUrl)
    
    // MARK: - Initialisation
    private init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    fileprivate func make(request: DataRequest, closure: @escaping (_ json: Data?, _ error: Error?)->()) {
        request.response(queue: self.queue) { responseData in
            guard let data = responseData.data else {
                closure(nil, responseData.error)
                return
            }
            closure(data, nil)
        }
    }
    
    // MARK: - Methods
    func post(path: String, data: [String: Any]? = nil, closure: @escaping (_ json: Data?, _ error: Error?)->()) {
        let request = AF.request("\(baseUrl)\(path)", method: .post, parameters: data)
        return self.make(request: request) { json, error in
            closure(json, error)
        }
    }
    
    func get(path: String, data: [String: Any]? = nil, closure: @escaping (_ json: Data?, _ error: Error?)->()) {
        let request = AF.request("\(baseUrl)\(path)", method: .get, parameters: data)
        return self.make(request: request) { json, error in
            closure(json, error)
        }
    }
    
    func put(path: String, data: [String: Any]? = nil, closure: @escaping (_ json: Data?, _ error: Error?)->()) {
        let request = AF.request("\(baseUrl)\(path)", method: .put, parameters: data)
        return self.make(request: request) { json, error in
            closure(json, error)
        }
    }
    
    func delete(path: String, data: [String: Any]? = nil, closure: @escaping (_ json: Data?, _ error: Error?)->()) {
        let request = AF.request("\(baseUrl)\(path)", method: .delete, parameters: data)
        return self.make(request: request) { json, error in
            closure(json, error)
        }
    }
}
