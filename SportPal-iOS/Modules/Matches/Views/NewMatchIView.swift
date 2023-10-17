//
//  NewMatchIViewModel.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct NewMatchIView: View {
    
    @State private var user = "Camilo"
    
    var body: some View {
        let images: [String] = ["TennisButton", "BaseballButton", "ChessButton", "BasketballButton", "VolleyballButton", "NewSportButton"]
            
        VStack () {
            HeaderView(title: "NEW MATCH", notifications: true, messages: true)
            Spacer()
            VStack{
                Text ("**\(user)**, please choose one of your")
                    .font(.title3)
                    .foregroundColor (Color (
                    red: 0.1568627450980392,
                    green: 0.6862745098039216,
                    blue: 0.691960784323725,
                    opacity: 100)).multilineTextAlignment(.center)
                    .padding(.horizontal,20)
                    .padding(.top, 20)
                Text ("sports or add a new one:")
                    .font(.title3)
                    .foregroundColor (Color (
                    red: 0.1568627450980392,
                    green: 0.6862745098039216,
                    blue: 0.691960784323725,
                    opacity: 100)).multilineTextAlignment(.center)
                    .padding(.horizontal,20)
                    .padding(.bottom, 20)
                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 10) {
                                ForEach(images, id: \.self) { imageName in
                                    Button(action: {
                                        print("Image \(imageName) clicked!")
                                    }) {
                                        Image(imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                }
                            }
                            .padding()  
                
                Spacer()
            }.background(Color(red: 0.96, green: 0.96, blue: 0.96))
            Spacer()
            FooterView(viewModel: FooterViewModel(
                homeButtonAction: NavigateToHomeActionStrategy(),
                newMatchButtonAction: NavigateToNewMatchActionStrategy(),
                profileButtonAction: NavigateToProfileActionStrategy()
            ))
        }
    }
}

struct NewMatchIView_Previews: PreviewProvider {
    static var previews: some View {
        NewMatchIView()
    }
}

