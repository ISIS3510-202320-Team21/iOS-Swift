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
            Text(title)
                .font(.title).padding()
            Spacer()
            if(messages) {
                Button(action:{}) {
                    Image("MessagesIcon")
                }.padding()
            }
            if(notifications) {
                Button(action:{}) {
                    Image("NotificationsIcon")
                }.padding()
            }
        }.background(Color.white)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "TITLE", notifications: true, messages: true)
    }
}
