//
//  CellularUsageView.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import SwiftUI

struct CellularUsageView: View {
    @StateObject private var viewModel = CellularUsageViewModel()
    @State private var selectedTab = 0 // 0 for My Usage, 1 for Plans & Offers

    var body: some View {
        NavigationView {
            ZStack {
                // Background that adapts to color scheme
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        HeaderView()

                        // Balance and Renewal Cards
                        HStack(spacing: 15) {
                            BalanceCardView(viewModel: viewModel.balanceViewModel)
                            RenewalCardView(viewModel: viewModel.renewalViewModel)
                        }
                        .padding(.horizontal)

                        // Segmented Control
                        Picker("", selection: $selectedTab) {
                            Text("MY USAGE").tag(0)
                            Text("PLANS & OFFERS").tag(1)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)

                        // Content based on selected tab
                        if selectedTab == 0 {
                            // My Usage Content - Using List Approach
                            VStack(spacing: 0) {
                                ForEach(viewModel.usageItems) { item in
                                    GenericUsageCardView(item: item)
                                        .padding(.horizontal)
                                        .padding(.bottom, 15)
                                }

                                // Special Offers - Horizontal Scroll
                                SpecialOffersScrollView()
                                    .padding(.top, 10)
                            }
                        } else {
                            // Plans & Offers Content
                            PlansOffersView()
                        }

                        // Footer
                        Text("© 2025 Cellular Services")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.top, 20)

//                        // Bottom padding for last card
//                        Spacer(minLength: 20)
                    }
                    .padding(.bottom, 10)
                }
            }
        }
        .navigationBarHidden(true)
        .refreshable {
            viewModel.refreshData()
        }
    }
}

// MARK: - Preview

struct CellularUsageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Light mode preview
            CellularUsageView()
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")

            // Dark mode preview
            CellularUsageView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
