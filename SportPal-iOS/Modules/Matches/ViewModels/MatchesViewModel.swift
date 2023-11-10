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
    
    @Published var showAlert: Bool = false

    @Published var alertTitle: String = ""
    
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
                self?.sports = sports
                DispatchQueue.main.async {
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
    
    func fetchMatchesSport(completion: @escaping (Bool) -> Void) {
        matchesModel.fetchMatchesSport { [weak self] result in
            switch result {
            case .success(let matches):
                GlobalParameters.shared.setMatches(matches: matches)
                DispatchQueue.main.async {
                    self?.errorMessage = ""
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(false)
                    self?.errorMessage = "Failed to fetch matches: \(error)"
                }
            }
        }
    }
    
    func fetchUserMatches(completion: @escaping (Bool) -> Void) {
        matchesModel.fetchUserMatches { [weak self] result in
            switch result {
            case .success(let matches):
                GlobalParameters.shared.setUserMatches(matches: matches)
                completion(true)
                self?.errorMessage = ""
            case .failure(let error):
                completion(false)
                self?.errorMessage = "Failed to fetch user matches: \(error)"
            }
        }
    }
    
    func manageAcceptMatchClicked(completion: @escaping (Bool) -> Void) {
        matchesModel.acceptMatch() { [weak self] result in
            switch result {
            case true:
                self?.showAlert(title: "Success" ,message: "Match accepted")
                completion(true)
            case false:
                self?.showAlert(title: "Error" ,message: "Failed to accept match:")
                completion(false)
            }
        }
    }
    
    func manageCreateMatchClicked(matchRequest: MatchRequest, completion: @escaping (Bool) -> Void) {
        matchesModel.createMatch(matchData: matchRequest) { [weak self] result in
            switch result {
            case true:
                self?.showAlert(title: "Success" ,message: "Match created")
                completion(true)
            case false:
                self?.showAlert(title: "Error" ,message: "Failed to create match:")
                completion(false)
            }
        }
    }
    
    func isValidMatchDate(matchDate: Date) -> Bool {
        let calendar = Calendar.current
        let currentDate = calendar.startOfDay(for: Date())
        let normalizedMatchDate = calendar.startOfDay(for: matchDate)
        return normalizedMatchDate >= currentDate
    }
    
    func isValidMatchStartTime(startTime: Date) -> Bool {
        let calendar = Calendar.current
        let currentDate = Date()
        if let fiveMinutesAgo = calendar.date(byAdding: .minute, value: -5, to: currentDate) {
            return startTime > fiveMinutesAgo
        }
        return false
    }
    
    func isValidMatchEndTime(startTime: Date, endTime: Date) -> Bool {
        let calendar = Calendar.current
        guard isValidMatchStartTime(startTime: startTime) else {
            return false
        }
        if let min30AfterStartTime = calendar.date(byAdding: .minute, value: 30, to: startTime) {
            return endTime >= min30AfterStartTime
        }
        return false
    }
    
    func isValidCity(city: String) -> Bool {
        return !city.isEmpty && city.count <= 15
    }
    
    func isValidCourt(court: String) -> Bool {
        return !court.isEmpty && court.count <= 15
    }
    
    func isValidLevel(level: Int) -> Bool {
        return level != 0
    }
    
    func isCreateButtonEnabled (matchDate: Date, matchStartTime: Date, matchEndTime: Date, city: String, court: String, level: Int) -> Bool {
        return isValidMatchDate(matchDate: matchDate) && isValidMatchStartTime(startTime: matchStartTime) && isValidMatchEndTime(startTime: matchStartTime, endTime: matchEndTime) && isValidCity(city: city) && isValidCourt(court: court) && isValidLevel(level: level)
    }
        
    func updateSelectedSport(selectedSport: Sport) {
        matchesModel.updateSelectedSport(selectedSport: selectedSport)
    }
    
    func getSelectedSport() -> Sport {
        return matchesModel.getSelectedSport()
    }
    
    func updateSelectedMatch(selectedMatch: Match) {
        matchesModel.updateSelectedMatch(selectedMatch: selectedMatch)
    }
    
    func getSelectedMatch() -> Match {
        return matchesModel.getSelectedMatch()
    }
    
    func getSportMatches() -> [Match] {
        return GlobalParameters.shared.getMatches()
    }
    
    func getUserMatches() -> [Match] {
        return GlobalParameters.shared.getUserMatches()
    }
    
    private func showAlert(title: String, message: String) {
        errorMessage = message
        showAlert = true
        alertTitle = title
    }
    
}
