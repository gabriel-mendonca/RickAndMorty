//
//  DetailsModel.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 23/08/22.
//

import Foundation

struct DetailsModel: Codable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: Species?
    let type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

enum GenderDetail: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

// MARK: - Location
struct LocationDetail: Codable {
    let name: String
    let url: String
}

enum SpeciesDetail: String, Codable {
    case alien = "Alien"
    case human = "Human"
    case animal = "Animal"
    case robot = "Robot"
    case humanoid = "Humanoid"
    case disease = "Disease"
    case cronenberg = "Cronenberg"
    case poopybutthole = "Poopybutthole"
    case mythologicalCreature = "Mythological Creature"
    case unknown
}

enum StatusDetail: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

