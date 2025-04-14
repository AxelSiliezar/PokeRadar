//
//  MapView.swift
//  PokeRadar
//
//  Created by Axel Siliezar on 4/6/25.
//
import Foundation
import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = LocationViewModel()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Binding var searchText: String

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: viewModel.locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                Image("center-icon")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onChange(of: searchText) { newValue in
            search(for: newValue)
        }
    }

    private func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let item = response.mapItems.first {
                region.center = item.placemark.coordinate
            }
        }
    }
}
