//
//  SignupViewModel.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct SignupView: View {
    
    @StateObject private var signupViewModel = SignupViewModel()

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    @State private var selectedRole: String = ""
    @State private var selectedUniversity: String = ""
    @State private var birthDate: Date = Date()
    @State private var selectedGender: String = ""
    
    @State private var isShowingSignupView: Bool = false
    @State private var isNavigatingBack: Bool = false
    @State private var isCorrectSignup: Bool = false
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack () {
                    HeaderBack(title: "SIGN UP") {
                        self.isNavigatingBack = true
                    }
                    VStack{
                        Image(systemName: "person.crop.circle.fill.badge.plus").resizable().aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .imageScale(.small)
                            .offset(y:30)
                            .foregroundColor(Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0))
                        VStack{
                            
                            CustomTextField(placeholder: "Name...", text: $name).padding(.horizontal)
                            
                            CustomTextField(placeholder: "Email...", text: $email).padding(.horizontal)
                            
                            CustomSecureField(placeholder: "Password...", text: $password).padding(.horizontal)
                            
                            CustomTextField(placeholder: "Phone Number...", text: $phoneNumber).padding(.horizontal)
                            
                            Picker("Role", selection: $selectedRole) {
                                ForEach(signupViewModel.roles, id: \.self) { role in
                                    Text(role).tag(role)
                                }
                            }.pickerStyle(MenuPickerStyle())
                                .padding(.horizontal)
                            
                            Picker("University", selection: $selectedUniversity) {
                                ForEach(signupViewModel.universities, id: \.self) { university in
                                    Text(university).tag(university)
                                }
                            }.pickerStyle(MenuPickerStyle())
                                .padding(.horizontal)
                            
                            DatePicker("Birth Date", selection: $birthDate, displayedComponents: .date)
                                .padding(.horizontal)
                            
                            Picker("Gender", selection: $selectedGender) {
                                ForEach(signupViewModel.genders, id: \.self) { gender in
                                    Text(gender).tag(gender)
                                }
                            }.pickerStyle(MenuPickerStyle())
                                .padding(.horizontal)
                            
                            Button(action: {
                                func signup() {
                                    
                                    let signupRequest = SignupRequest(
                                        name: name,
                                        email: email,
                                        password: password,
                                        phoneNumber: phoneNumber,
                                        role: selectedRole,
                                        university: selectedUniversity,
                                        birthDate: birthDate,
                                        gender: selectedGender
                                    )
                                    
                                    signupViewModel.signup(signupRequest: signupRequest)
                                }
                            }) {
                                Text("Sign Up")
                                    .font(.title2)
                                    .padding(.horizontal, 80)
                                    .padding(.vertical, 10)
                                    .background(Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0))
                                    .foregroundColor(.white)
                                    .cornerRadius(40)
                            }.offset(y:80)
                            
                            NavigationLink(destination: LandingView(), isActive: $isCorrectSignup) {
                                EmptyView()
                            }
                        }.offset(y:50)                        .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                        
                        Spacer()
                    }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
                    
                }
            }
        }.navigationBarBackButtonHidden(true)
        .background(NavigationLink(
            destination: LoginView(),
            isActive: $isNavigatingBack,
            label: {EmptyView()}))
        .onAppear {
            signupViewModel.fetchRoles()
            signupViewModel.fetchUniversities()
            signupViewModel.fetchGenders()
        }
        .alert(isPresented: $signupViewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(signupViewModel.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
