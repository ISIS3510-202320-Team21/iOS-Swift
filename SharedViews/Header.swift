//
//  Header.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    
    var title: String
    var notifications: Bool
    var messages: Bool
    
    var body: some View {
        HStack() {
            Text(title)
                .font(.title).padding()
            Spacer()
            if(messages) {
                //TODO: Connect to message view
                Button(action:{}) {
                    Image("MessagesIcon")
                }
            }
            if(notifications) {
                //TODO: Connect to notifications view
                Button(action:{}) {
                    Image("NotificationsIcon")
                }.padding()
            }
        }.background(Color.white)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "LOGIN", notifications: true, messages: true)
    }
}
