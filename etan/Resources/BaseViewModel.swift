//
//  BaseViewModel.swift
//  etan
//
//  Created by Nossedjou Steve on 05/03/2021.
//

import Foundation

class BaseViewModel {
    // MARK: - Loading events
    var updateLoadingStatusClosure: (()->())?
    var reloadTableViewClosure: (()->())?
    var errorLoadingDataClosure: (()->())?
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }
    
    var errorMessage: String? {
        didSet {
            self.errorLoadingDataClosure?()
        }
    }
}
