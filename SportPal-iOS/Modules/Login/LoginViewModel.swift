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
    
    
    var body: some View {
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

                    }) {
                        Text("Send")
                            .font(.title)
                            .padding(.horizontal, 80)
                            .padding(.vertical, 10)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }.offset(y:100)                        .padding(.horizontal, 80)
                    .padding(.vertical, 10)
                VStack{
                    Text("Or sign up using")                        .padding(.vertical, 7)

                    Button("Sign Up", action: {
                        //TODO: Connect with sign up
                    })
                }.offset(y:100)
                
                Spacer()
            }.background(Color(red: 0.4627, green: 0.8392, blue: 1.0))

        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
