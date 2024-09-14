//
//  Starship.swift
//  StarWarsLexicon
//
//  Created by Özgün Yildiz on 12.09.24.
//

import Foundation

struct Starship: Codable {
    
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let maxSpeed: String
    let crew: String
    let passengers: String
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case model
        case manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case maxSpeed = "max_atmosphering_speed"
        case crew
        case passengers
    }
    
}
