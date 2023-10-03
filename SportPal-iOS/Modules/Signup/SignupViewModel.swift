//
//  SignupViewModel.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct SignupViewModel: View {
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        VStack () {
            HeaderView(title: "SIGNUP", notifications: false, messages: false)
            VStack{
                Image("LoginImg").offset(y:100)
                VStack{
                    TextField("Name...", text: $name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 10)
                                
                    TextField("Email...", text: $username)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 10)
                                
                    SecureField("Password...", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    
                    Button(action: {
                        // TODO: implement signup

                    }) {
                        Text("Sign Up")
                            .padding(.horizontal, 80)
                            .padding(.vertical, 10)
                            .background(Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0))
                            .foregroundColor(.white)
                            .cornerRadius(40)
                            .offset(y:50)
                    }
                }.offset(y:100)                        .padding(.horizontal, 80)
                    .padding(.vertical, 10)
                
                Spacer()
            }.background(Color(red: 245, green: 245, blue: 245))

        }
    }
}

struct SignupViewModel_Previews: PreviewProvider {
    static var previews: some View {
        SignupViewModel()
    }
}
