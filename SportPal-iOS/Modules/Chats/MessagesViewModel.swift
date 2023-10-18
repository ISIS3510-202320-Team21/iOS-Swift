//
//  MessagesViewModel.swift
//  SportPal-iOS
//
//  Created by Familia Ramírez Silva on 10/18/23.
//

import SwiftUI

struct MessagesViewModel: View {
    var body: some View {
        NavigationView{
            VStack{
                HeaderView(title: "MESSAGES", notifications: true, messages: false)
                
                VStack{
                NotificationView(texto: "Hi, please rate your match with David")
                NotificationView(texto: "Mr Lòpez wants to see you in a match. Check here for more details")
                NotificationView(texto: "New people ready to match in tennis. All in your preffered hours")
                }
                Spacer()
                Footer()
            }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
        }
    }
}

struct MessagesViewModel_Previews: PreviewProvider {
    static var previews: some View {
        MessagesViewModel()
    }
}
