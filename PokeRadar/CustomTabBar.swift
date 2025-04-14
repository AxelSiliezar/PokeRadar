//
//  CustomTabBar.swift
//  PokeRadar
//
//  Created by Axel Siliezar on 4/13/25.
//

import Foundation
import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let icons = ["person.3.fill", "display", "pokeball-icon", "magnifyingglass", "person.crop.circle"]

    var body: some View {
        HStack {
            ForEach(0..<icons.count, id: \.self) { index in
                Spacer()
                Button(action: {
                    withAnimation {
                        selectedTab = index
                    }
                }) {
                    if icons[index] == "pokeball-icon" {
                        Image(icons[index]) // Use custom asset
                            .resizable()
                            .frame(width: 20, height: 20) // Smaller size
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                            .padding(5) // Smaller padding
                    } else {
                        Image(systemName: icons[index]) // Use SF Symbols
                            .font(.system(size: 20)) // Smaller font size
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                            .padding(5) // Smaller padding
                    }
                }
                Spacer()
            }
        }
        .padding(.vertical, 5) // Reduced vertical padding
        .padding(.horizontal, 15) // Adjust horizontal padding if needed
        .background(Color.white)
        .cornerRadius(20) // Adjusted corner radius
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2) // Adjusted shadow
        .padding(.horizontal, 20)
    }
}
