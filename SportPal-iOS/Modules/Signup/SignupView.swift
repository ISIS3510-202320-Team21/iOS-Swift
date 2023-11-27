//
//  SignupViewModel.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct SignupView: View {
    
    @ObservedObject private var signupViewModel = SignupViewModel()
    
    @Binding var navPaths: [Routes]

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    @State private var selectedRole: String = ""
    @State private var selectedUniversity: String = ""
    @State private var bornDate: Date = Date()
    @State private var selectedGender: String = ""
    
    
    var body: some View {
        ScrollView {
            LazyVStack () {
                HeaderBack(title: "SIGN UP") {
                    navPaths.removeLast()
                }
                VStack{
                    Image(systemName: "person.crop.circle.fill")
                        .resizable().aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .imageScale(.small)
                        .offset(y:30)
                        .foregroundColor(Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0))
                    VStack{
                        Group{
                            CustomTextField(
                                placeholder: "First Name...",
                                text: $name,
                                isValid: signupViewModel.isValidName(name: name)
                            ).padding(.horizontal)
                            
                            CustomTextField(
                                placeholder: "Email...",
                                text: $email,
                                isValid: signupViewModel.isValidEmail(email: email)
                            ).padding(.horizontal)
                            
                            if !signupViewModel.isValidEmail(email: email) {
                                Text("Invalid Email").foregroundColor(Color.gray).padding(.bottom, 20)
                            }
                            
                            CustomTextField(
                                placeholder: "Phone Number...",
                                text:$phoneNumber,
                                isValid: signupViewModel.isValidPhoneNumber(phoneNumber: phoneNumber)
                            ).padding(.horizontal).keyboardType(.phonePad)
                            
                            if !signupViewModel.isValidPhoneNumber(phoneNumber: phoneNumber) {
                                Text("Phone should have 10 digits").foregroundColor(Color.gray).padding(.bottom, 20)
                            }
                            
                            CustomSecureField(
                                placeholder: "Password...",
                                text: $password,
                                isValid: signupViewModel.isValidPassword(password: password)
                            ).padding(.horizontal)
                            
                            if !signupViewModel.isValidPassword(password: password) {
                                Text("Password must be at least 8 characters long").foregroundColor(Color.gray).padding(.bottom, 20)
                            }
                        }
                        
                        Group {
                            
                            DatePicker("Birth Date", selection: $bornDate, displayedComponents: .date)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(signupViewModel.isValidBornDate(bornDate: bornDate) ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                            
                            if !signupViewModel.isValidBornDate(bornDate: bornDate) {
                                Text("You must be at least 18 to register").foregroundColor(Color.gray).padding(.bottom, 20)
                            }
                            Picker("Gender", selection: $selectedGender) {
                                Text("Select Gender").tag("")
                                ForEach(signupViewModel.genders, id: \.self) { gender in
                                    Text(gender).tag(gender)
                                }
                            }.pickerStyle(MenuPickerStyle())
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(signupViewModel.isValidGender(gender: selectedGender) ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                            
                            Picker("University", selection: $selectedUniversity) {
                                Text("Select University").tag("")
                                ForEach(signupViewModel.universities, id: \.self) { university in
                                    Text(university).tag(university)
                                }
                            }.pickerStyle(MenuPickerStyle())
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(signupViewModel.isValidUniversity(university: selectedUniversity) ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                            
                            Picker("Role", selection: $selectedRole) {
                                Text("Select Role").tag("")
                                ForEach(signupViewModel.roles, id: \.self) { role in
                                    Text(role).tag(role)
                                }
                            }.pickerStyle(MenuPickerStyle())
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(signupViewModel.isValidRole(role: selectedRole) ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                        }
                        
                        Button(action: {
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd/MM/yyyy"
                            let formattedBornDate = dateFormatter.string(from: bornDate)
                            
                            let signUpRequest =  SignupRequest(
                                email: email,
                                password: password,
                                name: name,
                                phoneNumber: phoneNumber,
                                role: selectedRole,
                                university: selectedUniversity,
                                bornDate: formattedBornDate,
                                gender: selectedGender
                            )
                            
                            signupViewModel.signup(signupRequest: signUpRequest) { result in
                                switch result {
                                case true:
                                    navPaths.append(.login)
                                case false: break
                                }
                            }
                        }) {
                            Text("Sign Up")
                                .font(.title)
                                .padding(.horizontal, 80)
                                .padding(.vertical, 10)
                        }
                        .buttonStyle(CustomButtonStyle(isEnabled: signupViewModel.isSignupButtonEnabled(name: name, email: email, password: password, phoneNumber: phoneNumber, role: selectedRole, university: selectedUniversity, bornDate: bornDate, gender: selectedGender)))
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                        .disabled(!signupViewModel.isSignupButtonEnabled(name: name, email: email, password: password, phoneNumber: phoneNumber, role: selectedRole, university: selectedUniversity, bornDate: bornDate, gender: selectedGender))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 50.0)
                    
                }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
                
            }
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $signupViewModel.showAlert) {
                Alert(title: Text(signupViewModel.alertTitle), message: Text(signupViewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(navPaths: .constant([]))
    }
}
