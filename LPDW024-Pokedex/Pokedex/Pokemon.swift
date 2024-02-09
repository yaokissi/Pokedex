//
//  Pokemon.swift
//  Pokedex
//
//  Created by Etienne Vautherin on 08/02/2024.
//

import Foundation

struct Sprites: Codable {
    let front_default: String
}

struct Pokemon: Codable {
    let id: Int
    let name: String
    let sprites: Sprites
}
