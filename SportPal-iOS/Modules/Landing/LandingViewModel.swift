//
//  LandingViewModel.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct LandingViewModel: View {
    
    @State private var user = "Camilo"
    
    var body: some View {
        NavigationView {
            VStack () {
                HeaderView(title: "HOME", notifications: true, messages: true)
                VStack{
                    Text("Welcome back **\(user)**").foregroundColor(Color(red: 0.1568627450980392, green: 0.6862745098039216, blue: 0.6901960784313725, opacity: 100.0))
                    Text("What would you like to do today?")
                        .foregroundColor(Color(red: 0.1568627450980392, green: 0.6862745098039216, blue: 0.6901960784313725, opacity: 100.0))
                    Button(action: {
                        // TODO: link to bookeau

                    }) {
                        HStack(spacing: 40) {
                            Image("BookeauIcon")
                            Text("Go to field reservation").frame(width: 100)
                            Spacer()
                        }.frame(width: 175)
                        .padding(.horizontal, 80)
                        .padding(.vertical, 10)
                        .background(Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .offset(y:50)
                        .shadow(radius: 4, y: 4)
                        
                    }
                    Button(action: {
                        // TODO: implement signup

                    }) {
                        HStack {
                            Image("ReservaButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            Spacer()
                            Text("Manage your matches").frame(width: 100)
                            Spacer()
                        }.frame(width: 175, height: 60)
                        .padding(.horizontal, 80)
                        .padding(.vertical, 10)
                        .background(Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .offset(y:50)
                        .shadow(radius: 4, y: 4)
                        
                    }
                    HStack{
                        Button(action: {
                            // TODO: implement new Chess

                        }) {
                            VStack {
                                Text("New Chess match").frame(width: 100)
                                Spacer()
                                Image("ChessIcon")
                            }.frame(width: 1, height: 150)
                            .padding(.horizontal, 80)
                            .padding(.vertical, 10)
                            .background(Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .offset(y:50)
                            .shadow(radius: 4, y: 4)
                            
                        }
                        Button(action: {
                            // TODO: implement ne Tennis

                        }) {
                            VStack {
                                Text("New Tennis match").frame(width: 100)
                                Image("TennisIcon")
                            }.frame(width: 1, height: 150)
                            .padding(.horizontal, 80)
                            .padding(.vertical, 10)
                            .background(Color(red: 0.9215686274509803, green: 0.9215686274509803, blue: 0.9215686274509803))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .offset(y:50)
                            .shadow(radius: 4, y: 4)
                        }
                    }
                    Spacer()
                }.padding()
                
                Footer()
                
            }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
        }.navigationBarBackButtonHidden()
    }
}

struct LandingViewModel_Previews: PreviewProvider {
    static var previews: some View {
        LandingViewModel()
    }
}
