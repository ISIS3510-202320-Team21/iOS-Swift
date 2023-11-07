//
//  MatchesViewModel.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 3/11/23.
//

import SwiftUI

class MatchesViewModel: ObservableObject {
    
    private let matchesModel = MatchesModel(user: UserModel())
        
    private var dataLoadGroup = DispatchGroup()
    
    @Published var sports: [Sport] = []
    @Published var errorMessage: String = ""
        
    init() {
        fetchData()
    }
    
    func getUser() -> UserModel {
        return matchesModel.user
    }
    
    private func fetchData() {
        dataLoadGroup.enter()
        fetchSports {
            self.dataLoadGroup.leave()
        }
        dataLoadGroup.notify(queue: .main) {

        }
    }
    
    func fetchSports(completion: @escaping () -> Void) {
        matchesModel.fetchSports { [weak self] result in
            switch result {
            case .success(let sports):
                DispatchQueue.main.async {
                    self?.sports = sports
                    self?.errorMessage = ""
                    completion()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to fetch sports: \(error)"
                }
            }
        }
    }
    
}
