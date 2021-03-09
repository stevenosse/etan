//
//  LoadingViewModel.swift
//  etan
//
//  Created by Nossedjou Steve on 09/03/2021.
//

import Foundation

typealias AppDataInitializedCallback = () -> Void

class LoadingViewModel : BaseViewModel {
    fileprivate let repository = AppDataRepository.instance
    
    func initStopList(onFinished: @escaping AppDataInitializedCallback) {
        print(repository.getLocalStopList().isEmpty)
        if repository.getLocalStopList().isEmpty {
            repository.getStopList() { (data, error) in
                if error?.isEmpty ?? true {
                    for stopCoords in data.records {
                        let coords = stopCoords.geometry.coordinates
                        self.repository.saveStopData(code: stopCoords.fields.stopID, latitude: coords.first ?? 0.0, longitude: coords.last ?? 0.0)
                    }
                    onFinished()
                    return
                }
            }
        } else {
            onFinished()
        }
    }
}
