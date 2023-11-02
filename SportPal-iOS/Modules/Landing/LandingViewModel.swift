//
//  LandingViewModel.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 4/10/23.
//

import SwiftUI

class LandingViewModel: ObservableObject {
    
    @Published var user: UserModel
    
    init(user: UserModel) {
        self.user = GlobalParameters.shared.getUser()
    }
    
}
