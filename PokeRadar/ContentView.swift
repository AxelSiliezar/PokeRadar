//
//  ContentView.swift
//  PokeRadar
//
//  Created by Axel Siliezar on 4/3/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 2 // Default to the center icon
    @State private var searchText = ""

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Main content based on selected tab
                Group {
                    if selectedTab == 0 {
                        PokemonCardSearchView()
                    } else if selectedTab == 1 {
                        CardScannerView()
                    } else if selectedTab == 2 {
                        MapView(searchText: $searchText) // Home page
                    } else if selectedTab == 3 {
                        Text("Search View")
                            .font(.largeTitle)
                    } else if selectedTab == 4 {
                        Text("Profile View")
                            .font(.largeTitle)
                    }
                }
                .edgesIgnoringSafeArea(.all)

                // Floating Tab Bar
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                        .padding(.bottom, 20) // Adjust bottom padding
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
