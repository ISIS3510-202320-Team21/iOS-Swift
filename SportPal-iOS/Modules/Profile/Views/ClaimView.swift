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
    @State private var result: String = ""
    
    private func makeAPIRequest() {
        print("About to make api request")
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            return
        }
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer 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"
        ]
        
        let messages = profileViewModel.getClaims()
        
        var newMessagesArray: [[String: String]] = []
        
        let finalString = "{ \"model\": \"gpt-3.5-turbo\",\"messages\": "
        
        
        let newMessage: [String: String] = [
            "role": "system",
            "content": "You will receive a series of reviews, you must tell me what percentage of the reviews are positive in their sentiment."
        ]
        newMessagesArray.append(newMessage)
        
        for message in messages.prefix(5) {
            let newMessage: [String: String] = [
                "role": "user",
                "content": message.content
            ]
            newMessagesArray.append(newMessage)
        }
        
        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": newMessagesArray
        ]
        
        print(body)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(ChatCompletionResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.result = decodedResponse.choices[0].message.content // Set the result to your model
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
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
                    
                    VStack {
                        Button("Check User acceptance") {
                            //                            profileViewModel.fetchClaims()
                            makeAPIRequest()
                        }
                        Text("API Response: \(result)")
                    }
                    
                    ScrollView{
                        VStack {
                            Text("User claims:")
                            
                            //                            ForEach(0..<profileViewModel.getClaims().count, id: \.self) { index in
                            //                                ClaimDetailView(claim: profileViewModel.getClaims()[index])
                            //                            }
                            ForEach(profileViewModel.getClaims().prefix(5), id: \.self) { claim in
                                ClaimDetailView(claim: claim)
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
                //                    profileViewModel.fetchClaims()
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
                if((claim.user_created) != nil) {
                    Text("User email: \(claim.user_created!.email)")
                        .font(.system(size: 20, design: .default))
                        .fontWeight(.thin)
                        .foregroundColor(Color.black)
                }
                
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

