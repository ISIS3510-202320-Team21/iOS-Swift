//
//  SignupViewModel.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 27/10/23.
//

import Foundation

class SignupViewModel: ObservableObject {
    
    private let signupModel = SignupModel()
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var phoneNumber: String = ""
    @Published var selectedRole: String = ""
    @Published var selectedUniversity: String = ""
    @Published var birthDate: Date = Date()
    @Published var selectedGender: String = ""
        
    @Published var roles: [String] = []
    @Published var universities: [String] = []
    @Published var genders: [String] = []
    @Published var signupResponse: SignupResponse?
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var isNavigatingBack: Bool = false
    @Published var isCorrectSignup: Bool = false
    
    func fetchRoles() {
            signupModel.fetchRoles { [weak self] result in
                switch result {
                case .success(let roles):
                    DispatchQueue.main.async {
                        self?.roles = roles
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(message: "Failed to fetch roles: \(error)")
                    }
                }
            }
        }
        
        func fetchUniversities() {
            signupModel.fetchUniversities { [weak self] result in
                switch result {
                case .success(let universities):
                    DispatchQueue.main.async {
                        self?.universities = universities
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(message: "Failed to fetch universities: \(error)")
                    }
                }
            }
        }
        
        func fetchGenders() {
            signupModel.fetchGenders { [weak self] result in
                switch result {
                case .success(let genders):
                    DispatchQueue.main.async {
                        self?.genders = genders
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(message: "Failed to fetch genders: \(error)")
                    }
                }
            }
        }
    
    func signup(signupRequest: SignupRequest) {
        
        signupModel.signup(signupData: signupRequest) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.signupResponse = response
                    // Handle the SignupResponse if needed
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    switch error {
                    case .invalidURL:
                        self?.errorMessage = "Invalid URL."
                    case .noData:
                        self?.errorMessage = "No data encountered."
                    case .encodingFailed:
                        self?.errorMessage = "Signup encoding failed."
                    case .decodingFailed:
                        self?.errorMessage = "Signup decoding failed."
                    case .undefined:
                        self?.errorMessage = "Undefined error"
                    }
                    self?.showAlert = true
                }
            }
        }
    }
    
    func goBack() {
            isNavigatingBack = true
        }
        
        private func showAlert(message: String) {
            errorMessage = message
            showAlert = true
        }
}
