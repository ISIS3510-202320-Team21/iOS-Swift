//
//  LandingViewModel.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 4/10/23.
//

import SwiftUI
import CoreLocation

class LandingViewModel: ObservableObject {
    
    private let landingModel = LandingModel(user: UserModel())
    
    private let weatherService = WeatherService()
    
    private var dataLoadGroup = DispatchGroup()
    
    private let matchesModel = MatchesModel(user: UserModel())
    
    @Published var recentSports: [Sport] = []
    @Published var errorMessage: String = ""
    @Published var temperature: Double = 0
    @Published var weatherDescription: String = ""
    @Published var locationName: String = ""
    @Published var country: String = ""
    
    @ObservedObject var locationManager = LocationManager()
    
    init() {
        fetchData()
    }
    
    func getUser() -> UserModel {
        return landingModel.user
    }
    
    public func fetchData() {
        dataLoadGroup.enter()
        fetchRecentSports {
            self.fetchWeatherData {
                self.dataLoadGroup.leave()
            }
        }
        dataLoadGroup.notify(queue: .main) {
            
        }
    }
    
    func fetchRecentSports(completion: @escaping () -> Void) {
        landingModel.fetchRecentSports { [weak self] result in
            switch result {
            case .success(let sports):
                self?.recentSports = sports
                    self?.errorMessage = ""
                    completion()
            case .failure(let error):
                    self?.errorMessage = "Failed to fetch recent sports: \(error)"
            }
        }
    }
    
    func fetchWeatherData(completion: @escaping () -> Void) {
        let latitude = locationManager.latitude
        let longitude = locationManager.longitude
        
        weatherService.fetchWeatherData(latitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self?.temperature = weatherResponse.main.temp
                    self?.weatherDescription = (weatherResponse.weather.first?.description.capitalized)!
                    self?.locationName = weatherResponse.name
                    self?.country = weatherResponse.sys.country
                    completion()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to fetch weather data: \(error)"
                }
            }
        }
    }
    
    func manageRecentSportClicked(sport: Sport, completion: @escaping (Bool) -> Void) {
        GlobalParameters.shared.setSelectedSport(sport: sport)
        matchesModel.fetchMatchesSport { [weak self] result in
            switch result {
            case .success(let matches):
                GlobalParameters.shared.setMatches(matches: matches)
                self?.errorMessage = ""
                completion(true)
            case .failure(let error):
                completion(false)
                self?.errorMessage = "Failed to fetch matches: \(error)"
            }
        }
    }
    
    func manageUserMatchesClicked(completion: @escaping (Bool) -> Void) {
        matchesModel.fetchUserMatches { [weak self] result in
            switch result {
            case .success(let matches):
                GlobalParameters.shared.setUserMatches(matches: matches)
                self?.errorMessage = ""
                completion(true)
            case .failure(let error):
                    completion(false)
                    self?.errorMessage = "Failed to fetch user matches: \(error)"
            }
        }
    }
    
}
