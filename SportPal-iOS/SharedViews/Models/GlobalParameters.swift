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

struct ChatCompletionResponse: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage
    let systemFingerprint: String?

    struct Choice: Decodable {
        let index: Int
        let message: Message
        let finishReason: String

        struct Message: Decodable {
            let role: String
            let content: String
        }
    }

    struct Usage: Decodable {
        let promptTokens: Int
        let completionTokens: Int
        let totalTokens: Int

        private enum CodingKeys: String, CodingKey {
            case promptTokens = "prompt_tokens"
            case completionTokens = "completion_tokens"
            case totalTokens = "total_tokens"
        }
    }
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
    let notifications: [Notification]?
}

struct Match: Identifiable, Decodable, Hashable {
    let id: Int
    let date: String
    let time: String
    let status: String
    let court: String
    let city: String
    let creationDate: String
    let rate1: String?
    let rate2: String?
    let user_created_id: Int
    let sport: Sport
    let level: Level
    let user_created: User
    let user_joined: User?
}

struct Claim: Identifiable, Decodable, Hashable {
    let user_created_id: Int?
    let content: String
    let id: Int
    let user_created: User?
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
    
    private var selectedMatch: Match?
    
    private var userMatches: [Match] = []
    
    private var userSavedAnImage = false
    
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
    
    public func setUserMatches(matches: [Match]) {
        self.userMatches = matches
    }
    
    public func getUserMatches() -> [Match] {
        return self.userMatches
    }
    
    public func setSelectedSport(sport: Sport) {
        self.selectedSport = sport
    }
    
    public func getSelectedSport() -> Sport {
        return self.selectedSport!
    }
    
    public func setSelectedMatch(match: Match) {
        self.selectedMatch = match
    }
    
    public func getSelectedMatch() -> Match {
        return self.selectedMatch!
    }
    
    public func setUserSavedAnImage(saved: Bool) {
        self.userSavedAnImage = saved
    }
    
    public func getUserSavedAnImage() -> Bool {
        return self.userSavedAnImage
    }
    
}

func convertStringToDate(dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set locale if needed
    
    if let date = dateFormatter.date(from: dateString) {
        return date
    } else {
        print("Invalid date format or value: \(dateString)")
        return nil
    }
}
