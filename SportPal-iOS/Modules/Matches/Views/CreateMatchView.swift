//
//  NewMatchTimeViewModel.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct CreateMatchView: View {
    
    @Binding var navPaths: [Routes]
    
    @ObservedObject var matchesViewModel = MatchesViewModel()
    
    @State private var selectedDate = Date()
    
    @State private var selectedStartTime = Date()
    
    @State private var selectedEndTime = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    @State private var selectedLevel = 0
    
    @State private var city: String = ""
    
    @State private var court: String = ""
    
    var levels = ["Beginner", "Intermediate", "Advanced"]
    
    var body: some View {
        VStack () {
            HeaderBack(title: "NEW MATCH") {
                navPaths.removeLast()
            }
            Spacer()
            ScrollView() {
                VStack() {
                    
                    DatePicker(
                        "Match Date",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(matchesViewModel.isValidMatchDate(matchDate: selectedDate) ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    
                    DatePicker(
                        "Start Time",
                        selection: $selectedStartTime,
                        displayedComponents: [.hourAndMinute]
                    )
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(matchesViewModel.isValidMatchStartTime(startTime: selectedStartTime) ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    
                    
                    DatePicker(
                        "End Time",
                        selection: $selectedEndTime,
                        displayedComponents: [.hourAndMinute]
                    )
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(matchesViewModel.isValidMatchEndTime(startTime: selectedStartTime, endTime: selectedEndTime) ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    
                    CustomTextField(
                        placeholder: "City",
                        text: $city,
                        isValid: matchesViewModel.isValidCity(city: city)
                    ).padding(.horizontal)
                    
                    CustomTextField(
                        placeholder: "Court",
                        text: $court,
                        isValid: matchesViewModel.isValidCourt(court: court)
                    ).padding(.horizontal)
                    
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
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                    .padding(.horizontal)
                    
                    Picker("Level", selection: $selectedLevel) {
                        Text("Select Level").tag(0)
                        ForEach(1..<4) { level in
                            Text(self.levels[level - 1]).tag(level)
                        }
                    }.pickerStyle(MenuPickerStyle())
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(matchesViewModel.isValidLevel(level: selectedLevel) ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    
                    
                    Button(action: {
                        
                        let dateFormatterDate = DateFormatter()
                        dateFormatterDate.dateFormat = "dd/MM/yyyy"
                        let formattedMatchDate = dateFormatterDate.string(from: selectedDate)
                        
                        let dateFormatterHour = DateFormatter()
                        dateFormatterHour.dateFormat = "HH:mm"
                        
                        let startTimeString = dateFormatterHour.string(from: selectedStartTime)
                        let endTimeString = dateFormatterHour.string(from: selectedEndTime)
                        
                        let formattedMatchTime = "\(startTimeString) - \(endTimeString)"
                        
                        let matchRequest =  MatchRequest(
                            date: formattedMatchDate,
                            time: formattedMatchTime,
                            status: "Pending",
                            court: court,
                            city: city,
                            sport_id: matchesViewModel.getSelectedSport().id,
                            level_id: selectedLevel
                        )
                        matchesViewModel.manageCreateMatchClicked(matchRequest: matchRequest) {
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
                        Text("Create!")
                            .font(.title)
                            .padding(.horizontal, 80)
                            .padding(.vertical, 10)
                    }.buttonStyle(CustomButtonStyle(isEnabled: matchesViewModel.isCreateButtonEnabled(matchDate: selectedDate, matchStartTime: selectedStartTime, matchEndTime: selectedEndTime, city: city, court: court, level: selectedLevel)))
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                        .disabled(!matchesViewModel.isCreateButtonEnabled(matchDate: selectedDate, matchStartTime: selectedStartTime, matchEndTime: selectedEndTime, city: city, court: court, level: selectedLevel))
                    
                    Spacer()
                }.navigationBarBackButtonHidden(true).padding().background(Color(red: 0.96, green: 0.96, blue: 0.96))
            }
            Spacer()
            FooterView(navPaths: $navPaths)
        }
    }
}

struct CreateMatchView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMatchView(navPaths: .constant([]))
    }
}
