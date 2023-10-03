//
//  NewMatchIIIViewModel.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct NewMatchIIIView: View {
    @State private var selectedDate = Date()
    
    struct Element {
            var name: String
            var level: String
            var initialHour: String
            var endHour: String
    }

    var element = Element(name: "John", level: "Intermediate", initialHour: "9:00 AM", endHour: "11:00 AM")
    

    var body: some View {
        
        VStack () {
            HeaderView(title: "NEW MATCH", notifications: true, messages: true)
            Spacer()
            VStack () {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Match Created!")
                        .font(.headline)
                        .foregroundColor(.primary)
                    }
                                
                    Spacer() // Add Spacer to push content to the right
                                
                    Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green) // Set color for the checkmark icon
                    .padding(.leading, 10)
                    }
                    .padding()
                    .background(Color(red: 0.92, green: 0.92, blue: 0.92)) // Background color when the element is pressed
                    .frame(maxWidth: .infinity, alignment: .leading) // Occupies the whole width
                VStack {
                    DatePicker(
                        "Match Date",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .padding(.horizontal, 20.0)
                    .frame(height: 50.0)
                }.background(Color(red: 0.92, green: 0.92, blue: 0.92))
                IndividualMatchView(element: element)
                    .padding(.vertical, 0)
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
                Spacer()
            }.background(Color(red: 0.96, green: 0.96, blue: 0.96))
            Spacer()
            Footer()
        }
    }
}

struct IndividualMatchView: View {
    var element: NewMatchIIIView.Element

    var body: some View {
            HStack {
                // Left side: Circular profile picture
                Image("LoginImg")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .padding(.trailing, 10) // Adjust the spacing between the image and text

                // Right side: Text content
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(element.name) - \(element.level)")
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text("\(element.initialHour) - \(element.endHour)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer() // Add Spacer to push content to the left
            }
            .padding()
            .background(Color(red: 0.92, green: 0.92, blue: 0.92)) // Background color when the element is pressed
            .frame(maxWidth: .infinity, alignment: .leading) // Occupies the whole width
    }
}

struct NewMatchIIIView_Previews: PreviewProvider {
    static var previews: some View {
        NewMatchIIIView()
    }
}
