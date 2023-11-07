//
//  HeaderView.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct HeaderView: View, AppComponent {
    
    @Binding var navPaths: [Routes]
    
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
                Button(action:{navPaths.append(.messages)}) {
                        Image(systemName: "envelope.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 21, height: 21)
                            .foregroundColor(Color.black)
                    }.padding()
            }
            if(notifications) {
                Button(action:{navPaths.append(.notifications)}) {
                        Image(systemName: "bell.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22, height: 22)
                            .foregroundColor(Color.black)
                    }.padding()
            }
        }.background(Color.white)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(navPaths: .constant([]), title: "SPORTPAL", notifications: true, messages: true)
    }
}
