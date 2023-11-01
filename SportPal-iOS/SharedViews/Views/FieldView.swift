//
//  FieldView.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 22/10/23.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isValid: Bool?
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(isValid ?? true ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
            .padding(.vertical, 10)
            .autocapitalization(.none)
    }
}

struct CustomSecureField: View {
    var placeholder: String
    @Binding var text: String
    var isValid: Bool?
    
    var body: some View {
        SecureField(placeholder, text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(isValid ?? true ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
            .padding(.vertical, 10)
    }
}

