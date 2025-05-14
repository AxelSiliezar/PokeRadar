//
//  PokemonCardModel.swift
//  PokeRadar
//
//  Created by Axel Siliezar on 4/22/25.
//

import Foundation

struct PokemonCard: Codable {
    let name: String
    let images: CardImages
}

struct CardImages: Codable {
    let small: String
    let large: String
}

struct PokemonCardResponse: Codable {
    let data: [PokemonCard]
}
