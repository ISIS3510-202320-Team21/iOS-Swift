//
//  NewMatchViewModel.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct NewMatchView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        VStack () {
            HeaderView(title: "NEW MATCH", notifications: true, messages: true)
            VStack{
                Text("Or sign up using")                        .padding(.vertical, 10)
                
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
            }.background(Color(red: 0.96, green: 0.96, blue: 0.96))

        }
    }
}

struct NewMatchView_Previews: PreviewProvider {
    static var previews: some View {
        NewMatchView()
    }
}

