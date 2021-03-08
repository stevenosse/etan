//
//  Hour.swift
//  etan
//
//  Created by Nossedjou Steve on 05/03/2021.
//

import Foundation

// MARK: - Hour
struct Hour: Codable {
    let arret: Arret
    let ligne: Ligne
    let codeCouleur, plageDeService: String
    let notes: [Note]?
    let horaires, prochainsHoraires: [Horaire]?
}

// MARK: - Arret
struct Arret: Codable {
    let codeArret, libelle: String
    let accessible: Bool
}

// MARK: - Horaire
struct Horaire: Codable {
    let heure: String
    let passages: [String]
}

// MARK: - Note
struct Note: Codable {
    let code: String?
    let libelle: String?
}
