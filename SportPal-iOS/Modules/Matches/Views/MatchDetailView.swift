//
//  NewMatchIIIViewModel.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct MatchDetailView: View {
    
    @Binding var navPaths: [Routes]
    
    @ObservedObject var matchesViewModel = MatchesViewModel()
    
    @State private var matchDate: Date = Date()
    
    var body: some View {
        
        VStack () {
            HeaderBack(title: "NEW MATCH") {
                navPaths.removeLast()
            }
            Spacer()
            VStack () {
                Text ("**\(matchesViewModel.getUser().name)**, please carefully check")
                    .font(.title3)
                    .foregroundColor (Color (
                        red: 0.1568627450980392,
                        green: 0.6862745098039216,
                        blue: 0.691960784323725,
                        opacity: 100)).multilineTextAlignment(.center)
                    .padding(.horizontal,20)
                    .padding(.top, 20)
                Text ("match details before confirming:")
                    .font(.title3)
                    .foregroundColor (Color (
                        red: 0.1568627450980392,
                        green: 0.6862745098039216,
                        blue: 0.691960784323725,
                        opacity: 100)).multilineTextAlignment(.center)
                    .padding(.horizontal,20)
                    .padding(.bottom, 20)
                HStack {
                    Image(systemName: "calendar.circle.fill")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .padding(.trailing, 10)
                    
                    Spacer()
                    
                    Text(matchesViewModel.getSelectedMatch().date)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                HStack {
                    Image(systemName: "clock")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .padding(.trailing, 10)
                    
                    Spacer()
                    
                    Text(matchesViewModel.getSelectedMatch().time)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                }.padding()
                    .background(Color.white)
                    .cornerRadius(16)
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .padding(.trailing, 10)
                        .foregroundColor(Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 1.0))
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text(matchesViewModel.getSelectedMatch().user_created.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(matchesViewModel.getSelectedMatch().user_created.email)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                HStack {
                    AsyncImage(url: URL(string: matchesViewModel.getSelectedSport().imageUrl)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .padding(.trailing, 10)
                        case .failure:
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                                .frame(width: 100, height: 100)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text(matchesViewModel.getSelectedSport().name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(matchesViewModel.getSelectedMatch().level.name)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }.padding()
                    .background(Color.white)
                    .cornerRadius(16)
                
                Button(action: {
                    matchesViewModel.manageAcceptMatchClicked() {
                        result in
                        switch result {
                        case true:
                            print("entre al segundo switch")
                            matchesViewModel.fetchUserMatches() {
                                result2 in
                                switch result2 {
                                case true:
                                    navPaths.removeAll()
                                    navPaths.append(.usermatches)
                                case false:
                                    print("entre a false")
                                }
                            }
                        case false:
                            print("entre a false switch 1")
                        }
                    }
                }) {
                    Text("Match!")
                        .font(.title)
                        .padding(.horizontal, 80)
                        .padding(.vertical, 10)
                }.buttonStyle(CustomButtonStyle(isEnabled: true))
                    .padding(.top, 50)
                
                Spacer()
            }.padding().background(Color(red: 0.96, green: 0.96, blue: 0.96))
            Spacer()
            FooterView(navPaths: $navPaths)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{matchDate = convertStringToDate(dateString: matchesViewModel.getSelectedMatch().date)!}
    }
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView(navPaths: .constant([]))
    }
}
