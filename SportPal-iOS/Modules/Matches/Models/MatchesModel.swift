//
//  MatchesModel.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 6/11/23.
//

import Foundation
import UIKit

struct MatchRequest: Encodable {
    let date: String
    let time: String
    let status: String
    let court: String
    let city: String
    let sport_id: Int
    var level_id: Int
}

class MatchesModel {
    
    @Published var user: UserModel
        
    init(user: UserModel) {
        self.user = GlobalParameters.shared.getUser()
    }
    
    private let networkService = NetworkService.shared
    
    func fetchSports(completion: @escaping (Result<[Sport], NetworkService.NetworkError>) -> Void) {
        networkService.request(method: .get, resource: "sports") { (result: Result<Data, NetworkService.NetworkError>) in
            switch result {
            case .success(let data):
                do {
                    let sports = try JSONDecoder().decode([Sport].self, from: data)
                    completion(.success(sports))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMatchesSport(completion: @escaping (Result<[Match], NetworkService.NetworkError>) -> Void) {
        networkService.request(method: .get, resource: "sports/\(GlobalParameters.shared.getSelectedSport().id)/matches") { (result: Result<Data, NetworkService.NetworkError>) in
            switch result {
            case .success(let data):
                do {
                    let matches = try JSONDecoder().decode([Match].self, from: data)
                    completion(.success(matches))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchUserMatches(completion: @escaping (Result<[Match], NetworkService.NetworkError>) -> Void) {
        networkService.request(method: .get, resource: "users/\(GlobalParameters.shared.getUser().id)/matches") { (result: Result<Data, NetworkService.NetworkError>) in
            switch result {
            case .success(let data):
                do {
                    let matches = try JSONDecoder().decode([Match].self, from: data)
                    completion(.success(matches))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func acceptMatch(completion: @escaping (Bool) -> Void) {
        networkService.request(method: .put, resource: "matches/\(GlobalParameters.shared.getSelectedMatch().id)/users/\(GlobalParameters.shared.getUser().id)") {
            (result: Result<Data, NetworkService.NetworkError>) in
            switch result {
            case .success( _):
                completion(true)
            case .failure( _):
                completion(false)
            }
        }
    }
    
    func createMatch(matchData: MatchRequest, completion: @escaping (Bool) -> Void) {
        do {
            let encodedData = try JSONEncoder().encode(matchData)
            networkService.request(method: .post, resource: "users/\(GlobalParameters.shared.getUser().id)/matches", body: encodedData) { result in
                switch result {
                case .success(_):
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
        } catch {
            completion(false)
        }
    }
    
    func signup(signupData: SignupRequest, completion: @escaping (Result<SignupResponse, NetworkService.NetworkError>) -> Void) {
        do {
            let encodedData = try JSONEncoder().encode(signupData)
            networkService.request(method: .post, resource: "users", body: encodedData) { result in
                switch result {
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(SignupResponse.self, from: data)
                        completion(.success(response))
                    } catch {
                        completion(.failure(.decodingFailed))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(.encodingFailed))
        }
    }
    
    func updateSelectedSport(selectedSport: Sport){
        GlobalParameters.shared.setSelectedSport(sport: selectedSport)
    }
    
    func updateSelectedMatch(selectedMatch: Match){
        GlobalParameters.shared.setSelectedMatch(match: selectedMatch)
    }
    
    func getSelectedSport() -> Sport {
        return GlobalParameters.shared.getSelectedSport()
    }
    
    func getSelectedMatch() -> Match {
        return GlobalParameters.shared.getSelectedMatch()
    }
    
    func getUserMatches() -> [Match] {
        return GlobalParameters.shared.getUserMatches()
    }
}
