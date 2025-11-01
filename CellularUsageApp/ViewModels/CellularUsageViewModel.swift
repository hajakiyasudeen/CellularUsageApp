//
//  CellularUsageViewModel.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import Foundation
import SwiftUI

// MARK: - Main ViewModel

@MainActor
class CellularUsageViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var cellularUsage: CellularUsage

    // MARK: - Private Properties
    private let service: CellularUsageServiceProtocol

    // MARK: - Computed Properties
    var balanceViewModel: BalanceViewModel {
        return BalanceViewModel(usage: cellularUsage)
    }

    var renewalViewModel: RenewalViewModel {
        return RenewalViewModel(usage: cellularUsage)
    }

    // MARK: - Generic Usage ViewModels
    var dataUsageViewModel: UsageViewModel {
        return UsageViewModel(dataUsage: cellularUsage.dataUsage)
    }

    var minutesUsageViewModel: UsageViewModel {
        return UsageViewModel(minutesUsage: cellularUsage.minutesUsage)
    }

    var smsUsageViewModel: UsageViewModel {
        return UsageViewModel(smsUsage: cellularUsage.smsUsage)
    }

    // MARK: - Usage Items for List
    var usageItems: [UsageCardItem] {
        return [
            UsageCardItem(type: .data, data: dataUsageViewModel),
            UsageCardItem(type: .minutes, data: minutesUsageViewModel),
            UsageCardItem(type: .sms, data: smsUsageViewModel)
        ]
    }

    // MARK: - Initialization with Dependency Injection
    init(service: CellularUsageServiceProtocol = CellularUsageService()) {
        self.service = service
        self.cellularUsage = service.getCellularUsage()
    }

    // MARK: - Public Methods
    func refreshData() {
        cellularUsage = service.getCellularUsage()
    }
}

// MARK: - Balance ViewModel

struct BalanceViewModel {
    private let usage: CellularUsage

    init(usage: CellularUsage) {
        self.usage = usage
    }

    var formattedBalance: String {
        usage.formattedBalance
    }

    var balanceColor: String {
        return "green"
    }
}

// MARK: - Renewal ViewModel

struct RenewalViewModel {
    private let usage: CellularUsage

    init(usage: CellularUsage) {
        self.usage = usage
    }

    var formattedDate: String {
        usage.formattedRenewalDate
    }

    var renewalDescription: String {
        usage.isRenewalTomorrow ? "Tomorrow" : "Upcoming"
    }

    var dateColor: String {
        return "red"
    }
}

// MARK: - Generic Usage ViewModel

struct UsageViewModel: UsageCardDataProtocol {
    private let type: UsageCardType
    private let used: Double
    private let total: Double
    private let usedFormatted: String
    private let totalFormatted: String
    private let remainingFormatted: String?

    // MARK: - Initializers for different usage types

    init(dataUsage: DataUsage) {
        self.type = .data
        self.used = dataUsage.used
        self.total = dataUsage.total
        self.usedFormatted = dataUsage.formattedUsed
        self.totalFormatted = "\(dataUsage.formattedTotal) GB"
        self.remainingFormatted = dataUsage.formattedRemaining
    }

    init(minutesUsage: MinutesUsage) {
        self.type = .minutes
        self.used = Double(minutesUsage.used)
        self.total = Double(minutesUsage.total)
        self.usedFormatted = "\(minutesUsage.used)"
        self.totalFormatted = "\(minutesUsage.total) mins"
        self.remainingFormatted = minutesUsage.formattedRemaining
    }

    init(smsUsage: SMSUsage) {
        self.type = .sms
        self.used = Double(smsUsage.used)
        self.total = Double(smsUsage.total)
        self.usedFormatted = "\(smsUsage.used)"
        self.totalFormatted = "\(smsUsage.total) msgs"
        self.remainingFormatted = "\(smsUsage.remaining) msgs left"
    }

    // MARK: - Protocol Implementation

    var title: String {
        type.rawValue
    }

    var iconName: String {
        type.iconName
    }

    var iconColor: Color {
        switch type {
        case .data: return .blue
        case .minutes: return .green
        case .sms: return .purple
        }
    }

    var usedText: String {
        usedFormatted
    }

    var totalText: String {
        "/ \(totalFormatted)"
    }

    var remainingText: String? {
        remainingFormatted
    }

    var usagePercentage: Double {
        guard total > 0 else { return 0.0 }
        return used / total
    }

    var usagePercentageText: String {
        let percentage = Int(usagePercentage * 100)
        return "\(percentage)% used"
    }
}
