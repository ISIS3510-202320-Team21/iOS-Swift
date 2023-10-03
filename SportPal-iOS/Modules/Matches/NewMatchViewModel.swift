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
        let images: [String] = ["TennisIcon", "BaseballIcon", "ChessIcon", "BasketballIcon", "VolleyballIcon", "NewSportIcon"]
        
        VStack () {
            HeaderView(title: "NEW MATCH", notifications: true, messages: true)
            VStack{
                Text("Camilo, please choose one of your sports, or add a new one:").font(.title3)                        .padding(.vertical, 20).padding(.horizontal, 20).multilineTextAlignment(.center)
                
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

        }
    }
}

struct NewMatchView_Previews: PreviewProvider {
    static var previews: some View {
        NewMatchView()
    }
}

