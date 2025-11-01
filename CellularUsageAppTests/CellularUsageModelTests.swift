//
//  CellularUsageModelTests.swift
//  CellularUsageModelTests
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import XCTest
@testable import CellularUsageApp

final class CellularUsageModelTests: XCTestCase {

    // MARK: - DataUsage Tests

    func testDataUsageCalculations() {
        // Given
        let dataUsage = DataUsage(used: 2.3, total: 5.0)

        // Then
        XCTAssertEqual(dataUsage.usedPercentage, 0.46, accuracy: 0.01)
        XCTAssertEqual(dataUsage.remaining, 2.7, accuracy: 0.01)
        XCTAssertEqual(dataUsage.usedPercentageInt, 46)
        XCTAssertEqual(dataUsage.formattedUsed, "2.3")
        XCTAssertEqual(dataUsage.formattedTotal, "5")
        XCTAssertEqual(dataUsage.formattedRemaining, "2.7 GB left")
    }

    func testDataUsageWithZeroTotal() {
        // Given
        let dataUsage = DataUsage(used: 1.0, total: 0.0)

        // Then
        XCTAssertEqual(dataUsage.usedPercentage, 0.0)
        XCTAssertEqual(dataUsage.remaining, 0.0)
        XCTAssertEqual(dataUsage.usedPercentageInt, 0)
    }

    func testDataUsageOverLimit() {
        // Given
        let dataUsage = DataUsage(used: 6.0, total: 5.0)

        // Then
        XCTAssertEqual(dataUsage.usedPercentage, 1.2, accuracy: 0.01)
        XCTAssertEqual(dataUsage.remaining, 0.0) // Should not go negative
        XCTAssertEqual(dataUsage.usedPercentageInt, 120)
    }

    // MARK: - MinutesUsage Tests

    func testMinutesUsageCalculations() {
        // Given
        let minutesUsage = MinutesUsage(used: 340, total: 1000)

        // Then
        XCTAssertEqual(minutesUsage.usedPercentage, 0.34, accuracy: 0.01)
        XCTAssertEqual(minutesUsage.remaining, 660)
        XCTAssertEqual(minutesUsage.usedPercentageInt, 34)
        XCTAssertEqual(minutesUsage.formattedRemaining, "660.0 mins left")
    }

    func testMinutesUsageWithZeroTotal() {
        // Given
        let minutesUsage = MinutesUsage(used: 100, total: 0)

        // Then
        XCTAssertEqual(minutesUsage.usedPercentage, 0.0)
        XCTAssertEqual(minutesUsage.remaining, 0)
        XCTAssertEqual(minutesUsage.usedPercentageInt, 0)
    }

    func testMinutesUsageOverLimit() {
        // Given
        let minutesUsage = MinutesUsage(used: 1200, total: 1000)

        // Then
        XCTAssertEqual(minutesUsage.usedPercentage, 1.2, accuracy: 0.01)
        XCTAssertEqual(minutesUsage.remaining, 0) // Should not go negative
        XCTAssertEqual(minutesUsage.usedPercentageInt, 120)
    }

    // MARK: - SMSUsage Tests

    func testSMSUsageCalculations() {
        // Given
        let smsUsage = SMSUsage(used: 120, total: 500)

        // Then
        XCTAssertEqual(smsUsage.usedPercentage, 0.24, accuracy: 0.01)
        XCTAssertEqual(smsUsage.remaining, 380)
        XCTAssertEqual(smsUsage.usedPercentageInt, 24)
    }

    func testSMSUsageWithZeroTotal() {
        // Given
        let smsUsage = SMSUsage(used: 50, total: 0)

        // Then
        XCTAssertEqual(smsUsage.usedPercentage, 0.0)
        XCTAssertEqual(smsUsage.remaining, 0)
        XCTAssertEqual(smsUsage.usedPercentageInt, 0)
    }

    func testSMSUsageOverLimit() {
        // Given
        let smsUsage = SMSUsage(used: 600, total: 500)

        // Then
        XCTAssertEqual(smsUsage.usedPercentage, 1.2, accuracy: 0.01)
        XCTAssertEqual(smsUsage.remaining, 0) // Should not go negative
        XCTAssertEqual(smsUsage.usedPercentageInt, 120)
    }

    // MARK: - CellularUsage Tests

    func testCellularUsageFormattedBalance() {
        // Given
        let cellularUsage = CellularUsage(
            balance: 145.50,
            renewalDate: Date(),
            dataUsage: DataUsage(used: 1.0, total: 5.0),
            minutesUsage: MinutesUsage(used: 100, total: 1000),
            smsUsage: SMSUsage(used: 50, total: 500)
        )

        // Then
        XCTAssertEqual(cellularUsage.formattedBalance, "₹145.50")
    }

    func testCellularUsageFormattedRenewalDate() {
        // Given
        let calendar = Calendar.current
        let testDate = calendar.date(from: DateComponents(year: 2025, month: 11, day: 1))!
        let cellularUsage = CellularUsage(
            balance: 100.0,
            renewalDate: testDate,
            dataUsage: DataUsage(used: 1.0, total: 5.0),
            minutesUsage: MinutesUsage(used: 100, total: 1000),
            smsUsage: SMSUsage(used: 50, total: 500)
        )

        // Then
        XCTAssertEqual(cellularUsage.formattedRenewalDate, "Nov 1, 2025")
    }

    func testCellularUsageIsRenewalTomorrow() {
        // Given
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())!
        let cellularUsage = CellularUsage(
            balance: 100.0,
            renewalDate: tomorrow,
            dataUsage: DataUsage(used: 1.0, total: 5.0),
            minutesUsage: MinutesUsage(used: 100, total: 1000),
            smsUsage: SMSUsage(used: 50, total: 500)
        )

        // Then
        XCTAssertTrue(cellularUsage.isRenewalTomorrow)
    }

    func testCellularUsageIsNotRenewalTomorrow() {
        // Given
        let calendar = Calendar.current
        let nextWeek = calendar.date(byAdding: .day, value: 7, to: Date())!
        let cellularUsage = CellularUsage(
            balance: 100.0,
            renewalDate: nextWeek,
            dataUsage: DataUsage(used: 1.0, total: 5.0),
            minutesUsage: MinutesUsage(used: 100, total: 1000),
            smsUsage: SMSUsage(used: 50, total: 500)
        )

        // Then
        XCTAssertFalse(cellularUsage.isRenewalTomorrow)
    }

    // MARK: - Sample Data Tests

    func testSampleData() {
        // Given
        let sampleData = CellularUsage.sampleData

        // Then
        XCTAssertEqual(sampleData.balance, 145.50)
        XCTAssertEqual(sampleData.dataUsage.used, 2.3)
        XCTAssertEqual(sampleData.dataUsage.total, 5.0)
        XCTAssertEqual(sampleData.minutesUsage.used, 340)
        XCTAssertEqual(sampleData.minutesUsage.total, 1000)
        XCTAssertEqual(sampleData.smsUsage.used, 120)
        XCTAssertEqual(sampleData.smsUsage.total, 500)
        XCTAssertNotNil(sampleData.id)
        XCTAssertNotNil(sampleData.renewalDate)
    }
}
