//
//  LoginModel.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 31/10/23.
//

import Foundation
import UIKit

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct LoginResponse: Decodable, Encodable {
    let email: String
    let name: String
    let phoneNumber: String
    let role: String
    let university: String
    let bornDate: String
    let gender: String
    let id: Int
    let imageUrl: String?
    let latitude: Double?
    let longitude: Double?
    let notifications: [String]
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(email, forKey: .email)
            try container.encode(name, forKey: .name)
            try container.encode(phoneNumber, forKey: .phoneNumber)
            try container.encode(role, forKey: .role)
            try container.encode(university, forKey: .university)
            try container.encode(bornDate, forKey: .bornDate)
            try container.encode(gender, forKey: .gender)
            try container.encode(id, forKey: .id)
            try container.encode(imageUrl, forKey: .imageUrl)
            try container.encode(latitude, forKey: .latitude)
            try container.encode(longitude, forKey: .longitude)
            try container.encode(notifications, forKey: .notifications)
    }

    // CodingKeys enum to map properties to keys during encoding
    private enum CodingKeys: String, CodingKey {
        case email, name, phoneNumber, role, university, bornDate, gender, id, imageUrl, latitude, longitude, notifications
    }
}

class LoginModel {
    
    private let networkService = NetworkService.shared
    
    func login(loginData: LoginRequest, completion: @escaping (Result<LoginResponse, NetworkService.NetworkError>) -> Void) {
        do {
            let encodedData = try JSONEncoder().encode(loginData)
            networkService.request(method: .post, resource: "login", body: encodedData) { result in
                switch result {
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(LoginResponse.self, from: data)
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
}
