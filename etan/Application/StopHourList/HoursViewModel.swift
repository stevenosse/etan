//
//  HoursViewModel.swift
//  etan
//
//  Created by Nossedjou Steve on 05/03/2021.
//

import Foundation

class HoursViewModel : BaseViewModel {
    var stop: Stop?
    var line: Ligne?
    var hourElement: Hour? {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var hourList: [String] = []
    
    let repository = HourListRepository.instance
    
    override init() {}
    
    init(stop: Stop?, line: Ligne?) {
        self.stop = stop
        self.line = line
    }
    
    var nextHours: [Horaire] {
        hourElement?.prochainsHoraires ?? []
    }
    
    func getNextHours() {
        self.isLoading = true
        repository.getNextHours(stopCode: stop?.codeLieu ?? "", lineCode: line?.numLigne ?? "") { (hourItem, error) in
            self.isLoading = false
            if error != nil && !(error?.isEmpty ?? true) {
                self.errorMessage = error
                return
            }
            let nextHours = hourItem?.prochainsHoraires ?? []
            for hour in nextHours {
                for time in hour.passages {
                    self.hourList.append("\(hour.heure)\(time)")
                }
            }
            self.hourElement = hourItem
            
        }
    }
}
