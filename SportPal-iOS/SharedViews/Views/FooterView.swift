//
//  FooterView.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct FooterView: View, AppComponent {
    var viewModel: FooterViewModel
    var body: some View {
        HStack() {
            Button(action: {
                viewModel.homeButtonAction.performAction()
            }) {
                Image(systemName: "house.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30) // Set a fixed size for the image if you want it to dictate the card's height
                .foregroundColor(Color.black)
            }.padding(.leading, 40)
            Spacer()
            Button(action: {
                viewModel.newMatchButtonAction.performAction()
            }) {
                Image(systemName: "plus.square.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30) // Set a fixed size for the image if you want it to dictate the card's height
                .foregroundColor(Color.black)
            }.padding()
            Spacer()
            Button(action: {
                viewModel.profileButtonAction.performAction()
            }) {
                Image(systemName: "person.crop.square.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30) // Set a fixed size for the image if you want it to dictate the card's height
                .foregroundColor(Color.black)
            }.padding(.trailing, 40)
            
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
