//
//  StopCoords.swift
//  etan
//
//  Created by Nossedjou Steve on 09/03/2021.
//

import Foundation

// MARK: - StopCoords
struct StopCoords: Codable {
    let nhits: Int?
    let parameters: Parameters?
    let records: [Record]
    
    init(records: [Record], params: Parameters?, nhits: Int?) {
        self.records = records
        self.parameters = params
        self.nhits = nhits
    }
}

// MARK: - Parameters
struct Parameters: Codable {
    let dataset, timezone: String
    let rows, start: Int
    let format: String
}

// MARK: - Record
struct Record: Codable {
    let datasetid, recordid: String
    let fields: Fields
    let geometry: Geometry
    let recordTimestamp: String

    enum CodingKeys: String, CodingKey {
        case datasetid, recordid, fields, geometry
        case recordTimestamp = "record_timestamp"
    }
}

// MARK: - Fields
struct Fields: Codable {
    let stopCoordinates: [Double]
    let stopName, locationType, stopID: String

    enum CodingKeys: String, CodingKey {
        case stopCoordinates = "stop_coordinates"
        case stopName = "stop_name"
        case locationType = "location_type"
        case stopID = "stop_id"
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: String
    let coordinates: [Double]
}
