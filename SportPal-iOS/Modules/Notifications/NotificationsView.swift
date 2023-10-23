//
//  NotificationsViewmodel.swift
//  SportPal-iOS
//
//  Created by Familia Ramírez Silva on 10/3/23.
//

import SwiftUI

struct NotificationsView: View {
    
    @State private var isNavigatingBack: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                HeaderBack(title: "NOTIFICATIONS") {
                    self.isNavigatingBack = true
                }
                VStack{
                NotificationView(texto: "Hi, please rate your match with David")
                NotificationView(texto: "Mr Lòpez wants to see you in a match. Check here for more details")
                NotificationView(texto: "New people ready to match in tennis. All in your preffered hours")
                }
                Spacer()
                FooterView(viewModel: FooterViewModel(
                    homeButtonAction: NavigateToHomeActionStrategy(),
                    newMatchButtonAction: NavigateToNewMatchActionStrategy(),
                    profileButtonAction: NavigateToProfileActionStrategy()
                ))
            }.background(Color(red: 0.961, green: 0.961, blue: 0.961))	
        }.navigationBarBackButtonHidden(true)
        .background(NavigationLink(
            destination: LandingView(),
            isActive: $isNavigatingBack,
            label: {EmptyView()}))
    }
}

struct NotificationsViewmodel_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

struct NotificationView: View {
    
    var texto: String
    
    var body: some View {
        HStack() {
            Text(texto)
                .font(.system(size: 20, weight: .light, design: .default))
                .fontWeight(.thin)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(Color.black)
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .padding(10)
                .foregroundColor(Color.black)

        }.background(Color.white)
    }
    
    
}

