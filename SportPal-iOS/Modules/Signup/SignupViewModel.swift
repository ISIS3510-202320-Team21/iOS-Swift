//
//  SignupViewModel.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 27/10/23.
//

import Foundation

class SignupViewModel: ObservableObject {
    
    private let signupModel = SignupModel()
    
    @Published var roles: [String] = []
    @Published var universities: [String] = []
    @Published var genders: [String] = []
    @Published var signupResponse: SignupResponse?
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var alertTitle: String = ""
    
    private var dataLoadGroup = DispatchGroup()
    
    init() {
        fetchData()
    }
    
    func isValidName(name: String) -> Bool {
        return !name.isEmpty && name.count <= 15
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.count >= 8
    }
    
    func isValidPhoneNumber(phoneNumber: String) -> Bool {
        return !phoneNumber.isEmpty
    }
    
    func isValidRole(role: String) -> Bool {
        return role != ""
    }
    
    func isValidUniversity(university: String) -> Bool {
        return university != ""
    }
    
    func isValidGender(gender: String) -> Bool {
        return gender != ""
    }
    
    func isValidBornDate(bornDate: Date) -> Bool {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: bornDate, to: Date())
        
        if let age = ageComponents.year, age >= 18 {
            return true
        } else {
            return false
        }
    }
    
    func isSignupButtonEnabled(name: String, email: String, password: String, phoneNumber: String, role: String, university: String, bornDate: Date, gender: String) -> Bool {
        return isValidName(name: name) && isValidEmail(email: email) && isValidPassword(password: password) && isValidPhoneNumber(phoneNumber: phoneNumber) && isValidRole(role: role) && isValidUniversity(university: university) && isValidGender(gender: gender) && isValidBornDate(bornDate: bornDate)
    }
    
    func fetchData() {
        dataLoadGroup.enter()
        fetchRoles {
            self.dataLoadGroup.leave()
        }
        
        dataLoadGroup.enter()
        fetchUniversities {
            self.dataLoadGroup.leave()
        }
        
        dataLoadGroup.enter()
        fetchGenders {
            self.dataLoadGroup.leave()
        }
        
        dataLoadGroup.notify(queue: .main) {
        }
    }
    
    func fetchRoles(completion: @escaping () -> Void) {
            signupModel.fetchRoles { [weak self] result in
                switch result {
                case .success(let roles):
                    DispatchQueue.main.async {
                        self?.roles = roles
                        completion()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error" ,message: "Failed to fetch roles: \(error)")
                    }
                }
            }
        }
        
        func fetchUniversities(completion: @escaping () -> Void) {
            signupModel.fetchUniversities { [weak self] result in
                switch result {
                case .success(let universities):
                    DispatchQueue.main.async {
                        self?.universities = universities
                        completion()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error" ,message: "Failed to fetch universities: \(error)")
                    }
                }
            }
        }
        
        func fetchGenders(completion: @escaping () -> Void) {
            signupModel.fetchGenders { [weak self] result in
                switch result {
                case .success(let genders):
                    DispatchQueue.main.async {
                        self?.genders = genders
                        completion()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error" ,message: "Failed to fetch genders: \(error)")
                    }
                }
            }
        }
    
    func signup(signupRequest: SignupRequest, completion: @escaping (Bool) -> Void ) {
        signupModel.signup(signupData: signupRequest) { [weak self] result in
            switch result {
            case .success(let response):
                completion(true)
                self?.signupResponse = response
                self?.showAlert(title: "Success" ,message: "User created")
            case .failure(let error):
                completion(false)
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
        
    private func showAlert(title: String, message: String) {
            errorMessage = message
            showAlert = true
            alertTitle = title
        }
}
