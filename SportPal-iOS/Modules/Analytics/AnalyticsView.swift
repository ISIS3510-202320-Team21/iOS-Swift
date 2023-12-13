//
//  AnalyticsView.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 4/12/23.
//

import SwiftUI

struct AnalyticsView: View {
    
    @Binding var navPaths: [Routes]
    
    @ObservedObject var analyticsViewModel = AnalyticsViewModel()
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        VStack () {
            HeaderBack(title: "ANALYTICS") {
                navPaths.removeLast()
            }
            
            LazyVStack () {
                if(!networkMonitor.isActive) {
                    Text("Analytics functionality needs internet connection to function!")
                        .font(.system(size: 20, design: .default))
                        .fontWeight(.thin)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                } else {
                    VStack{
                        Text ("**\(analyticsViewModel.getUser().name)**, here are the most")
                            .font(.title3)
                            .foregroundColor (Color (
                                red: 0.1568627450980392,
                                green: 0.6862745098039216,
                                blue: 0.691960784323725,
                                opacity: 100)).multilineTextAlignment(.center)
                            .padding(.horizontal,20)
                            .padding(.top, 20)
                        Text ("relevant stats in SportPal:")
                            .font(.title3)
                            .foregroundColor (Color (
                                red: 0.1568627450980392,
                                green: 0.6862745098039216,
                                blue: 0.691960784323725,
                                opacity: 100)).multilineTextAlignment(.center)
                            .padding(.horizontal,20)
                            .padding(.bottom, 20)
                        Spacer()
                    }.background(Color(red: 0.96, green: 0.96, blue: 0.96))
                    ScrollView{
                        VStack {
                            HStack {
                                AsyncImage(url: URL(string: analyticsViewModel.getFavoriteSport1().imageUrl)) { phase in
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
                                    Text("Your most favorite sport is \(analyticsViewModel.getFavoriteSport1().name) with \(analyticsViewModel.getFavoriteSport1().count!) matches.")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                }
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                            .padding(.horizontal)
                            HStack {
                                AsyncImage(url: URL(string: analyticsViewModel.getFavoriteSport2().imageUrl)) { phase in
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
                                    Text("Your second most favorite sport is \(analyticsViewModel.getFavoriteSport2().name) with \(analyticsViewModel.getFavoriteSport2().count!) matches.")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                }
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                            .padding(.horizontal)
                        }
                    }
                }
                
            }.padding()
                .background(Color(red: 0.961, green: 0.961, blue: 0.961))
                .navigationBarBackButtonHidden(true)
            Spacer()
            FooterView(navPaths: $navPaths)
        }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
        .onAppear {
            AnalyticsViewModel.init()
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView(navPaths: .constant([]))
    }
}
