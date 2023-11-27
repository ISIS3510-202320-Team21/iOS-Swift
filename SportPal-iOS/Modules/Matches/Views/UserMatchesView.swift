//
//  MatchesView.swift
//  SportPal-iOS
//
//  Created by Familia Ramírez Silva on 10/3/23.
//

import SwiftUI

struct UserMatchesView: View {

    @Binding var navPaths: [Routes]
    
    @ObservedObject var matchesViewModel = MatchesViewModel()
    
    var body: some View {
            VStack{
                ZStack(alignment: .topTrailing) {
                    VStack {
                        HeaderBack(title: "MY MATCHES") {
                            navPaths.removeLast()
                        }
                    }
                    VStack {
                        Button(action:{navPaths.append(.sportsmatch)}) {
                            Image(systemName: "plus.app.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .topLeading)
                                .padding(.top, 4)
                                .foregroundColor(Color.black)
                        }.padding()
                    }
                }
                
                ScrollView {
                    VStack{
                        ForEach(matchesViewModel.getUserMatches(), id: \.self) { match in
                            MatchView(match: match)
                        }
                    }.padding().background(Color(red: 0.961, green: 0.961, blue: 0.961))
                }
                
                Spacer()
                FooterView(navPaths: $navPaths)
        }.navigationBarBackButtonHidden(true)
        .background(Color(red: 0.961, green: 0.961, blue: 0.961))
        .alert(isPresented: $matchesViewModel.showAlert) {
            Alert(title: Text(matchesViewModel.alertTitle), message: Text(matchesViewModel.errorMessage), dismissButton: .default(Text("OK")))
        }
}

struct UserMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        UserMatchesView(navPaths: .constant([]))
    }
}

struct MatchView: View {
    
    var match: Match
    
    var body: some View {
        HStack{
            VStack(alignment: .center, spacing: 1 ){
                if (match.status == "Pending" || match.status == "Out of Date") {
                    Text("\(match.sport.name) match")
                        .font(.system(size: 20, design: .default))
                        .fontWeight(.thin)
                        .foregroundColor(Color.black)
                }
                else {
                    if (match.user_created_id == GlobalParameters.shared.getUser().id) {
                        Text("\(match.sport.name) match with \(match.user_joined!.name)")
                            .font(.system(size: 20, design: .default))
                            .fontWeight(.thin)
                            .foregroundColor(Color.black)
                    }
                    else {
                        Text("\(match.sport.name) match with \(match.user_created.name)")
                            .font(.system(size: 20, design: .default))
                            .fontWeight(.thin)
                            .foregroundColor(Color.black)
                    }
                    
                }
                HStack(){
                    Text("Status:")
                    switch match.status {
                    case "Approved":
                        Text(match.status).foregroundColor(.green)
                    case "Pending":
                        Text(match.status).foregroundColor(.blue)
                    case "Out of Date":
                        Text(match.status).foregroundColor(.red)
                    case "Finished":
                        Text(match.status).foregroundColor(.black)
                    default:
                        Text("No status asigned").foregroundColor(.yellow)
                    }
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
