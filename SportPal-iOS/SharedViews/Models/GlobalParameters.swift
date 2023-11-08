//
//  GlobalParameters.swift
//  SportPal
//
//  Created by Alejandro Tovar on 1/11/23.
//

import Foundation

struct Sport: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let imageUrl: String
    let count: Int?
}

struct Level: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
}

struct User: Identifiable, Decodable, Hashable {
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
    let notifications: [Notification]
}

struct Match: Identifiable, Decodable, Hashable {
    let id: Int
    let date: String
    let time: String
    let status: String
    let court: String
    let city: String
    let creationDate: String
    let rate: Int?
    let user_created_id: Int
    let sport: Sport
    let level: Level
    let user_created: User
    let user_joined: User?
}

struct Notification: Identifiable, Decodable, Hashable {
    let name: String
    let type: String
    let redirectTo: String
    let id: Int
    let seen: Bool
    let creationDate: String
    let owner_id: Int
}

class GlobalParameters {
    
    private let networkService = NetworkService.shared
    
    public static let shared = GlobalParameters()
    
    private var user: UserModel = UserModel()
    
    private var matches: [Match] = []
    
    private var selectedSport: Sport?
    
    public func setUser(loginResponse: LoginResponse) {
        print("This is the user to be stored:")
        print(loginResponse)
        self.user.updateUser(loginResponse: loginResponse)
    }
    
    public func getUser() -> UserModel {
        return self.user
    }
    
    public func setMatches(matches: [Match]) {
        self.matches = matches
    }
    
    public func getMatches() -> [Match] {
        return self.matches
    }
    
    public func setSelectedSport(sport: Sport) {
        self.selectedSport = sport
    }
    
    public func getSelectedSport() -> Sport {
        return self.selectedSport!
    }
    
}
