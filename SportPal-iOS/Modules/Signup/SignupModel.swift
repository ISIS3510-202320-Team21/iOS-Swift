//
//  SignupModel.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 27/10/23.
//

import Foundation
import UIKit

struct SignupRequest: Encodable {
    let name: String
    let email: String
    let password: String
    let phoneNumber: String
    let role: String
    let university: String
    let birthDate: Date
    let gender: String
    
    enum CodingKeys: String, CodingKey {
        case name, email, password, phoneNumber, role, university, birthDate, gender
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(role, forKey: .role)
        try container.encode(university, forKey: .university)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedBirthDate = dateFormatter.string(from: birthDate)
        try container.encode(formattedBirthDate, forKey: .birthDate)

        try container.encode(gender, forKey: .gender)
    }
}

struct SignupResponse: Decodable {
    let success: Bool
    let message: String?
}

class SignupModel {
    
    private let networkService = NetworkService.shared
    
    func signup(signupData: SignupRequest, completion: @escaping (Result<SignupResponse, NetworkService.NetworkError>) -> Void) {
        do {
            let encodedData = try JSONEncoder().encode(signupData)
            networkService.request(method: .post, resource: "users", body: encodedData) { (result: Result<SignupResponse, NetworkService.NetworkError>) in completion(result)
            }
        } catch {
            completion(.failure(.encodingFailed))
        }
    }

    func fetchRoles(completion: @escaping (Result<[String], NetworkService.NetworkError>) -> Void) {
        networkService.request(method: .get, resource: "roles") { (result: Result<[String], NetworkService.NetworkError>) in
                completion(result)
        }
    }
        
    func fetchUniversities(completion: @escaping (Result<[String], NetworkService.NetworkError>) -> Void) {
        networkService.request(method: .get, resource: "universities") { (result: Result<[String], NetworkService.NetworkError>) in
            completion(result)
        }
    }
        
    func fetchGenders(completion: @escaping (Result<[String], NetworkService.NetworkError>) -> Void) {
        networkService.request(method: .get, resource: "genders") { (result: Result<[String], NetworkService.NetworkError>) in
            completion(result)
        }
    }
}
