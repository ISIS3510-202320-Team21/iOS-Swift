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
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundColor(Color.gray)
                    .offset(y:30)
                Text("\(user)").font(.title).fontWeight(.regular).offset(y:30)
                Spacer()
                Spacer()
                VStack (alignment:.leading){
                    
                    Button(action: {
                        // TODO: implement signup

                    }) {
                        HStack {
                            Image(systemName: "person.crop.circle.badge.exclamationmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text("Edit my profile").font(.title).fontWeight(.thin).foregroundColor(Color.black)
                            Spacer()
                        }.frame(height: 60).padding()
                    }
                    Button(action: {
                        // TODO: implement signup

                    }) {
                        HStack {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text("Settings").font(.title).fontWeight(.thin).foregroundColor(Color.black)
                            Spacer()
                        }.frame(height: 60).padding()
                    }
                    Button(action: {
                        // TODO: implement signup

                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text("Edit my profile").font(.title).fontWeight(.thin).foregroundColor(Color.black)
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
            }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
        }.navigationBarBackButtonHidden(true)
    }
}

struct ProfileViewModel_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
