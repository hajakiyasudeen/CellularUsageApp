//
//  PlansViewModelTests.swift
//  PlansViewModelTests
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import XCTest
@testable import CellularUsageApp

@MainActor
final class PlansViewModelTests: XCTestCase {

    var viewModel: PlansViewModel!
    var mockService: MockPlansService!

    override func setUp() {
        super.setUp()
        mockService = MockPlansService()
        viewModel = PlansViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    // MARK: - Initialization Tests

    func testInitialization() {
        // Then
        XCTAssertNotNil(viewModel.plans)
        XCTAssertGreaterThan(viewModel.plans.count, 0)
    }

    func testInitializationWithDefaultService() {
        // Given
        let defaultViewModel = PlansViewModel()

        // Then
        XCTAssertNotNil(defaultViewModel.plans)
    }

    // MARK: - Data Loading Tests

    func testLoadPlansFromService() {
        // When
        let plans = viewModel.plans

        // Then
        XCTAssertEqual(plans.count, 1)
        XCTAssertEqual(plans.first?.name, "Test Plan")
        XCTAssertEqual(plans.first?.price, "₹199")
        XCTAssertEqual(plans.first?.priceAmount, 199)
    }

    // MARK: - Refresh Data Tests

    func testRefreshData() {
        // Given
        let customPlans = [
            Plan(
                name: "Custom Plan",
                price: "₹399",
                priceAmount: 399,
                features: [
                    PlanFeature(iconName: "arrow.up.arrow.down", iconColor: .blue, text: "5GB/day")
                ]
            )
        ]

        let customMockService = MockPlansService(mockPlans: customPlans)
        let customViewModel = PlansViewModel(service: customMockService)

        // When
        customViewModel.refreshData()

        // Then
        XCTAssertEqual(customViewModel.plans.count, 1)
        XCTAssertEqual(customViewModel.plans.first?.name, "Custom Plan")
    }

    // MARK: - Dependency Injection Tests

    func testDependencyInjection() {
        // Given
        let customPlans = [
            Plan(
                name: "DI Test Plan",
                price: "₹599",
                priceAmount: 599,
                features: []
            )
        ]

        let diMockService = MockPlansService(mockPlans: customPlans)

        // When
        let diViewModel = PlansViewModel(service: diMockService)

        // Then
        XCTAssertEqual(diViewModel.plans.count, 1)
        XCTAssertEqual(diViewModel.plans.first?.name, "DI Test Plan")
        XCTAssertEqual(diViewModel.plans.first?.priceAmount, 599)
    }

    // MARK: - Model Validation Tests

    func testPlanModelValidation() {
        // When
        let plans = viewModel.plans

        // Then
        for plan in plans {
            XCTAssertFalse(plan.name.isEmpty)
            XCTAssertFalse(plan.price.isEmpty)
            XCTAssertGreaterThan(plan.priceAmount, 0)
            XCTAssertNotNil(plan.buttonColor)
            XCTAssertNotNil(plan.borderColor)
        }
    }
}
