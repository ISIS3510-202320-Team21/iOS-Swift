//
//  ButtonStyle.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 31/10/23.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(isEnabled ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0): Color.gray)
            .foregroundColor(.white)
            .cornerRadius(40)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .contentShape(Rectangle())
    }
}
