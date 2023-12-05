//
//  ProfileImageMod.swift
//  SportPal
//
//  Created by Alejandro Tovar on 8/11/23.
//


import SwiftUI

extension Image {
    
    func profileImageMod() -> some View {
        self
            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .padding(.top, 100)
            .frame(width: 200, height: 200)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
    
}
