//
//  File.swift
//  etan
//
//  Created by Nossedjou Steve on 03/03/2021.
//

import Foundation

struct Stop: Codable {
    let codeLieu, libelle, distance: String
    let ligne: [Ligne]
}

struct Ligne: Codable {
    let numLigne: String
}
