//
//  PokemonCardViewModel.swift
//  PokeRadar
//
//  Created by Axel Siliezar on 4/22/25.
//

import Foundation
import SwiftUI

class PokemonCardViewModel: ObservableObject {
    @Published var cardImageURL: String? = nil
    @Published var errorMessage: String? = nil
    private var cards: [PokemonCard] = []
    private var currentCardIndex = 0

    func fetchCard(named name: String) {
        guard let url = URL(string: "https://api.pokemontcg.io/v2/cards?q=name:\(name)") else {
            errorMessage = "Invalid URL"
            return
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("6caa6f7d-e110-4bfb-8764-5a76bdab6134", forHTTPHeaderField: "X-Api-Key") // Replace with your API key

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(PokemonCardResponse.self, from: data)
                DispatchQueue.main.async {
                    self.cards = decodedResponse.data
                    self.currentCardIndex = 0
                    self.cardImageURL = self.cards.first?.images.large
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode response"
                }
            }
        }.resume()
    }

    func shuffleCard() {
        guard !cards.isEmpty else { return }
        currentCardIndex = (currentCardIndex + 1) % cards.count
        cardImageURL = cards[currentCardIndex].images.large
    }
}
