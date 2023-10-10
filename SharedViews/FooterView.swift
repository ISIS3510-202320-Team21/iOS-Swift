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
                Image("HomeButton")
            }.padding()
            Spacer()
            Button(action: {
                viewModel.newMatchButtonAction.performAction()
            }) {
                Image("NewMatchButton")
            }.padding()
            Spacer()
            Button(action: {
                viewModel.profileButtonAction.performAction()
            }) {
                Image("ProfileButton")
            }.padding()
            
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
