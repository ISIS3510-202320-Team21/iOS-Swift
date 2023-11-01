//
//  GlobalParameters.swift
//  SportPal
//
//  Created by Alejandro Tovar on 1/11/23.
//

import Foundation

class GlobalParameters {
    
    public static let shared = GlobalParameters()
    
    private var user: UserModel = UserModel()
    
    public func setUser(loginResponse: LoginResponse) {
        print("This is the user to be stored:")
        print(loginResponse)
        self.user.updateUser(loginResponse: loginResponse)
    }
    public func getUser() -> UserModel {
        return self.user
    }
}
