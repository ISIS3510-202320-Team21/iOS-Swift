//
//  LoginViewModel.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 31/10/23.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    private let loginModel = LoginModel()
    
    @EnvironmentObject var user: UserModel
    
    @Published var loginResponse: LoginResponse?
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var alertTitle: String = ""
    @Published var isCorrectLogin: Bool = false
    
    func login(loginRequest: LoginRequest) {
        loginModel.login(loginData: loginRequest) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.loginResponse = response
                    self?.showAlert(title: "Success" ,message: "Logged in")
                    self?.handleSuccessfulLogin()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    switch error {
                    case .HTTPError(_, let detail):
                        self?.showAlert(title: "Error" ,message: detail)
                    case .decodingFailed:
                        self?.showAlert(title: "Error" ,message: "Decoding failed")
                    case .noData:
                        self?.showAlert(title: "Error" ,message: "No data")
                    default:
                        self?.showAlert(title: "Error" ,message: "An error occurred")
                    }
                }
            }
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.count >= 8
    }
    
    func isLoginButtonEnabled(email: String, password: String) -> Bool {
        return isValidPassword(password: password) && isValidEmail(email: email)
    }
    
    func handleSuccessfulLogin() {
        self.isCorrectLogin = true
    }
        
    private func showAlert(title: String, message: String) {
        errorMessage = message
        showAlert = true
        alertTitle = title
    }
}
