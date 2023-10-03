//
//  LoginViewModel.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSignup: Bool = false
    @State private var isCorrectLogin: Bool = false

    
    
    var body: some View {
        NavigationView {
            VStack () {
                HeaderView(title: "LOGIN", notifications: false, messages: false)
                VStack{
                    Image("LoginImg").offset(y:100)
                    VStack{
                        TextField("Email...", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 20)
                            .padding(.bottom, 10)
                        
                        SecureField("Password...", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                        
                        Button(action: {
                            // TODO: implement login
                            isCorrectLogin = true
                        }) {
                            Text("Login")
                                .font(.title)
                                .padding(.horizontal, 80)
                                .padding(.vertical, 10)
                                .background(Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0))
                                .foregroundColor(.white)
                                .cornerRadius(40)
                        }
                    }.offset(y:100)                        .padding(.horizontal, 80)
                        .padding(.vertical, 10)
                    
                    NavigationLink(destination: SignupViewModel(), isActive: $isSignup) {
                        EmptyView()
                    }
                    NavigationLink(destination: LandingViewModel(), isActive: $isCorrectLogin) {
                        EmptyView()
                    }
                    VStack{
                        Text("Or sign up using")                        .padding(.vertical, 7)
                        
                        Button("Sign Up", action: {
                            //TODO: Connect with sign up
                            isSignup = true
                        })
                    }.offset(y:100)
                    
                    Spacer()
                }
            }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
        }.navigationBarBackButtonHidden()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
