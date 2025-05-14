//
//  PokemonCardSearchView.swift
//  PokeRadar
//
//  Created by Axel Siliezar on 4/22/25.
//

import SwiftUI

struct PokemonCardSearchView: View {
    @StateObject private var viewModel = PokemonCardViewModel()
    @State private var pokemonName = ""

    var body: some View {
        VStack {
            TextField("Enter Pokémon name", text: $pokemonName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Search") {
                viewModel.fetchCard(named: pokemonName)
            }
            .padding()

            if let cardImageURL = viewModel.cardImageURL {
                AsyncImage(url: URL(string: cardImageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 400)
                } placeholder: {
                    ProgressView()
                }

                Button("Shuffle") {
                    viewModel.shuffleCard()
                }
                .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                Text("Search for a Pokémon card!")
            }
        }
        .padding()
    }
}
