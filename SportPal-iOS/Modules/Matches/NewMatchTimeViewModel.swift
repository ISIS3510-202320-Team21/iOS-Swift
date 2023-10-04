//
//  NewMatchTimeViewModel.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct NewMatchTimeView: View {
    @State private var selectedDate = Date()
    
    @State private var selectedTimeInterval = 0
    
    @State private var selectedLevel = 0
        
    var timeIntervals = [
            "12:01AM-1AM", "1AM-2AM", "2AM-3AM", "3AM-4AM", "4AM-5AM", "5AM-6AM",
            "6AM-7AM", "7AM-8AM", "8AM-9AM", "9AM-10AM", "10AM-11AM", "11AM-11:59AM",
            "12:01PM-1PM", "1PM-2PM", "2PM-3PM", "3PM-4PM", "4PM-5PM", "5PM-6PM",
            "6PM-7PM", "7PM-8PM", "8PM-9PM", "9PM-10PM", "10PM-11PM", "11PM-11:59PM"
    ]
    
    var levels = ["Beginner", "Intermediate", "Advanced"]

    var body: some View {
        
        VStack () {
            HeaderView(title: "NEW MATCH", notifications: true, messages: true)
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
                }.background(Color(red: 0.92, green: 0.92, blue: 0.92))
                HStack {
                                Image("TennisIcon")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .padding(.trailing, 10)
                                Text("Tennis")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer() // Add Spacer to push content to the right
                }
                .padding()
                .background(Color(red: 0.92, green: 0.92, blue: 0.92)) // Background color when the element is pressed
                .frame(maxWidth: .infinity, alignment: .leading) // Occupies the whole width
                
                HStack {
                                Spacer() // Add Spacer to push content to the left
                                VStack {
                                    Picker("Level", selection: $selectedLevel) {
                                        ForEach(0..<levels.count, id: \.self) {
                                            Text(self.levels[$0])
                                        }
                                    }
                                }
                                Spacer() // Add Spacer to push content to the right
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1)) // Background color when the element is pressed
                            .frame(maxWidth: .infinity) // Occupies the whole width
                
                HStack {
                                Spacer() // Add Spacer to push content to the left
                                VStack {
                                    Picker("Time Interval", selection: $selectedTimeInterval) {
                                        ForEach(0..<timeIntervals.count, id: \.self) {
                                            Text(self.timeIntervals[$0])
                                        }
                                    }
                                }
                                Spacer() // Add Spacer to push content to the right
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1)) // Background color when the element is pressed
                            .frame(maxWidth: .infinity) // Occupies the whole width
                Spacer()
                Button(action: {
                                // Handle the Create button action
                                print("Create button tapped!")
                            }) {
                                Text("Create")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .padding()
            }.background(Color(red: 0.96, green: 0.96, blue: 0.96))
            
            Spacer()
            Footer()
        }
    }
}

struct NewMatchTimeView_Previews: PreviewProvider {
    static var previews: some View {
        NewMatchTimeView()
    }
}
