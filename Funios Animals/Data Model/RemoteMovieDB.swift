//
//  RemoteMovieDB.swift
//  Funios Animals
//
//  Created by PT.Koanba on 27/09/22.
//

import Foundation


// MARK: - MovieDetailElement
struct RemoteAnimal: Codable {
    let name, latinName: String
    let animalType: String
    let activeTime: String
    let lengthMin, lengthMax, weightMin, weightMax: String
    let lifespan, habitat, diet, geoRange: String
    let imageLink: URL
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name
        case latinName = "latin_name"
        case animalType = "animal_type"
        case activeTime = "active_time"
        case lengthMin = "length_min"
        case lengthMax = "length_max"
        case weightMin = "weight_min"
        case weightMax = "weight_max"
        case lifespan, habitat, diet
        case geoRange = "geo_range"
        case imageLink = "image_link"
        case id
    }
}
