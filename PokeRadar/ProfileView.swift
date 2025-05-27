//
//  ProfileView.swift
//  PokeRadar
//
//  Created by Axel Siliezar on 5/26/25.
//

import SwiftUI

struct ProfileView: View {
    var onBack: () -> Void

    var body: some View {
        NavigationView {
            VStack {
                // Profile picture
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding()

                // First and last name fields
                VStack(spacing: 20) {
                    TextField("First Name", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 40)

                    TextField("Last Name", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 40)
                }

                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        onBack()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}
