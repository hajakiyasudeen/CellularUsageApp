//
//  HeaderView.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import SwiftUI

struct HeaderView: View {
    @State private var showingSettings = false

    var body: some View {
        HStack {
            Spacer()

            VStack(spacing: 2) {
                Text("Cellular Usage")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }

            Spacer()

            Button(action: {
                showingSettings = true
            }) {
                Image(systemName: "gearshape.fill")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}
