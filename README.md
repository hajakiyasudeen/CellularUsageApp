# Cellular Usage App

A modern SwiftUI-based iOS application that displays cellular usage information, plan management, and special offers with a clean, intuitive interface following MVVM architecture and best practices.

## 📱 Features

### Core Features
- **Balance Display**: Current account balance with color-coded status indicators
- **Renewal Information**: Next renewal date with countdown and status
- **Usage Tracking**: Visual progress indicators for data, minutes, and SMS usage
- **Plan Management**: Interactive plan selection with subscription capabilities
- **Special Offers**: Horizontal scrolling special offer cards
- **Splash Screen**: Smooth app startup experience with branded design

### User Experience
- **Pull-to-Refresh**: Refresh data with intuitive pull gesture
- **Tab Navigation**: Switch between "My Usage" and "Plans" sections
- **Interactive Selection**: Visual feedback for plan selection with animations
- **Dark Mode Support**: Automatic adaptation to system color scheme
- **Loading States**: Proper loading and error handling throughout the app

## 🏗️ Architecture

The app follows **MVVM (Model-View-ViewModel)** architecture with **Protocol-Oriented Programming** and **Dependency Injection** for better testability and maintainability.

### 📁 Project Structure

```
CellularUsageApp/
├── 📱 CellularUsageAppApp.swift          # App entry point
├── 📊 Models/
│   ├── CellularUsageModel.swift          # Core usage data models
│   ├── PlanModel.swift                   # Plan and feature models
│   ├── SpecialOfferModel.swift           # Special offer models
│   └── UsageCardType.swift               # Usage card type definitions
├── 🎨 Views/
│   ├── CellularUsageView.swift           # Main dashboard view
│   ├── ContentView.swift                 # Root view controller
│   ├── MainAppView.swift                 # Main app container
│   ├── SplashScreenView.swift            # App launch screen
│   ├── SettingsView.swift                # Settings interface
│   └── Components/
│       ├── BalanceCardView.swift         # Account balance display
│       ├── RenewalCardView.swift         # Renewal information card
│       ├── HeaderView.swift              # App header component
│       ├── GenericUsageCardView.swift    # Reusable usage card
│       ├── PlansOffersView.swift         # Plans management interface
│       └── SpecialOffersScrollView.swift # Horizontal offers scroll
├── 🧠 ViewModels/
│   ├── CellularUsageViewModel.swift      # Main dashboard logic
│   ├── PlansViewModel.swift              # Plan selection and management
│   └── SpecialOffersViewModel.swift      # Special offers handling
├── 🔧 Services/
│   ├── CellularUsageService.swift        # Usage data service
│   ├── PlansService.swift                # Plans data service
│   └── SpecialOffersService.swift        # Special offers service
└── 🎛️ Utilities/
    └── CustomProgressViewStyle.swift     # Custom UI components

CellularUsageAppTests/
├── CellularUsageModelTests.swift         # Model layer tests
├── CellularUsageServiceTests.swift       # Service layer tests
├── CellularUsageViewModelTests.swift     # ViewModel tests
├── PlansViewModelTests.swift             # Plans ViewModel tests
└── SpecialOffersViewModelTests.swift     # Special offers tests
```

### 🏛️ Architecture Patterns

#### **MVVM Implementation**
- **Models**: Pure data structures with business logic
- **Views**: SwiftUI views focusing on UI presentation
- **ViewModels**: `@ObservableObject` classes managing state and business logic

#### **Protocol-Oriented Design**
```swift
protocol CellularUsageServiceProtocol {
    func getCurrentUsage() -> CellularUsage
}

protocol PlansServiceProtocol {
    func getAvailablePlans() -> [Plan]
}
```

#### **Dependency Injection**
All ViewModels accept protocol-based dependencies for easy testing:
```swift
class CellularUsageViewModel: ObservableObject {
    init(service: CellularUsageServiceProtocol = CellularUsageService()) {
        self.service = service
    }
}
```

#### **Generic Programming**
Eliminated code duplication with generic `UsageViewModel`:
```swift
struct UsageViewModel: UsageCardDataProtocol {
    init(dataUsage: DataUsage) { /* ... */ }
    init(minutesUsage: MinutesUsage) { /* ... */ }
    init(smsUsage: SMSUsage) { /* ... */ }
}
```

## 🧪 Testing

### Test Coverage
The project includes comprehensive unit tests covering:

- **Model Tests**: Data structure validation and business logic
- **Service Tests**: Data fetching and API layer with mock services
- **ViewModel Tests**: State management and user interaction logic
- **Dependency Injection Tests**: Proper protocol adherence and mocking

### Testing Strategy
- **Mock Services**: All services have mock implementations for testing
- **Dependency Injection**: Easy service swapping for test scenarios
- **XCTest Framework**: Standard iOS testing with async/await support
- **MainActor Testing**: Proper handling of UI-related async operations

### Running Tests
```bash
# Run all tests
⌘ + U in Xcode

# Run specific test target
xcodebuild test -scheme CellularUsageApp -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Test Examples
```swift
func testPlanSelection() {
    // Given
    let viewModel = PlansViewModel(service: MockPlansService())
    let plan = viewModel.plans.first!

    // When
    viewModel.selectPlan(plan)

    // Then
    XCTAssertTrue(viewModel.isSelected(plan))
}
```

## 🚀 Getting Started

### Prerequisites
- **iOS**: 17.0+
- **Xcode**: 15.0+
- **Swift**: 5.9+
- **macOS**: Sonoma 14.0+

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/hajakiyasudeen/CellularUsageApp.git
   cd CellularUsageApp
   ```

2. Open the project:
   ```bash
   open CellularUsageApp.xcodeproj
   ```

3. Select target device/simulator and run:
   ```
   ⌘ + R
   ```

### Development Setup
1. **Build Configuration**: Debug configuration includes additional logging
2. **Simulator Testing**: Tested on iPhone 17, iPhone 17 Pro
3. **Device Testing**: Compatible with physical iOS devices
4. **SwiftUI Previews**: All views include preview configurations

## 🎨 Design System

### Color Scheme
- **Primary Blue**: Plan selections and primary actions
- **Success Green**: Positive states (balance, available data)
- **Warning Orange**: Limited time offers and alerts
- **Danger Red**: Critical states (low balance, expiring plans)
- **Adaptive Colors**: Full dark mode support with system colors

### Typography
- **Title**: Bold, large text for headers
- **Headline**: Medium weight for card titles
- **Subheadline**: Regular weight for descriptions
- **Caption**: Small text for metadata

### Components
- **Cards**: Rounded corners with subtle shadows
- **Progress Indicators**: Custom styled progress bars
- **Buttons**: Full-width with state-based styling
- **Animations**: Smooth transitions and hover effects

## 🔧 Configuration

### App Configuration
- **Version**: 1.0.0
- **Minimum iOS**: 17.0
- **Supported Orientations**: Portrait (iPhone)

### Build Settings
- **Swift Version**: 5.9
- **Deployment Target**: iOS 17.0
- **Architecture**: arm64, x86_64 (Simulator)

## 📈 Performance

### Optimizations
- **LazyVStack**: Efficient list rendering for large datasets
- **Generic ViewModels**: Reduced code duplication by 85%
- **Protocol-Based Services**: Minimized coupling and improved testability
- **SwiftUI Best Practices**: Proper state management and view updates


## 🚦 Development Workflow

### Git Branching
- **main**: Production-ready code
- **develop**: Development integration branch
- **feature/***: Feature development branches


### Testing Workflow
1. Write tests for new features
2. Ensure all tests pass
3. Test on multiple device sizes
4. Verify dark mode compatibility

### Test Coverage Results
Current test coverage demonstrates our commitment to code quality:
<img width="1142" height="883" alt="Screenshot 2025-11-01 at 10 44 12 AM" src="https://github.com/user-attachments/assets/b4f5ec00-b620-4a13-b561-fd9a4da28903" />


