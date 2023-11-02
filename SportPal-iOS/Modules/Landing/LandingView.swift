//
//  LandingViewModel.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct LandingView: View {
    
    @ObservedObject var landingViewModel = LandingViewModel(user: UserModel())
    
    @Binding var navPaths: [Routes]
    
    @State private var manageMatchesClicked: Bool = false
    @State private var bookeauClicked: Bool = false
    
    var body: some View {
            VStack () {
                HeaderView(title: "SPORTPAL", notifications: true, messages: true)
                VStack{
                    Text("Welcome back **\(landingViewModel.user.name)**").font(.title3).foregroundColor(Color(red: 0.1568627450980392, green: 0.6862745098039216, blue: 0.6901960784313725, opacity: 100.0))
                    Text("What would you like to do today?").font(.title3)
                        .foregroundColor(Color(red: 0.1568627450980392, green: 0.6862745098039216, blue: 0.6901960784313725, opacity: 100.0))
                    
                    Link(destination: URL(string: "https://centrodeportivo.bookeau.com/#/login")!) {
                        HStack {
                            // Image on the left with shadow
                            Image("BookeauIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 130) //Set your image size here
                            // Text centered on the right
                            Spacer()
                            Text("Go to field reservation")
                                .font(.title2)
                                .fontWeight(.thin)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                .padding(.horizontal, 50)
                        }.padding()
                        .contentShape(Rectangle())
                        .background(Color.white)
                        .cornerRadius(16)
                    }
                        Button(action: {
                            navPaths.append(.mymatches)
                        })
                        {
                            HStack {
                                // Image on the left with shadow
                                Image("ReservaButton")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 130, height: 130) // Set your image size here
                                // Text centered on the right
                                Spacer()
                                Text("Manage your matches")
                                    .font(.title2)
                                    .fontWeight(.thin)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 40)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                        }
                Spacer()
            }.padding()
                FooterView(viewModel: FooterViewModel(
                    homeButtonAction: NavigateToHomeActionStrategy(),
                    newMatchButtonAction: NavigateToNewMatchActionStrategy(),
                    profileButtonAction: NavigateToProfileActionStrategy()
                ))
                
            }
            .navigationBarBackButtonHidden(true)
            .background(Color(red: 0.961, green: 0.961, blue: 0.961))
        
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView(navPaths: .constant([]))
    }
}
