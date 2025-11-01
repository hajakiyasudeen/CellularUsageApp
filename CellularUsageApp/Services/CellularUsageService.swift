//
//  CellularUsageService.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import Foundation

// MARK: - Service Protocol for Dependency Injection

protocol CellularUsageServiceProtocol {
    func getCellularUsage() -> CellularUsage
}

// MARK: - Static Service Implementation

class CellularUsageService: CellularUsageServiceProtocol {

    func getCellularUsage() -> CellularUsage {
        return CellularUsage.sampleData
    }
}

// MARK: - Mock Service for Testing

class MockCellularUsageService: CellularUsageServiceProtocol {
    var mockData: CellularUsage

    init(mockData: CellularUsage = CellularUsage.sampleData) {
        self.mockData = mockData
    }

    func getCellularUsage() -> CellularUsage {
        return mockData
    }
}
