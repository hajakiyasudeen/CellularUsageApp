//
//  SpecialOffersViewModelTests.swift
//  SpecialOffersViewModelTests
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import XCTest
@testable import CellularUsageApp

@MainActor
final class SpecialOffersViewModelTests: XCTestCase {

    var viewModel: SpecialOffersViewModel!
    var mockService: MockSpecialOffersService!

    override func setUp() {
        super.setUp()
        mockService = MockSpecialOffersService()
        viewModel = SpecialOffersViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    // MARK: - Initialization Tests

    func testInitialization() {
        // Then
        XCTAssertNotNil(viewModel.specialOffers)
        XCTAssertGreaterThan(viewModel.specialOffers.count, 0)
    }

    func testInitializationWithDefaultService() {
        // Given
        let defaultViewModel = SpecialOffersViewModel()

        // Then
        XCTAssertNotNil(defaultViewModel.specialOffers)
    }

    // MARK: - Data Loading Tests

    func testLoadSpecialOffersFromService() {
        // When
        let offers = viewModel.specialOffers

        // Then
        XCTAssertEqual(offers.count, 1)
        XCTAssertEqual(offers.first?.title, "Test Offer")
        XCTAssertEqual(offers.first?.description, "Test description")
        XCTAssertEqual(offers.first?.badgeText, "Test")
    }

    // MARK: - Refresh Data Tests

    func testRefreshData() {
        // Given
        let customOffers = [
            SpecialOffer(
                title: "Custom Offer",
                description: "Custom description",
                badgeText: "NEW",
                badgeColor: .red,
                backgroundColor: .red.opacity(0.05),
                borderColor: .red.opacity(0.3)
            )
        ]

        let customMockService = MockSpecialOffersService(mockOffers: customOffers)
        let customViewModel = SpecialOffersViewModel(service: customMockService)

        // When
        customViewModel.refreshData()

        // Then
        XCTAssertEqual(customViewModel.specialOffers.count, 1)
        XCTAssertEqual(customViewModel.specialOffers.first?.title, "Custom Offer")
    }

    // MARK: - Dependency Injection Tests

    func testDependencyInjection() {
        // Given
        let customOffers = [
            SpecialOffer(
                title: "DI Test Offer",
                description: "DI Test description",
                badgeText: "DI",
                badgeColor: .purple,
                backgroundColor: .purple.opacity(0.05),
                borderColor: .purple.opacity(0.3)
            )
        ]

        let diMockService = MockSpecialOffersService(mockOffers: customOffers)

        // When
        let diViewModel = SpecialOffersViewModel(service: diMockService)

        // Then
        XCTAssertEqual(diViewModel.specialOffers.count, 1)
        XCTAssertEqual(diViewModel.specialOffers.first?.title, "DI Test Offer")
        XCTAssertEqual(diViewModel.specialOffers.first?.badgeText, "DI")
    }

    // MARK: - Model Validation Tests

    func testSpecialOfferModelValidation() {
        // When
        let offers = viewModel.specialOffers

        // Then
        for offer in offers {
            XCTAssertFalse(offer.title.isEmpty)
            XCTAssertFalse(offer.description.isEmpty)
            XCTAssertFalse(offer.badgeText.isEmpty)
            XCTAssertNotNil(offer.badgeColor)
            XCTAssertNotNil(offer.backgroundColor)
            XCTAssertNotNil(offer.borderColor)
        }
    }
}
