//
//  NotificationsViewmodel.swift
//  SportPal-iOS
//
//  Created by Familia Ramírez Silva on 10/3/23.
//

import SwiftUI

struct NotificationsViewmodel: View {
    var body: some View {
        NavigationView{
            VStack{
                HeaderView(title: "NOTIFICATIONS", notifications: false, messages: true)
                
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

struct NotificationsViewmodel_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsViewmodel()
    }
}

struct NotificationView: View {
    
    var texto: String
    
    var body: some View {
        HStack() {
            Text(texto)
                .font(.system(size: 25, weight: .light, design: .default)).padding()
                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
            Spacer()
            Image("Arrow")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)

        }.background(Color.white)
    }
    
    
}

