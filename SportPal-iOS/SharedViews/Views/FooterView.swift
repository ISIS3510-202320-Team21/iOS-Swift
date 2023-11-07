//
//  FooterView.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct FooterView: View, AppComponent {
    
    @Binding var navPaths: [Routes]
        
    var body: some View {
        HStack() {
            Button(action:{
                if navPaths.last != .landing {
                    navPaths.append(.landing)
                }
            }) {
                    Image(systemName: "house.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.black)
                }.padding(.leading, 40)
            Spacer()
                Button(action: {
                    if navPaths.last != .newmatchi {
                        navPaths.append(.newmatchi)
                    }
                }) {
                    Image(systemName: "plus.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.black)
                }.padding()
            Spacer()
                Button(action: {
                    if navPaths.last != .profile {
                        navPaths.append(.profile)
                    }
                }) {
                    Image(systemName: "person.crop.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.black)
                }.padding(.trailing, 40)
        }.background(Color.white)
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView(navPaths: .constant([]))
    }
}
