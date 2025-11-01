//
//  PlanModel.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import SwiftUI

// MARK: - Plan Models

struct Plan: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let price: String
    let priceAmount: Int
    let features: [PlanFeature]
    let isPopular: Bool
    let buttonColor: Color
    let borderColor: Color

    init(name: String, price: String, priceAmount: Int, features: [PlanFeature], isPopular: Bool = false) {
        self.name = name
        self.price = price
        self.priceAmount = priceAmount
        self.features = features
        self.isPopular = isPopular
        self.buttonColor = isPopular ? .blue : .gray
        self.borderColor = isPopular ? .blue : Color(.separator)
    }
}

struct PlanFeature: Identifiable, Hashable {
    let id = UUID()
    let iconName: String
    let iconColor: Color
    let text: String
}


