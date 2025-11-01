//
//  PlansViewModel.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import Foundation

// MARK: - Plans ViewModel

@MainActor
class PlansViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var plans: [Plan] = []
    @Published var selectedPlan: Plan?

    // MARK: - Private Properties
    private let service: PlansServiceProtocol

    // MARK: - Initialization with Dependency Injection
    init(service: PlansServiceProtocol = PlansService()) {
        self.service = service
        loadData()
    }

    // MARK: - Public Methods
    func refreshData() {
        loadData()
    }

    func selectPlan(_ plan: Plan) {
        // Only change if it's a different plan
        guard selectedPlan?.id != plan.id else { return }

        // Clear previous selection and set new selection
        let previousSelection = selectedPlan?.name ?? "None"
        selectedPlan = plan
        print("PlansViewModel: Selection changed from '\(previousSelection)' to '\(plan.name)'")
    }

    func subscribeToPlan(_ plan: Plan) {
        print("PlansViewModel: Subscribing to plan: \(plan.name) - ₹\(plan.priceAmount)")
        // Here you would typically call a subscription service
        // For now, we'll just show an alert or confirmation
    }

    func isSelected(_ plan: Plan) -> Bool {
        return selectedPlan?.id == plan.id
    }

    // MARK: - Private Methods
    private func loadData() {
        let loadedPlans = service.getAvailablePlans()
        print("PlansViewModel: Loading \(loadedPlans.count) plans")
        plans = loadedPlans

        // Auto-select the popular plan (Max 499) by default
        if let popularPlan = loadedPlans.first(where: { $0.isPopular }) {
            selectedPlan = popularPlan
            print("PlansViewModel: Auto-selected popular plan: \(popularPlan.name)")
        } else if let firstPlan = loadedPlans.first {
            selectedPlan = firstPlan
            print("PlansViewModel: Auto-selected first plan: \(firstPlan.name)")
        }

        print("PlansViewModel: Set plans count to \(plans.count)")
    }
}
