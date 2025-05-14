//
//  CardScannerView.swift
//  PokeRadar
//
//  Created by Axel Siliezar on 4/22/25.
//

import SwiftUI
import AVFoundation
import Vision

struct CardScannerView: View {
    @StateObject private var viewModel = CardScannerViewModel()
    @State private var detectedName: String? = nil

    var body: some View {
        VStack {
            CameraView(viewModel: viewModel)
                .frame(height: 400)
                .cornerRadius(10)
                .padding()

            if let detectedName = detectedName {
                Text("Detected: \(detectedName)")
                    .font(.headline)
                    .padding()

                Button("Search Card") {
                    viewModel.searchCard(named: detectedName)
                }
                .padding()
            } else {
                Text("Point the camera at a card")
                    .foregroundColor(.gray)
            }

            if let cardImageURL = viewModel.cardImageURL {
                AsyncImage(url: URL(string: cardImageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 400)
                } placeholder: {
                    ProgressView()
                }
            }

            Button("Scan Next") {
                viewModel.reset()
                detectedName = nil
            }
            .padding()
        }
        .onReceive(viewModel.$detectedName) { name in
            detectedName = name
        }
    }
}
