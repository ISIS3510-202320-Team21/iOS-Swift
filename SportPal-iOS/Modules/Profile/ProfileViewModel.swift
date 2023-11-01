//
//  ProfileViewModel.swift
//  SportPal
//
//  Created by Alejandro Tovar on 1/11/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var user: UserModel
    
    init(user: UserModel) {
        self.user = GlobalParameters.shared.getUser()
    }
}
