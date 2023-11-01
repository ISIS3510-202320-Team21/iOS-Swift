//
//  UserModel.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 31/10/23.
//

import Foundation

class UserModel: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    // Add other user data properties as needed
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var role: String = ""
    @Published var university: String = ""
    @Published var bornDate: String = ""
    @Published var gender: String = ""
    @Published var id: Int = 0
    @Published var imageUrl: String? = ""
    @Published var latitude: Double? = 0
    @Published var longitude: Double? = 0
    @Published var notifications: [String] = []
    
    func updateUser(with loginResponse: LoginResponse) {
        self.isLoggedIn = true
        self.email = loginResponse.email
        self.name = loginResponse.name
        self.phoneNumber = loginResponse.phoneNumber
        self.role = loginResponse.role
        self.university = loginResponse.university
        self.bornDate = loginResponse.bornDate
        self.gender = loginResponse.gender
        self.id = loginResponse.id
        self.imageUrl = loginResponse.imageUrl
        self.latitude = loginResponse.latitude
        self.longitude = loginResponse.longitude
        self.notifications = loginResponse.notifications
    }
}
