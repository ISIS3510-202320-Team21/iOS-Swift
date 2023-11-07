//
//  MatchesView.swift
//  SportPal-iOS
//
//  Created by Familia Ramírez Silva on 10/3/23.
//

import SwiftUI

struct MatchesView: View {
    
    @Binding var navPaths: [Routes]
    
    @State private var sport = "Tennis"
    @State private var user = "M. Diaz"
    @State private var isNavigatingBack: Bool = false
    
    var body: some View {
            VStack{
                ZStack(alignment: .topTrailing) {
                    VStack {
                        HeaderBack(title: "MATCHES") {
                            navPaths.removeLast()
                        }
                    }
                    VStack {
                        Button(action:{navPaths.append(.newmatchi)}) {
                            Image(systemName: "plus.app.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .topLeading)
                                .padding(.top, 4)
                                .foregroundColor(Color.black)
                        }.padding()
                    }
                }
                
                VStack{
                    MatchView(texto: "\(sport) match with \(user)")
                }.padding().background(Color(red: 0.961, green: 0.961, blue: 0.961))
                
                Spacer()
                FooterView(navPaths: $navPaths)
        }.navigationBarBackButtonHidden(true)
        .background(Color(red: 0.961, green: 0.961, blue: 0.961))
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView(navPaths: .constant([]))
    }
}

struct MatchView: View {
    
    var texto: String
    
    var body: some View {
        HStack{
            VStack(alignment: .center, spacing: 1 ){
                Text(texto)
                .font(.system(size: 20, design: .default))
                .fontWeight(.thin)
                .foregroundColor(Color.black)
                HStack(){
                    Text("Status:")
                    Text("Approved")
                        .foregroundColor(.green)
                }
            }.padding()
            
            Spacer()
            
            Image(systemName: "chevron.right")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .padding(10)
            .foregroundColor(Color.black)

        }.padding()
        .background(Color.white)
        .cornerRadius(16)
    }
}
    
}
