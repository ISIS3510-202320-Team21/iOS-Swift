//
//  NewMatchIIViewModel.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct NewMatchIIView: View {
    @State private var selectedDate = Date()
    
    struct Element {
            var name: String
            var level: String
            var initialHour: String
            var endHour: String
    }

    var elements: [Element] = [
            Element(name: "John", level: "Intermediate", initialHour: "9:00 AM", endHour: "11:00 AM"),
            Element(name: "Alice", level: "Beginner", initialHour: "1:00 PM", endHour: "3:00 PM"),
            Element(name: "Bob", level: "Advanced", initialHour: "4:00 PM", endHour: "6:00 PM")
            // Add more elements as needed
    ]

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
                VStack {
                    ForEach(elements, id: \.name) { element in
                        IndividualMatchViewButton(element: element)
                            .padding(.vertical, 0)
                    }
                    
                    HStack {
                        Image("NewIcon")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Add your preferred times and wait for a match")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                        }
                        Spacer() // Add Spacer to push content to the left
                    }
                    .padding()
                    .background(Color(red: 0.92, green: 0.92, blue: 0.92)) // Background color when the element is pressed
                    .frame(maxWidth: .infinity, alignment: .leading) // Occupies the whole width
                    Spacer()
                }
            }.background(Color(red: 0.96, green: 0.96, blue: 0.96))
            Spacer()
            Footer()
        }
    }
}

struct IndividualMatchViewButton: View {
    var element: NewMatchIIView.Element

    var body: some View {
        Button(action: {
            // Action to perform when the element is clicked
            print("Element \(element.name) Clicked!")
        }) {
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
        .buttonStyle(PlainButtonStyle()) // Remove button style to make it look like a regular HStack
    }
}

struct NewMatchIIView_Previews: PreviewProvider {
    static var previews: some View {
        NewMatchIIView()
    }
}
