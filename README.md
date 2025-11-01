# Cellular Usage Demo App

A SwiftUI-based iOS application that displays cellular usage information with a clean, modern interface following MVVM architecture.

## 📱 Features

- **Balance Display**: Shows current account balance
- **Renewal Information**: Displays next renewal date
- **Data Usage**: Visual progress indicator for data consumption
- **Minutes Usage**: Call time tracking with progress
- **SMS Usage**: Message count with usage percentage
- **Pull-to-Refresh**: Refresh data with pull gesture
- **Loading States**: Proper loading and error handling

## 🏗️ Architecture

The app follows **MVVM (Model-View-ViewModel)** architecture pattern:

### Models
- `CellularUsageModel.swift` - Data structures and business logic

### Views
- `CellularUsageView.swift` - Main usage display
- `ContentView.swift` - Root view
- **Components/**
  - `HeaderView.swift`
  - `BalanceCardView.swift`
  - `RenewalCardView.swift`
  - `SectionHeadersView.swift`
  - `DataUsageCardView.swift`
  - `MinutesUsageCardView.swift`
  - `SMSUsageCardView.swift`

### ViewModels
- `CellularUsageViewModel.swift` - State management and business logic

### Services
- `CellularUsageService.swift` - Data fetching and API layer

### Utilities
- `CustomProgressViewStyle.swift` - Custom UI components

## 🚀 Getting Started

1. Open `CellularUsageApp.xcodeproj` in Xcode
2. Select a target device or simulator
3. Press `Cmd + R` to build and run

## 📋 Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.0+

## 🎨 Design

The UI matches the provided Figma design with:
- Card-based layout
- Blue progress indicators
- Proper color scheme (green for balance, red for renewal)
- Clean typography and spacing

## 🧪 Testing

The project includes mock services for easy testing and development.