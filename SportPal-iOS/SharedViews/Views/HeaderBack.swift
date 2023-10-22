//
//  HeaderBack.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 22/10/23.
//

import SwiftUI

struct HeaderBack: View {
    var title: String
    var onBackAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                onBackAction()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(Color(red: 0, green: 0, blue: 0))
            }
            .padding()
            
            Spacer()
            
            Text("**\(title)**")
                .font(.title)
                .foregroundColor(Color(red: 0, green: 0, blue: 0))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
        
            Spacer()
        }
        .background(Color.white)
    }
}

struct HeaderBack_Previews: PreviewProvider {
    static var previews: some View {
        HeaderBack(title: "SIGN UP") {
            
        }
    }
}
