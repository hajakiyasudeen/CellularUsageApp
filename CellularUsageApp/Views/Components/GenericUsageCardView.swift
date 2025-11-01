//
//  GenericUsageCardView.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import SwiftUI

struct GenericUsageCardView: View {
    let item: UsageCardItem

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: item.data.iconName)
                        .font(.title2)
                        .foregroundColor(item.data.iconColor)

                    Text(item.data.title)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }

                Spacer()

                Text(item.data.usagePercentageText)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }

            // Usage display
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(item.data.usedText)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text(item.data.totalText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            // Progress bar
            ProgressView(value: min(item.data.usagePercentage, 1.0))
                .progressViewStyle(CustomProgressViewStyle())

            // Remaining text (if available)
            if let remainingText = item.data.remainingText {
                Text(remainingText)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.separator), lineWidth: 0.5)
        }
    }
}

struct GenericUsageCardView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = CellularUsage.sampleData
        let viewModel = CellularUsageViewModel(service: MockCellularUsageService(mockData: sampleData))

        Group {
            GenericUsageCardView(
                item: UsageCardItem(
                    type: .data,
                    data: viewModel.dataUsageViewModel
                )
            )
            .preferredColorScheme(.light)
            .previewDisplayName("Data Card - Light Mode")

            GenericUsageCardView(
                item: UsageCardItem(
                    type: .minutes,
                    data: viewModel.minutesUsageViewModel
                )
            )
            .preferredColorScheme(.dark)
            .previewDisplayName("Minutes Card - Dark Mode")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
