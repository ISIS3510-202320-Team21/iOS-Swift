//
//  MatchViewModel.swift
//  SportPal-iOS
//
//  Created by Familia Ramírez Silva on 10/18/23.
//

import SwiftUI

struct MatchViewModel: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack () {
            HeaderView(title: "MATCH", notifications: true, messages: true)
            Spacer()
            VStack () {

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
                
                AdversaryView(hora: "8:00 - 10:00", persona: "hombre", nombre: "J. Ramirez")
                Spacer()
            }.background(Color(red: 0.96, green: 0.96, blue: 0.96))
            
            Spacer()
            Footer()
    }
}
}

struct MatchViewModel_Previews: PreviewProvider {
    static var previews: some View {
        MatchViewModel()
    }
}

struct AdversaryView: View {
    
    var hora: String
    var persona: String
    var nombre: String
    
    var body: some View {
        HStack() {
            Image(persona == "hombre" ? "perfil": "perfilMujer")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
            VStack(alignment: .leading, spacing: 1 ){
                Text(nombre)
                    .font(.system(size: 15, weight: .bold, design: .default)).padding(3)
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                Text(hora)
                    .font(.system(size: 15, weight: .light, design: .default))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
            }
            
            Spacer()
        }.background(Color.white)
    }
    
    
}
