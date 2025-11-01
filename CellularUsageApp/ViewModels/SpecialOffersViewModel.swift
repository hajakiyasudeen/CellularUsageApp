//
//  SpecialOffersViewModel.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import Foundation

// MARK: - Special Offers ViewModel

@MainActor
class SpecialOffersViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var specialOffers: [SpecialOffer] = []

    // MARK: - Private Properties
    private let service: SpecialOffersServiceProtocol

    // MARK: - Initialization with Dependency Injection
    init(service: SpecialOffersServiceProtocol = SpecialOffersService()) {
        self.service = service
        loadData()
    }

    // MARK: - Public Methods
    func refreshData() {
        loadData()
    }

    // MARK: - Private Methods
    private func loadData() {
        let loadedOffers = service.getSpecialOffers()
        print("SpecialOffersViewModel: Loading \(loadedOffers.count) offers")
        specialOffers = loadedOffers
        print("SpecialOffersViewModel: Set offers count to \(specialOffers.count)")
    }
}
