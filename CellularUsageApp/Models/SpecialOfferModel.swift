//
//  SpecialOfferModel.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import SwiftUI

// MARK: - Special Offer Model

struct SpecialOffer: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let badgeText: String
    let badgeColor: Color
    let backgroundColor: Color
    let borderColor: Color
}
