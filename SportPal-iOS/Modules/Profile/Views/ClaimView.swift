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
    @State private var claims: [ClaimRequest]?
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        VStack {
            HeaderBack(title: "NEW CLAIM") {
                navPaths.removeLast()
            }
            
            LazyVStack () {
                if(!networkMonitor.isActive) {
                    Text("Claims functionality needs internet connection to function!")
                        .font(.system(size: 20, design: .default))
                        .fontWeight(.thin)
                        .foregroundColor(Color.black)
                } else {
                    VStack{
                        
                        CustomTextField(
                            placeholder: "Describe your claim...",
                            text: $claim,
                            isValid: profileViewModel.isValidClaim(claim: claim)
                        ).padding(.horizontal)
                        
                        Button(action: {
                            let claimRequest =  ClaimRequest(
                                user_created_id: profileViewModel.getUser().id,
                                content: claim
                            )
                            profileViewModel.sendClaim(claimData: claimRequest) {
                                result in
                                switch result {
                                case true:
                                    navPaths.append(.profile)
                                case false: break;
                                }
                            }
                        }) {
                            Text("Send")
                                .font(.title)
                                .padding(.horizontal, 80)
                                .padding(.vertical, 10)
                        }
                        .buttonStyle(CustomButtonStyle(isEnabled: profileViewModel.isValidClaim(claim: claim)))
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                        .disabled(!profileViewModel.isValidClaim(claim: claim))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 50.0)
                    
                    ScrollView{
                        VStack {
                            Text("User claims:")
                            
                            ForEach(0..<profileViewModel.getClaims().count, id: \.self) { index in
                                ClaimDetailView(claim: profileViewModel.getClaims()[index])
                            }
                        }
                    }
                }
                    
                }.padding()
                    .background(Color(red: 0.961, green: 0.961, blue: 0.961))
                    .navigationBarBackButtonHidden(true)
                    .alert(isPresented: $profileViewModel.showAlert) {
                        Alert(title: Text(profileViewModel.alertTitle), message: Text(profileViewModel.errorMessage), dismissButton: .default(Text("OK")))
                    }
                Spacer()
                FooterView(navPaths: $navPaths)
            }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
                .onAppear() {
                    print("VStack appeared")
                    //                profileViewModel.fetchClaims() {
                    //                    result in
                    //                    switch result {
                    //                    case true:
                    //                        print("Claims fethed")
                    //                    case false:
                    //                        print("Claims failed")
                    //                    }
                    //                }
                }
            
        }
    }
    
    struct ClaimView_Previews: PreviewProvider {
        static var previews: some View {
            ClaimView(navPaths: .constant([]))
        }
    }
    
    struct ClaimDetailView: View {
        
        var claim: Claim
        
        var body: some View {
            HStack{
                VStack(alignment: .center, spacing: 1 ){
                    
                    Text("User email: \(claim.user_created.email)")
                        .font(.system(size: 20, design: .default))
                        .fontWeight(.thin)
                        .foregroundColor(Color.black)
                    
                    
                    Text("Says: \(claim.content)")
                        .font(.system(size: 20, design: .default))
                        .fontWeight(.thin)
                        .foregroundColor(Color.black)
                    
                }
                
            }.padding()
                .background(Color.white)
                .cornerRadius(16)
        }
    }
    
