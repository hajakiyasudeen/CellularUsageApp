//
//  SpecialOffersScrollView.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import SwiftUI

struct SpecialOffersScrollView: View {
    @StateObject private var viewModel = SpecialOffersViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Special Offers")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.specialOffers) { offer in
                        SpecialOfferCardView(offer: offer)
                            .frame(width: 280) // Fixed width for horizontal scrolling
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct SpecialOfferCardView: View {
    let offer: SpecialOffer

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(offer.title)
                    .font(.title3)
                    .fontWeight(.bold)

                Spacer()

                HStack {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundColor(offer.badgeColor)
                    Text(offer.badgeText)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(offer.badgeColor)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(offer.badgeColor.opacity(0.1))
                .cornerRadius(12)
            }

            Text(offer.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)

            Button(action: {
                // View offer action
            }) {
                Text("VIEW OFFER")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(offer.badgeColor)
                    .cornerRadius(8)
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(offer.backgroundColor)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(offer.borderColor, lineWidth: 1)
        }
    }
}

struct SpecialOffersScrollView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialOffersScrollView()
            .previewLayout(.sizeThatFits)
    }
}
