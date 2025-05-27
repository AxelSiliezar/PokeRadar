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
    let icons = ["magnifyingglass", "map", "camera"]

    var body: some View {
        HStack {
            ForEach(0..<icons.count, id: \.self) { index in
                Spacer()
                Button(action: {
                    withAnimation {
                        selectedTab = index
                    }
                }) {
                    Image(systemName: icons[index])
                        .font(.system(size: 20))
                        .foregroundColor(selectedTab == index ? .blue : .gray)
                        .padding(5)
                }
                Spacer()
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 15)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 20)
    }
}
