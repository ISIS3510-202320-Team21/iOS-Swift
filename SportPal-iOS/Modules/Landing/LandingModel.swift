//
//  LandingModel.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 3/11/23.
//

import Foundation
import UIKit

class LandingModel {
    
    @Published var user: UserModel
    
    init(user: UserModel) {
        self.user = GlobalParameters.shared.getUser()
    }

    private let networkService = NetworkService.shared
    
    func fetchRecentSports(completion: @escaping (Result<[Sport], NetworkService.NetworkError>) -> Void) {
        networkService.request(method: .get, resource: "user/\(user.id)/most_reserved_sports_this_week") { (result: Result<Data, NetworkService.NetworkError>) in
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
}
