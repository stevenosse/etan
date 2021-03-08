//
//  Ligne.swift
//  etan
//
//  Created by Nossedjou Steve on 05/03/2021.
//

import Foundation

struct Ligne: Codable {
    let numLigne, directionSens1, directionSens2, accessible: String?
    let etatTrafic: Int?
}
