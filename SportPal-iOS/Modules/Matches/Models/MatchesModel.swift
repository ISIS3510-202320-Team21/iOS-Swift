//
//  MatchesModel.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 6/11/23.
//

import Foundation
import UIKit

struct Sport: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let imageUrl: String
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
}
