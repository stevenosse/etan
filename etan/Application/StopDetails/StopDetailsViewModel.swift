//
//  StopDetailsViewModel.swift
//  etan
//
//  Created by Nossedjou Steve on 05/03/2021.
//

import Foundation

class StopDetailsViewModel : BaseViewModel {
    var stop: Stop?
    var finalLineList: [Ligne]!
    
    init(stop: Stop? = nil) {
        self.stop = stop
    }
    
    var lineCount: Int {
        lines.count
    }
    
    var stopName: String {
        stop?.libelle ?? "Non defini"
    }
    
    var lines: [Ligne]! {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    func searchLine(label: String) {
        if label.isEmpty {
            self.lines = finalLineList
            return
        }
        self.lines = finalLineList.filter({(line) in
            return line.numLigne?.lowercased().contains(label.lowercased()) ?? false
        })
    }
    
    // MARK: - Stop details
    func getStopDetails() {
        self.lines = stop?.ligne
        finalLineList = self.lines
        
    }
}
