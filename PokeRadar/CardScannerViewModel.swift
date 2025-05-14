//
//  CardScannerViewModel.swift
//  PokeRadar
//
//  Created by Axel Siliezar on 4/22/25.
//

import SwiftUI
import Vision

class CardScannerViewModel: ObservableObject {
    @Published var detectedName: String? = nil
    @Published var cardImageURL: String? = nil
    @Published var errorMessage: String? = nil

    private var request: VNRecognizeTextRequest!

    init() {
        request = VNRecognizeTextRequest { [weak self] request, error in
            guard let self = self else { return }
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }

            if let results = request.results as? [VNRecognizedTextObservation] {
                let detectedText = results.compactMap { $0.topCandidates(1).first?.string }.first
                DispatchQueue.main.async {
                    self.detectedName = detectedText
                }
            }
        }
        request.recognitionLevel = .accurate
    }

    func processImage(_ image: CGImage) {
        let handler = VNImageRequestHandler(cgImage: image, options: [:])
        do {
            try handler.perform([request])
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func searchCard(named name: String) {
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
                    self.cardImageURL = decodedResponse.data.first?.images.large
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode response"
                }
            }
        }.resume()
    }

    func reset() {
        detectedName = nil
        cardImageURL = nil
        errorMessage = nil
    }
}
