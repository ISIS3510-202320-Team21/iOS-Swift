//
//  ProfileModel.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 4/11/23.
//

import Foundation
import UIKit

struct ProfileEditRequest: Encodable {
    let email: String
    let name: String
    let phoneNumber: String
    let role: String
    let university: String
    var bornDate: String
    let gender: String
}

struct ImagePostRequest: Encodable {
    let imageUrl: String
}

struct ProfileEditResponse: Decodable, Encodable {
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

class ProfileModel {
    
    @Published var user: UserModel
    
    init(user: UserModel) {
        self.user = GlobalParameters.shared.getUser()
    }
    
    private let networkService = NetworkService.shared
    
    func updateProfileImg(editData: ImagePostRequest, completion: @escaping (Result<ProfileEditResponse, NetworkService.NetworkError>) -> Void) {
        do {
            let encodedData = try JSONEncoder().encode(editData)
            networkService.request(method: .post, resource: "users/\(user.id)/image/", body: encodedData) { result in
                switch result {
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(ProfileEditResponse.self, from: data)
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
    
    func editProfile(editData: ProfileEditRequest, completion: @escaping (Result<ProfileEditResponse, NetworkService.NetworkError>) -> Void) {
        do {
            let encodedData = try JSONEncoder().encode(editData)
            networkService.request(method: .put, resource: "users/\(user.id)", body: encodedData) { result in
                switch result {
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(ProfileEditResponse.self, from: data)
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
    
    func fetchRoles(completion: @escaping (Result<[String], NetworkService.NetworkError>) -> Void) {
        networkService.request(method: .get, resource: "roles") { (result: Result<Data, NetworkService.NetworkError>) in
            switch result {
            case .success(let data):
                do {
                    let roles = try JSONDecoder().decode([String].self, from: data)
                    completion(.success(roles))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchUniversities(completion: @escaping (Result<[String], NetworkService.NetworkError>) -> Void) {
        networkService.request(method: .get, resource: "universities") { (result: Result<Data, NetworkService.NetworkError>) in
            switch result {
            case .success(let data):
                do {
                    let universities = try JSONDecoder().decode([String].self, from: data)
                    completion(.success(universities))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchGenders(completion: @escaping (Result<[String], NetworkService.NetworkError>) -> Void) {
        networkService.request(method: .get, resource: "genders") { (result: Result<Data, NetworkService.NetworkError>) in
            switch result {
            case .success(let data):
                do {
                    let genders = try JSONDecoder().decode([String].self, from: data)
                    completion(.success(genders))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

