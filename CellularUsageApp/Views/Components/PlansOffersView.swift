//
//  PlansOffersView.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import SwiftUI

struct PlansOffersView: View {
    @StateObject private var viewModel = PlansViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // Header
            SectionHeaderView(
                title: "Available Plans (\(viewModel.plans.count))",
                subtitle: "Choose the perfect plan"
            )

            // Plans
            LazyVStack(spacing: 15) {
                ForEach(viewModel.plans) { plan in
                    PlanCardView(plan: plan)
                }
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            print("PlansOffersView appeared. Plans count: \(viewModel.plans.count)")
        }
    }
}

// MARK: - Supporting Views

struct SectionHeaderView: View {
    let title: String
    let subtitle: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}

struct PlanCardView: View {
    let plan: Plan

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(plan.name)
                        .font(.title2)
                        .fontWeight(.bold)

                    Text(plan.price)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }

                Spacer()

                if plan.isPopular {
                    Text("Popular")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                ForEach(plan.features) { feature in
                    HStack {
                        Image(systemName: feature.iconName)
                            .foregroundColor(feature.iconColor)
                        Text(feature.text)
                            .font(.subheadline)
                    }
                }
            }

            Button(action: {
                // Subscribe action
            }) {
                Text("SUBSCRIBE")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(plan.buttonColor)
                    .cornerRadius(8)
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(plan.borderColor, lineWidth: plan.isPopular ? 1.5 : 0.5)
        }
    }
}


struct PlansOffersView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlansOffersView()
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")

            PlansOffersView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
