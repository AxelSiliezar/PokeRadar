//
//  ContentView.swift
//  PokeRadar
//
//  Created by Axel Siliezar on 4/3/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 1 // Default to the Map View
    @State private var searchText = ""
    @State private var showProfileView = false // Toggle for Profile View
    @State private var showSearchBar = false // Toggle for Search Bar

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Main content based on selected tab
                Group {
                    if showProfileView {
                        ProfileView(onBack: {
                            showProfileView = false
                        }) // Show Profile View
                    } else {
                        switch selectedTab {
                        case 0:
                            PokemonCardSearchView() // Left tab
                        case 1:
                            MapView(searchText: $searchText, showSearchBar: $showSearchBar) // Middle tab
                        case 2:
                            CardScannerView() // Right tab
                        default:
                            MapView(searchText: $searchText, showSearchBar: $showSearchBar) // Fallback to Map View
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)

                // Top buttons (conditionally displayed)
                if !showProfileView {
                    VStack {
                        HStack {
                            // Left button (Search Bar toggle)
                            Button(action: {
                                showSearchBar.toggle()
                                
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 24))
                                    .frame(width: 44, height: 44) // Uniform size
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                            }

                            Spacer()

                            // Right button (Profile toggle)
                            Button(action: {
                                showProfileView.toggle()
                            }) {
                                Image(systemName: "person.crop.circle")
                                    .font(.system(size: 24))
                                    .frame(width: 44, height: 44) // Uniform size
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        Spacer()
                    }
                }

                // Floating Tab Bar
                if !showProfileView {
                    VStack {
                        Spacer()
                        CustomTabBar(selectedTab: $selectedTab)
                            .padding(.bottom, 20) // Adjust bottom padding
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()

}
