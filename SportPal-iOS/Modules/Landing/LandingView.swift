//
//  LandingViewModel.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct LandingView: View {
    
    @State private var user = "Camilo"
    @State private var manageMatchesClicked: Bool = false
    @State private var bookeauClicked: Bool = false
    
    var body: some View {
        NavigationView {
            VStack () {
                HeaderView(title: "SPORTPAL", notifications: true, messages: true)
                VStack{
                    Text("Welcome back **\(user)**").font(.title3).foregroundColor(Color(red: 0.1568627450980392, green: 0.6862745098039216, blue: 0.6901960784313725, opacity: 100.0))
                    Text("What would you like to do today?").font(.title3)
                        .foregroundColor(Color(red: 0.1568627450980392, green: 0.6862745098039216, blue: 0.6901960784313725, opacity: 100.0))
                    Link(destination: URL(string: "https://centrodeportivo.bookeau.com/#/login")!){
                        Button(action: {})
                        {
                            HStack {
                                // Image on the left with shadow
                                Image("BookeauIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 130, height: 130) // Set your image size here
                                    .shadow(radius: 4)
                                // Text centered on the right
                                Spacer()
                                Text("Go to field reservation")
                                    .font(.title2)
                                    .fontWeight(.thin)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 50)
                            }
                        }.padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(radius: 4)
                    }.padding()
                    
                    NavigationLink(destination: MatchesView(), isActive: $manageMatchesClicked) {
                        Button(action: {
                            // TODO: implement matches
                            manageMatchesClicked = true
                            
                        })
                        {
                            HStack {
                                // Image on the left with shadow
                                Image("ReservaButton")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 130, height: 130) // Set your image size here
                                    .shadow(radius: 4)
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
                            .shadow(radius: 4)
                            
                        }
                        Spacer()
                    }.padding()
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

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
