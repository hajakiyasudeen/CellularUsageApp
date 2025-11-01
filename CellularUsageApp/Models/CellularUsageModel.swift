//
//  CellularUsageModel.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import Foundation

// MARK: - Core Data Models

struct CellularUsage {
    let id: UUID
    let balance: Double
    let renewalDate: Date
    let dataUsage: DataUsage
    let minutesUsage: MinutesUsage
    let smsUsage: SMSUsage

    init(
        id: UUID = UUID(),
        balance: Double,
        renewalDate: Date,
        dataUsage: DataUsage,
        minutesUsage: MinutesUsage,
        smsUsage: SMSUsage
    ) {
        self.id = id
        self.balance = balance
        self.renewalDate = renewalDate
        self.dataUsage = dataUsage
        self.minutesUsage = minutesUsage
        self.smsUsage = smsUsage
    }
}

struct DataUsage {
    let used: Double // GB
    let total: Double // GB

    var usedPercentage: Double {
        guard total > 0 else { return 0 }
        return used / total
    }

    var remaining: Double {
        return max(0, total - used)
    }

    var usedPercentageInt: Int {
        return Int(usedPercentage * 100)
    }
}

struct MinutesUsage {
    let used: Int // minutes
    let total: Int // minutes

    var usedPercentage: Double {
        guard total > 0 else { return 0 }
        return Double(used) / Double(total)
    }

    var remaining: Int {
        return max(0, total - used)
    }

    var usedPercentageInt: Int {
        return Int(usedPercentage * 100)
    }
}

struct SMSUsage {
    let used: Int // messages
    let total: Int // messages

    var usedPercentage: Double {
        guard total > 0 else { return 0 }
        return Double(used) / Double(total)
    }

    var remaining: Int {
        return max(0, total - used)
    }

    var usedPercentageInt: Int {
        return Int(usedPercentage * 100)
    }
}

// MARK: - Extensions for Formatting

extension CellularUsage {
    var formattedBalance: String {
        return "₹\(String(format: "%.2f", balance))"
    }

    var formattedRenewalDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: renewalDate)
    }

    var isRenewalTomorrow: Bool {
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        return calendar.isDate(renewalDate, inSameDayAs: tomorrow)
    }
}

extension DataUsage {
    var formattedUsed: String {
        return String(format: "%.1f", used)
    }

    var formattedTotal: String {
        return String(format: "%.0f", total)
    }

    var formattedRemaining: String {
        return "\(String(format: "%.1f", remaining)) GB left"
    }
}

extension MinutesUsage {
    var formattedRemaining: String {
        return "\(String(format: "%.1f", Double(remaining))) mins left"
    }
}

// MARK: - Sample Data

extension CellularUsage {
    static let sampleData = CellularUsage(
        balance: 145.50,
        renewalDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date(),
        dataUsage: DataUsage(used: 2.3, total: 5.0),
        minutesUsage: MinutesUsage(used: 340, total: 1000),
        smsUsage: SMSUsage(used: 120, total: 500)
    )
}
