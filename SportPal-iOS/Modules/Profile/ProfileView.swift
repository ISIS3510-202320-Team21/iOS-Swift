//
//  ProfileViewModel.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var user: String = "CAMILO ESCOBAR"

    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "MY PROFILE", notifications: true, messages: true)
                Image("ProfilePic").offset(y:100)
                Text("\(user)").font(.title).offset(y:100)
                Spacer()
                Spacer()
                VStack (alignment:.leading){
                    
                    Button(action: {
                        // TODO: implement signup

                    }) {
                        HStack {
                            Image("ProfileUser")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Spacer()
                            Text("Edit my profile").font(.title).foregroundColor(Color.black)
                            Spacer()
                        }.frame(height: 60).padding()
                    }
                    Button(action: {
                        // TODO: implement signup

                    }) {
                        HStack {
                            Image("ProfileSettings")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Spacer()
                            Text("Edit my profile").font(.title).foregroundColor(Color.black)
                            Spacer()
                        }.frame(height: 60).padding()
                    }
                    Button(action: {
                        // TODO: implement signup

                    }) {
                        HStack {
                            Image("LogOut")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Spacer()
                            Text("Edit my profile").font(.title).foregroundColor(Color.black)
                            Spacer()
                        }.frame(height: 60).padding()
                    }
                }
                Spacer()
                FooterView(viewModel: FooterViewModel(
                    homeButtonAction: NavigateToHomeActionStrategy(),
                    newMatchButtonAction: NavigateToNewMatchActionStrategy(),
                    profileButtonAction: NavigateToProfileActionStrategy()
                ))
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct ProfileViewModel_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
