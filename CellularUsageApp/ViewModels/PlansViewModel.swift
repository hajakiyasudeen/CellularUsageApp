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

    // MARK: - Private Methods
    private func loadData() {
        let loadedPlans = service.getAvailablePlans()
        print("PlansViewModel: Loading \(loadedPlans.count) plans")
        plans = loadedPlans
        print("PlansViewModel: Set plans count to \(plans.count)")
    }
}
