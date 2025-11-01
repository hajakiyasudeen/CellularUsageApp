//
//  BalanceCardView.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import SwiftUI

struct BalanceCardView: View {
    let viewModel: BalanceViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Balance")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)

            Text(viewModel.formattedBalance)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.green)
        }
        .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
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

struct BalanceCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BalanceCardView(
                viewModel: BalanceViewModel(usage: CellularUsage.sampleData)
            )
            .preferredColorScheme(.light)
            .previewDisplayName("Light Mode")

            BalanceCardView(
                viewModel: BalanceViewModel(usage: CellularUsage.sampleData)
            )
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
