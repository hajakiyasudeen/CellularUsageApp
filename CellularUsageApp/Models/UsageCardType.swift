//
//  UsageCardType.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import SwiftUI

// MARK: - Usage Card Type Enum
enum UsageCardType: String, CaseIterable, Identifiable {
    case data = "Data"
    case minutes = "Minutes"
    case sms = "SMS"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .data: return "arrow.up.arrow.down"
        case .minutes: return "phone.fill"
        case .sms: return "envelope.fill"
        }
    }

}

// MARK: - Generic Usage Card Data Protocol
protocol UsageCardDataProtocol {
    var title: String { get }
    var iconName: String { get }
    var iconColor: Color { get }
    var usedText: String { get }
    var totalText: String { get }
    var remainingText: String? { get }
    var usagePercentage: Double { get }
    var usagePercentageText: String { get }
}

// MARK: - Usage Card Item Model
struct UsageCardItem: Identifiable {
    let id = UUID()
    let type: UsageCardType
    let data: UsageCardDataProtocol
}
