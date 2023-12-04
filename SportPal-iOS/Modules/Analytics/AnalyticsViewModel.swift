//
//  AnalyticsViewModel.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 4/12/23.
//

import Foundation

class AnalyticsViewModel: ObservableObject {
    
    private let analyticsModel = AnalyticsModel(user: UserModel())
    
    private var dataLoadGroup = DispatchGroup()
    
    @Published var favoriteSports: [Sport] = []
    
    @Published var errorMessage: String = ""
    
    init() {
        fetchData()
    }
    
    func getUser() -> UserModel {
        return analyticsModel.user
    }
    
    private func fetchData() {
        dataLoadGroup.enter()
        fetchRecentSports {
            self.dataLoadGroup.leave()
        }
        dataLoadGroup.notify(queue: .main) {
        }
    }
    
    func fetchRecentSports(completion: @escaping () -> Void) {
        analyticsModel.fetchRecentSports { [weak self] result in
            switch result {
            case .success(let sports):
                self?.favoriteSports = sports
                self?.errorMessage = ""
                completion()
            case .failure(let error):
                self?.errorMessage = "Failed to fetch favorite sports: \(error)"
            }
        }
    }
    
    func getFavoriteSport1() -> Sport {
        return favoriteSports[0];
    }
    
    func getFavoriteSport2() -> Sport {
        return favoriteSports[1];
    }
    
}
