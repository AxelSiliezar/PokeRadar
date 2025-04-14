//
//  LocationViewModel.swift
//  PokeRadar
//
//  Created by Axel Siliezar on 4/6/25.
//


import Foundation
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locations: [Location] = []
    @Published var userLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        fetchLocations()
    }

    func fetchLocations() {
        guard let url = Bundle.main.url(forResource: "PokeLocations", withExtension: "geojson") else {
            print("Failed to locate PokeLocations.geojson in bundle.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = MKGeoJSONDecoder()
            let features = try decoder.decode(data)
            
            var parsedLocations: [Location] = []
            
            for feature in features {
                if let pointFeature = feature as? MKGeoJSONFeature,
                   let geometry = pointFeature.geometry.first as? MKPointAnnotation {
                    let coordinate = geometry.coordinate
                    let name = pointFeature.properties.flatMap { try? JSONSerialization.jsonObject(with: $0) as? [String: Any] }?["name"] as? String ?? "Unknown"
                    parsedLocations.append(Location(name: name, coordinate: coordinate))
                }
            }
            
            DispatchQueue.main.async {
                self.locations = parsedLocations
            }
        } catch {
            print("Failed to parse GeoJSON: \(error.localizedDescription)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            DispatchQueue.main.async {
                self.userLocation = location.coordinate
                manager.stopUpdatingLocation()
            }
        }
    }
}
