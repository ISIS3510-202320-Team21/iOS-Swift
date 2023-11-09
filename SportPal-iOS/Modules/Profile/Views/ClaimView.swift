//
//  ClaimView.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 7/11/23.
//

import SwiftUI

struct ClaimView: View {
    
    @ObservedObject private var profileViewModel = ProfileViewModel()
    
    @Binding var navPaths: [Routes]
    
    @State private var claim: String = ""

    var body: some View {
        ScrollView {
            LazyVStack () {
                HeaderBack(title: "NEW CLAIM") {
                    navPaths.removeLast()
                }
                VStack{
                    VStack {
//                        CustomTextField(
//                            placeholder: "Describe your claim...",
//                            text: $claim,
//                            isValid: profileViewModel.isValidName(name: name)
//                        )
//                        ).padding(.horizontal)
                    }.padding(.horizontal, 100)
                    .background(Color.white)
                    .cornerRadius(16)
                    
                }.padding()
                .background(Color(red: 0.961, green: 0.961, blue: 0.961))
                FooterView(navPaths: $navPaths)
            }
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $profileViewModel.showAlert) {
                Alert(title: Text(profileViewModel.alertTitle), message: Text(profileViewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ClaimView_Previews: PreviewProvider {
    static var previews: some View {
        ClaimView(navPaths: .constant([]))
    }
}

