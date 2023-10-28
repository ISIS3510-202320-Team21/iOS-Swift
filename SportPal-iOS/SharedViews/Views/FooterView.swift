//
//  FooterView.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct FooterView: View, AppComponent {
    var viewModel: FooterViewModel
    @State private var homeClicked: Bool = false
    @State private var plusClicked: Bool = false
    @State private var profileClicked: Bool = false
    
    var body: some View {
        HStack() {
            NavigationLink(destination: LandingView(), isActive: $homeClicked) {
                Button(action:{homeClicked = true}) {
                    Image(systemName: "house.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30) // Set a fixed size for the image if you want it to dictate the card's height
                    .foregroundColor(Color.black)
                }.padding(.leading, 40)
            }
            Spacer()
            NavigationLink(destination: NewMatchIView(), isActive: $plusClicked) {
                Button(action: {
                    plusClicked = true
                }) {
                    Image(systemName: "plus.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30) // Set a fixed size for the image if you want it to dictate the card's height
                    .foregroundColor(Color.black)
                }.padding()
            }
            Spacer()
            NavigationLink(destination: ProfileView(), isActive: $profileClicked) {
                Button(action: {
                    profileClicked = true
                }) {
                    Image(systemName: "person.crop.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30) // Set a fixed size for the image if you want it to dictate the card's height
                    .foregroundColor(Color.black)
                }.padding(.trailing, 40)
            }
            
        }.background(Color.white)
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView(viewModel: FooterViewModel(
            homeButtonAction: NavigateToHomeActionStrategy(),
            newMatchButtonAction: NavigateToNewMatchActionStrategy(),
            profileButtonAction: NavigateToProfileActionStrategy()
        ))
    }
}
