//
//  LandingViewModel.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct LandingView: View {
    
    @Binding var navPaths: [Routes]
    
    @ObservedObject var landingViewModel = LandingViewModel()

    var body: some View {
        VStack () {
            HeaderView(navPaths: $navPaths, title: "SPORTPAL", notifications: true, messages: true)
            VStack () {
                VStack{
                    Text("**\(landingViewModel.locationName)**, \(landingViewModel.country )").font(.title3).foregroundColor(Color(red: 0, green: 0.37, blue: 0.65, opacity: 100.0))
                    Text("**\(String(format: "%.0f", landingViewModel.temperature))°C** - \(landingViewModel.weatherDescription )").font(.body).foregroundColor(Color(red: 0, green: 0.37, blue: 0.65, opacity: 100.0)).padding(.bottom, 8)
                    Text("Welcome back **\(landingViewModel.getUser().name)**").font(.title3).foregroundColor(Color(red: 0.1568627450980392, green: 0.6862745098039216, blue: 0.6901960784313725, opacity: 100.0))
                    Text("What would you like to do today?").font(.body)
                        .foregroundColor(Color(red: 0.1568627450980392, green: 0.6862745098039216, blue: 0.6901960784313725, opacity: 100.0)).padding(.bottom, 8)
                    
                    Link(destination: URL(string: "https://centrodeportivo.bookeau.com/#/login")!) {
                        HStack {
                            Image("BookeauIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 140, height: 140)
                            Spacer()
                            Text("Go to field reservation")
                                .font(.title3)
                                .fontWeight(.thin)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding(.horizontal, 50)
                        }.padding()
                            .contentShape(Rectangle())
                            .background(Color.white)
                            .cornerRadius(16)
                    }
                    Button(action: {
                        navPaths.append(.mymatches)
                    })
                    {
                        HStack {
                            Image("ReservaButton")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 140, height: 140)
                            Spacer()
                            Text("Manage your matches")
                                .font(.title3)
                                .fontWeight(.thin)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 40)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                    }
                    HStack{
                        ForEach(landingViewModel.recentSports, id: \.self) { sport in
                            Button(action: {
                                
                            })
                            {
                                VStack {
                                    HStack {
                                        VStack{
                                            AsyncImage(url: URL(string: sport.imageUrl)) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView()
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 80, height: 80)
                                                case .failure:
                                                    Image(systemName: "exclamationmark.triangle.fill")
                                                        .foregroundColor(.red)
                                                        .frame(width: 80, height: 80)
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                        }
                                        Spacer()
                                        VStack{
                                            Image(systemName: "clock.arrow.circlepath")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .foregroundColor(.black)
                                                .frame(width: 30, height: 30)
                                                .padding(.bottom, 60)
                                                .font(Font.title.weight(.thin))
                                        }
                                    }
                                    VStack {
                                        Text("New \(sport.name)")
                                            .font(.title3)
                                            .fontWeight(.thin)
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .multilineTextAlignment(.center)
                                        Text("match")
                                            .font(.title3)
                                            .fontWeight(.thin)
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .multilineTextAlignment(.center)
                                            
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(16)
                            }
                        }
                    }
                    Spacer()
                }
            }.padding()
            Spacer()
            FooterView(navPaths: $navPaths)
        }
            .navigationBarBackButtonHidden(true)
            .background(Color(red: 0.961, green: 0.961, blue: 0.961))
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView(navPaths: .constant([]))
    }
}
