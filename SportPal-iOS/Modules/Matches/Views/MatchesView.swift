//
//  MatchesView.swift
//  SportPal-iOS
//
//  Created by Familia Ramírez Silva on 10/3/23.
//

import SwiftUI

struct MatchesView: View {
    
    @State private var sport = "Tennis"
    @State private var user = "M. Diaz"
    
    var body: some View {   
        NavigationView{
            VStack{
                HeaderView(title: "MATCHES", notifications: true, messages: true)
                
                VStack{
                    Image("Add")
                        .resizable()
                        .background(Color.white)
                        .frame(width: 40, height: 40)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding([.top, .trailing], 10)
                        
                        
                    MatchView(texto: "\(sport) match with \(user)")
                    Spacer()
                    FooterView(viewModel: FooterViewModel(
                        homeButtonAction: NavigateToHomeActionStrategy(),
                        newMatchButtonAction: NavigateToNewMatchActionStrategy(),
                        profileButtonAction: NavigateToProfileActionStrategy()
                    ))
            }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
        }
        
        
        
        
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView()
    }
}

struct MatchView: View {
    
    var texto: String
    
    var body: some View {
        VStack{
            HStack() {
                    Text(texto)
                        .font(.system(size: 25, weight: .light, design: .default)).padding()
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                        .multilineTextAlignment(.center)
                    Spacer()
                    Image("Arrow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
            HStack{
                Text("Status:")
                    .padding([.leading], 20)
                Text("Approved")
                    .foregroundColor(.green)
                Spacer()
                    
            }
            .padding([.bottom], 10)

            
        }
        .background(Color.white)
        .padding([.bottom, .top], 10)
    }
}
    
}
