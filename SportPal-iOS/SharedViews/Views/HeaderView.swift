//
//  HeaderView.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct HeaderView: View, AppComponent {
    var title: String
    var notifications: Bool
    var messages: Bool
        
    var body: some View {
        HStack() {
            Text("**\(title)**")
                .font(.title).padding()
                .foregroundColor(Color(red: 0, green: 0, blue: 0))
            Spacer()
            if(messages) {
                Button(action:{}) {
                    Image(systemName: "envelope.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 21, height: 21) // Set a fixed size for the image if you want it to dictate the card's height
                        .foregroundColor(Color.black)
                }.padding()
            }
            if(notifications) {
                Button(action:{}) {
                    Image(systemName: "bell.square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 22, height: 22) // Set a fixed size for the image if you want it to dictate the card's height
                        .foregroundColor(Color.black)
                }.padding()
            }
        }.background(Color.white)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "SPORTPAL", notifications: true, messages: true)
    }
}
