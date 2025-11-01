//
//  RenewalCardView.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import SwiftUI

struct RenewalCardView: View {
    let viewModel: RenewalViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Renewal")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)

            Text(viewModel.formattedDate)
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(.red)

            Text(viewModel.renewalDescription)
                .font(.caption)
                .foregroundColor(.secondary)
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

struct RenewalCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RenewalCardView(
                viewModel: RenewalViewModel(usage: CellularUsage.sampleData)
            )
            .preferredColorScheme(.light)
            .previewDisplayName("Light Mode")

            RenewalCardView(
                viewModel: RenewalViewModel(usage: CellularUsage.sampleData)
            )
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
