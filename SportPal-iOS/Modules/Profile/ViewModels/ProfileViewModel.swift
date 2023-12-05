//
//  ProfileViewModel.swift
//  SportPal
//
//  Created by Alejandro Tovar on 1/11/23.
//

import Foundation
import UIKit

class ProfileViewModel: ObservableObject {
    
    private let profileModel = ProfileModel(user: UserModel())
    
    @Published var roles: [String] = []
    @Published var universities: [String] = []
    @Published var genders: [String] = []
    @Published var profileEditResponse: ProfileEditResponse?
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var alertTitle: String = ""
    @Published var claims: [Claim] = []
    
    private var dataLoadGroup = DispatchGroup()
    
    init() {
        fetchData()
    }
    
    func getUser() -> UserModel {
        return profileModel.user
    }
    
    func getClaims() -> [Claim] {
        return claims
    }
    
    func isValidName(name: String) -> Bool {
        return !name.isEmpty && name.count <= 15
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
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
    
    func isConfirmButtonEnabled(name: String, email: String, phoneNumber: String, role: String, university: String, bornDate: Date, gender: String) -> Bool {
        return isValidName(name: name) && isValidEmail(email: email) && isValidPhoneNumber(phoneNumber: phoneNumber) && isValidRole(role: role) && isValidUniversity(university: university) && isValidGender(gender: gender) && isValidBornDate(bornDate: bornDate)
    }
    
    func isValidClaim(claim: String) -> Bool {
        return !claim.isEmpty && claim.count <= 200
    }
    
    func fetchData() {
        dataLoadGroup.enter()
        fetchRoles {
            self.dataLoadGroup.leave()
        }
        dataLoadGroup.enter()
        fetchClaims {
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
        profileModel.fetchRoles { [weak self] result in
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
        profileModel.fetchUniversities { [weak self] result in
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
        profileModel.fetchGenders { [weak self] result in
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
    
    func editProfile(editData: ProfileEditRequest, completion: @escaping (Bool) -> Void ) {
        profileModel.editProfile(editData: editData) { [weak self] result in
            switch result {
            case .success(let response):
                completion(true)
                self?.profileEditResponse = response
                self?.showAlert(title: "Success" ,message: "Profile Edited. Please log in.")
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
    
    func sendClaim(claimData: ClaimRequest, completion: @escaping (Bool) -> Void ) {
        profileModel.sendClaim(claimData: claimData) { [weak self] result in
            switch result {
            case true:
                self?.showAlert(title: "Success" ,message: "Claim Sent")
            case false:
                self?.showAlert(title: "Error" ,message: "Error sending claim")
            }
        }
    }
    
    func fetchClaims(completion: @escaping () -> Void) {
        
        profileModel.fetchClaims { [weak self] result in
            switch result {
            case .success(let claims):
                self?.claims = claims
                completion()
            
//                DispatchQueue.main.async {
//                    self?.errorMessage = ""
//                    
//                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion()
                    self?.errorMessage = "Failed to fetch claims: \(error)"
                }
            }
        }
    }
    
    
    func didTapChangeProfilePic() {
        print("Clicked")
    }
    
    private func showAlert(title: String, message: String) {
        errorMessage = message
        showAlert = true
        alertTitle = title
    }
    
}
