//
//  CellularUsageServiceTests.swift
//  CellularUsageServiceTests
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import XCTest
@testable import CellularUsageApp

final class CellularUsageServiceTests: XCTestCase {

    // MARK: - CellularUsageService Tests

    func testCellularUsageServiceGetCellularUsage() {
        // Given
        let service = CellularUsageService()

        // When
        let usage = service.getCellularUsage()

        // Then
        XCTAssertNotNil(usage)
        XCTAssertEqual(usage.balance, 145.50)
        XCTAssertEqual(usage.dataUsage.used, 2.3)
        XCTAssertEqual(usage.minutesUsage.used, 340)
        XCTAssertEqual(usage.smsUsage.used, 120)
    }

    // MARK: - MockCellularUsageService Tests

    func testMockCellularUsageServiceWithDefaultData() {
        // Given
        let mockService = MockCellularUsageService()

        // When
        let usage = mockService.getCellularUsage()

        // Then
        XCTAssertNotNil(usage)
        XCTAssertEqual(usage.balance, 145.50)
        XCTAssertEqual(usage.dataUsage.used, 2.3)
        XCTAssertEqual(usage.minutesUsage.used, 340)
        XCTAssertEqual(usage.smsUsage.used, 120)
    }

    func testMockCellularUsageServiceWithCustomData() {
        // Given
        let customData = CellularUsage(
            balance: 200.0,
            renewalDate: Date(),
            dataUsage: DataUsage(used: 1.5, total: 3.0),
            minutesUsage: MinutesUsage(used: 150, total: 500),
            smsUsage: SMSUsage(used: 50, total: 200)
        )
        let mockService = MockCellularUsageService(mockData: customData)

        // When
        let usage = mockService.getCellularUsage()

        // Then
        XCTAssertEqual(usage.balance, 200.0)
        XCTAssertEqual(usage.dataUsage.used, 1.5)
        XCTAssertEqual(usage.dataUsage.total, 3.0)
        XCTAssertEqual(usage.minutesUsage.used, 150)
        XCTAssertEqual(usage.minutesUsage.total, 500)
        XCTAssertEqual(usage.smsUsage.used, 50)
        XCTAssertEqual(usage.smsUsage.total, 200)
    }

    func testMockServiceDataMutation() {
        // Given
        let mockService = MockCellularUsageService()
        let newData = CellularUsage(
            balance: 300.0,
            renewalDate: Date(),
            dataUsage: DataUsage(used: 4.0, total: 10.0),
            minutesUsage: MinutesUsage(used: 800, total: 2000),
            smsUsage: SMSUsage(used: 300, total: 1000)
        )

        // When
        mockService.mockData = newData
        let usage = mockService.getCellularUsage()

        // Then
        XCTAssertEqual(usage.balance, 300.0)
        XCTAssertEqual(usage.dataUsage.used, 4.0)
        XCTAssertEqual(usage.minutesUsage.used, 800)
        XCTAssertEqual(usage.smsUsage.used, 300)
    }

    // MARK: - Protocol Conformance Tests

    func testServiceProtocolConformance() {
        // Given
        let service: CellularUsageServiceProtocol = CellularUsageService()
        let mockService: CellularUsageServiceProtocol = MockCellularUsageService()

        // When
        let serviceUsage = service.getCellularUsage()
        let mockUsage = mockService.getCellularUsage()

        // Then
        XCTAssertNotNil(serviceUsage)
        XCTAssertNotNil(mockUsage)

        // Both should return the same sample data
        XCTAssertEqual(serviceUsage.balance, mockUsage.balance)
        XCTAssertEqual(serviceUsage.dataUsage.used, mockUsage.dataUsage.used)
        XCTAssertEqual(serviceUsage.minutesUsage.used, mockUsage.minutesUsage.used)
        XCTAssertEqual(serviceUsage.smsUsage.used, mockUsage.smsUsage.used)
    }
}
