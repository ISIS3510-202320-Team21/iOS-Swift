//
//  SignupViewModel.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct SignupView: View {
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        NavigationView {
            VStack () {
                HeaderBack(title: "SIGN UP") {
                }
                VStack{
                    Image("LoginImg").offset(y:100)
                    VStack{
                        
                        CustomTextField(placeholder: "Name...", text: $name).padding(.horizontal)
                        
                        CustomTextField(placeholder: "Email...", text: $username).padding(.horizontal)
                                    
                        CustomSecureField(placeholder: "Password...", text: $password).padding(.horizontal)
                        
                        Button(action: {
                            // TODO: implement signup
                        }) {
                            Text("Sign Up")
                                .font(.title2)
                                .padding(.horizontal, 80)
                                .padding(.vertical, 10)
                                .background(Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0))
                                .foregroundColor(.white)
                                .cornerRadius(40)
                        }.offset(y:50)
                    }.offset(y:100)                        .padding(.horizontal, 80)
                        .padding(.vertical, 10)
                    
                    Spacer()
                }.background(Color(red: 0.961, green: 0.961, blue: 0.961))

            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
