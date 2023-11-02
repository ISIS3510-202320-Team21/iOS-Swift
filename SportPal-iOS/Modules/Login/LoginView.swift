//
//  LoginViewModel.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct LoginView: View {

    @ObservedObject private var loginViewModel = LoginViewModel()
    
    @Binding var navPaths: [Routes]
    
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        
            VStack () {
                HeaderView(title: "LOGIN", notifications: false, messages: false)
                VStack{
                    Image(systemName: "person.circle.fill").resizable().aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .imageScale(.small)
                        .padding(.top, 50)
                        .foregroundColor(Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0))
                    VStack{
                        CustomTextField(
                            placeholder: "Email...",
                            text: $email,
                            isValid: loginViewModel.isValidEmail(email: email)
                        ).padding(.horizontal)
                                    
                        CustomSecureField(
                            placeholder: "Password...",
                            text: $password,
                            isValid: loginViewModel.isValidPassword(password: password)
                        ).padding(.horizontal)
                        
                        Button(action: {
                            let loginRequest =  LoginRequest(
                                email: email,
                                password: password
                            )
                            loginViewModel.login(loginRequest: loginRequest) { result in
                                switch result {
                                case true:
                                    navPaths.append(.landing)
                                case false: break
                                }
                            }
                        }) {
                            Text("Login")
                                .font(.title)
                                .padding(.horizontal, 80)
                                .padding(.vertical, 10)
                        }.buttonStyle(CustomButtonStyle(isEnabled: loginViewModel.isLoginButtonEnabled(email: email, password: password)))
                            .padding(.top, 50)
                            .disabled(!loginViewModel.isLoginButtonEnabled(email: email, password: password))
                    }.padding(.horizontal, 20)
                        .padding(.vertical, 50)
                    
                    VStack{
                        Text("Or sign up using").foregroundColor(Color.gray)                        .padding(.vertical, 7)
                        
                        Button("Sign Up", action: {
                            navPaths.append(.signup)
                        })
                    }
                    Spacer()
                }
            }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $loginViewModel.showAlert) {
            Alert(title: Text(loginViewModel.alertTitle), message: Text(loginViewModel.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(navPaths: .constant([]))
    }
}
