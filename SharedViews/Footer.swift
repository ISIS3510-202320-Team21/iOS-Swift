//
//  Footer.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct Footer: View {
    var body: some View {
        HStack() {
            Button(action: {
                
            }) {
                Image("HomeButton")
            }.padding()
            Spacer()
            Button(action: {
                
            }) {
                Image("NewMatchButton")
            }.padding()
            Spacer()
            Button(action: {
                
            }) {
                Image("ProfileButton")
            }.padding()
            
        }.background(Color.white)
    }
}

struct Footer_Previews: PreviewProvider {
    static var previews: some View {
        Footer()
    }
}
