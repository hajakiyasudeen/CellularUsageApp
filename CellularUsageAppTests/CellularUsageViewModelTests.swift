//
//  CellularUsageViewModelTests.swift
//  CellularUsageViewModelTests
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import XCTest
@testable import CellularUsageApp

@MainActor
final class CellularUsageViewModelTests: XCTestCase {

    var viewModel: CellularUsageViewModel!
    var mockService: MockCellularUsageService!

    override func setUp() {
        super.setUp()
        mockService = MockCellularUsageService()
        viewModel = CellularUsageViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    // MARK: - Initialization Tests

    func testInitialization() {
        // Then
        XCTAssertNotNil(viewModel.cellularUsage)
        XCTAssertEqual(viewModel.cellularUsage.balance, 145.50)
        XCTAssertEqual(viewModel.cellularUsage.dataUsage.used, 2.3)
        XCTAssertEqual(viewModel.cellularUsage.minutesUsage.used, 340)
        XCTAssertEqual(viewModel.cellularUsage.smsUsage.used, 120)
    }

    func testInitializationWithCustomData() {
        // Given
        let customData = CellularUsage(
            balance: 200.0,
            renewalDate: Date(),
            dataUsage: DataUsage(used: 1.5, total: 3.0),
            minutesUsage: MinutesUsage(used: 150, total: 500),
            smsUsage: SMSUsage(used: 50, total: 200)
        )
        let customMockService = MockCellularUsageService(mockData: customData)

        // When
        let customViewModel = CellularUsageViewModel(service: customMockService)

        // Then
        XCTAssertEqual(customViewModel.cellularUsage.balance, 200.0)
        XCTAssertEqual(customViewModel.cellularUsage.dataUsage.used, 1.5)
        XCTAssertEqual(customViewModel.cellularUsage.minutesUsage.used, 150)
        XCTAssertEqual(customViewModel.cellularUsage.smsUsage.used, 50)
    }

    // MARK: - BalanceViewModel Tests

    func testBalanceViewModel() {
        // When
        let balanceViewModel = viewModel.balanceViewModel

        // Then
        XCTAssertEqual(balanceViewModel.formattedBalance, "₹145.50")
        XCTAssertEqual(balanceViewModel.balanceColor, "green")
    }

    // MARK: - RenewalViewModel Tests

    func testRenewalViewModel() {
        // When
        let renewalViewModel = viewModel.renewalViewModel

        // Then
        XCTAssertNotNil(renewalViewModel.formattedDate)
        XCTAssertEqual(renewalViewModel.renewalDescription, "Tomorrow")
        XCTAssertEqual(renewalViewModel.dateColor, "red")
    }

    // MARK: - Generic UsageViewModel Tests (Data)

    func testDataUsageViewModel() {
        // When
        let dataViewModel = viewModel.dataUsageViewModel

        // Then
        XCTAssertEqual(dataViewModel.iconName, "arrow.up.arrow.down")
        XCTAssertEqual(dataViewModel.iconColor, .blue)
        XCTAssertEqual(dataViewModel.title, "Data")
        XCTAssertEqual(dataViewModel.usedText, "2.3")
        XCTAssertEqual(dataViewModel.totalText, "/ 5 GB")
        XCTAssertEqual(dataViewModel.remainingText, "2.7 GB left")
        XCTAssertEqual(dataViewModel.usagePercentage, 0.46, accuracy: 0.01)
        XCTAssertEqual(dataViewModel.usagePercentageText, "46% used")
    }

    // MARK: - Generic UsageViewModel Tests (Minutes)

    func testMinutesUsageViewModel() {
        // When
        let minutesViewModel = viewModel.minutesUsageViewModel

        // Then
        XCTAssertEqual(minutesViewModel.iconName, "phone.fill")
        XCTAssertEqual(minutesViewModel.iconColor, .green)
        XCTAssertEqual(minutesViewModel.title, "Minutes")
        XCTAssertEqual(minutesViewModel.usedText, "340")
        XCTAssertEqual(minutesViewModel.totalText, "/ 1000 mins")
        XCTAssertEqual(minutesViewModel.remainingText, "660.0 mins left")
        XCTAssertEqual(minutesViewModel.usagePercentage, 0.34, accuracy: 0.01)
        XCTAssertEqual(minutesViewModel.usagePercentageText, "34% used")
    }

    // MARK: - Generic UsageViewModel Tests (SMS)

    func testSMSUsageViewModel() {
        // When
        let smsViewModel = viewModel.smsUsageViewModel

        // Then
        XCTAssertEqual(smsViewModel.iconName, "envelope.fill")
        XCTAssertEqual(smsViewModel.iconColor, .purple)
        XCTAssertEqual(smsViewModel.title, "SMS")
        XCTAssertEqual(smsViewModel.usedText, "120")
        XCTAssertEqual(smsViewModel.totalText, "/ 500 msgs")
        XCTAssertEqual(smsViewModel.usagePercentage, 0.24, accuracy: 0.01)
        XCTAssertEqual(smsViewModel.usagePercentageText, "24% used")
    }

    // MARK: - RefreshData Tests

    func testRefreshData() {
        // Given
        let newData = CellularUsage(
            balance: 100.0,
            renewalDate: Date(),
            dataUsage: DataUsage(used: 3.0, total: 5.0),
            minutesUsage: MinutesUsage(used: 500, total: 1000),
            smsUsage: SMSUsage(used: 200, total: 500)
        )
        mockService.mockData = newData

        // When
        viewModel.refreshData()

        // Then
        XCTAssertEqual(viewModel.cellularUsage.balance, 100.0)
        XCTAssertEqual(viewModel.cellularUsage.dataUsage.used, 3.0)
        XCTAssertEqual(viewModel.cellularUsage.minutesUsage.used, 500)
        XCTAssertEqual(viewModel.cellularUsage.smsUsage.used, 200)
    }

    // MARK: - Generic ViewModel Architecture Tests

    func testGenericViewModelArchitecture() {
        // Given - Test that all usage ViewModels use the same generic type
        let dataViewModel = viewModel.dataUsageViewModel
        let minutesViewModel = viewModel.minutesUsageViewModel
        let smsViewModel = viewModel.smsUsageViewModel

        // When & Then - All should be of type UsageViewModel
        XCTAssertTrue(dataViewModel is UsageViewModel)
        XCTAssertTrue(minutesViewModel is UsageViewModel)
        XCTAssertTrue(smsViewModel is UsageViewModel)

        // Test that each has correct type-specific data
        XCTAssertEqual(dataViewModel.title, "Data")
        XCTAssertEqual(minutesViewModel.title, "Minutes")
        XCTAssertEqual(smsViewModel.title, "SMS")

        // Test that colors are type-specific
        XCTAssertEqual(dataViewModel.iconColor, .blue)
        XCTAssertEqual(minutesViewModel.iconColor, .green)
        XCTAssertEqual(smsViewModel.iconColor, .purple)
    }

    func testUsageItemsArray() {
        // When
        let usageItems = viewModel.usageItems

        // Then
        XCTAssertEqual(usageItems.count, 3)
        XCTAssertEqual(usageItems[0].type, .data)
        XCTAssertEqual(usageItems[1].type, .minutes)
        XCTAssertEqual(usageItems[2].type, .sms)

        // Test that data flows correctly through the generic approach
        XCTAssertEqual(usageItems[0].data.title, "Data")
        XCTAssertEqual(usageItems[1].data.title, "Minutes")
        XCTAssertEqual(usageItems[2].data.title, "SMS")
    }

    // MARK: - Dependency Injection Tests

    func testDependencyInjection() {
        // Given
        let customData = CellularUsage(
            balance: 300.0,
            renewalDate: Date(),
            dataUsage: DataUsage(used: 4.0, total: 10.0),
            minutesUsage: MinutesUsage(used: 800, total: 2000),
            smsUsage: SMSUsage(used: 300, total: 1000)
        )
        let customService = MockCellularUsageService(mockData: customData)

        // When
        let testViewModel = CellularUsageViewModel(service: customService)

        // Then
        XCTAssertEqual(testViewModel.cellularUsage.balance, 300.0)
        XCTAssertEqual(testViewModel.dataUsageViewModel.usagePercentage, 0.4, accuracy: 0.01)
        XCTAssertEqual(testViewModel.minutesUsageViewModel.usagePercentage, 0.4, accuracy: 0.01)
        XCTAssertEqual(testViewModel.smsUsageViewModel.usagePercentage, 0.3, accuracy: 0.01)
    }
}
