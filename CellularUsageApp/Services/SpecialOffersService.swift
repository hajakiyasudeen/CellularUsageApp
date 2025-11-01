//
//  SpecialOffersService.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import Foundation

// MARK: - Special Offers Service Protocol

protocol SpecialOffersServiceProtocol {
    func getSpecialOffers() -> [SpecialOffer]
}

// MARK: - Production Service

class SpecialOffersService: SpecialOffersServiceProtocol {
    func getSpecialOffers() -> [SpecialOffer] {
        return [
            SpecialOffer(
                title: "Super Saver 499",
                description: "Get 5GB/day + unlimited calls. Limited time!",
                badgeText: "Trending",
                badgeColor: .blue,
                backgroundColor: .blue.opacity(0.05),
                borderColor: .blue.opacity(0.3)
            ),
            SpecialOffer(
                title: "Weekend Special",
                description: "Extra 2GB free on weekends. Perfect for streaming!",
                badgeText: "Limited",
                badgeColor: .orange,
                backgroundColor: .orange.opacity(0.05),
                borderColor: .orange.opacity(0.3)
            ),
            SpecialOffer(
                title: "Student Plan",
                description: "50% off for students. Verify with your student ID.",
                badgeText: "50% OFF",
                badgeColor: .green,
                backgroundColor: .green.opacity(0.05),
                borderColor: .green.opacity(0.3)
            )
        ]
    }
}

// MARK: - Mock Service for Testing

class MockSpecialOffersService: SpecialOffersServiceProtocol {
    private let mockOffers: [SpecialOffer]

    init(mockOffers: [SpecialOffer]? = nil) {
        self.mockOffers = mockOffers ?? [
            SpecialOffer(
                title: "Test Offer",
                description: "Test description",
                badgeText: "Test",
                badgeColor: .blue,
                backgroundColor: .blue.opacity(0.05),
                borderColor: .blue.opacity(0.3)
            )
        ]
    }

    func getSpecialOffers() -> [SpecialOffer] {
        return mockOffers
    }
}
