//
//  PlansService.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import Foundation

// MARK: - Plans Service Protocol

protocol PlansServiceProtocol {
    func getAvailablePlans() -> [Plan]
}

// MARK: - Production Service

class PlansService: PlansServiceProtocol {
    func getAvailablePlans() -> [Plan] {
        return [
            Plan(
                name: "Super 299",
                price: "₹299",
                priceAmount: 299,
                features: [
                    PlanFeature(iconName: "arrow.up.arrow.down", iconColor: .blue, text: "3GB/day"),
                    PlanFeature(iconName: "phone.fill", iconColor: .green, text: "1000 mins"),
                    PlanFeature(iconName: "envelope.fill", iconColor: .purple, text: "100 SMS")
                ]
            ),
            Plan(
                name: "Max 499",
                price: "₹499",
                priceAmount: 499,
                features: [
                    PlanFeature(iconName: "arrow.up.arrow.down", iconColor: .blue, text: "5GB/day"),
                    PlanFeature(iconName: "phone.fill", iconColor: .green, text: "Unlimited"),
                    PlanFeature(iconName: "envelope.fill", iconColor: .purple, text: "500 SMS")
                ],
                isPopular: true
            ),
            Plan(
                name: "Power 799",
                price: "₹799",
                priceAmount: 799,
                features: [
                    PlanFeature(iconName: "arrow.up.arrow.down", iconColor: .blue, text: "10GB/day"),
                    PlanFeature(iconName: "phone.fill", iconColor: .green, text: "Unlimited"),
                    PlanFeature(iconName: "envelope.fill", iconColor: .purple, text: "1000 SMS")
                ],
                isPopular: false
            )
        ]
    }

}

// MARK: - Mock Service for Testing

class MockPlansService: PlansServiceProtocol {
    private let mockPlans: [Plan]

    init(mockPlans: [Plan]? = nil) {
        self.mockPlans = mockPlans ?? [
            Plan(
                name: "Test Plan",
                price: "₹199",
                priceAmount: 199,
                features: [
                    PlanFeature(iconName: "arrow.up.arrow.down", iconColor: .blue, text: "1GB/day")
                ]
            )
        ]
    }

    func getAvailablePlans() -> [Plan] {
        return mockPlans
    }
}
