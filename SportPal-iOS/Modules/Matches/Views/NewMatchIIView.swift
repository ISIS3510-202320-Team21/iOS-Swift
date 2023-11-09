//
//  NewMatchIIViewModel.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct NewMatchIIView: View {
    
    @Binding var navPaths: [Routes]
    
    @ObservedObject var matchesViewModel = MatchesViewModel()
    
    @State private var selectedDate = Date()
    
    var body: some View {
        
        VStack () {
            HeaderBack(title: "NEW MATCH") {
                navPaths.removeLast()
            }
            Spacer()
            VStack() {
                VStack {
                    DatePicker(
                        "Match Date",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .padding(.horizontal, 20.0)
                    .frame(height: 50.0)
                }.padding()
                    .background(Color.white)
                    .cornerRadius(16)
                VStack {
                    ForEach(matchesViewModel.getSportMatches(), id: \.self) { match in
                        Button(action: {
                            // Action to perform when the element is clicked
                        }) {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .padding(.trailing, 10)
                                
                                Spacer()
                                
                                VStack(alignment: .center, spacing: 5) {
                                    Text("\(match.user_created.name) - \(match.level.name)")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text(match.time)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()

                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.vertical, 0)
                    }
                    
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Add your preferred times and wait for a match")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                        }
                        Spacer() // Add Spacer to push content to the left
                    }.padding()
                        .background(Color.white)
                        .cornerRadius(16)
                    Spacer()
                }
            }.padding().background(Color(red: 0.96, green: 0.96, blue: 0.96))
            Spacer()
            FooterView(navPaths: $navPaths)
        }.navigationBarBackButtonHidden(true)
    }
}

//struct IndividualMatchViewButton: View {
//    var match: Match
//    
//    var body: some View {
//
//    }
//}

struct NewMatchIIView_Previews: PreviewProvider {
    static var previews: some View {
        NewMatchIIView(navPaths: .constant([]))
    }
}
