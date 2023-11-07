//
//  NewMatchIViewModel.swift
//  SportPal-iOS
//
//  Created by Javier Ramírez Silva on 3/10/23.
//

import SwiftUI

struct NewMatchIView: View {
    
    @Binding var navPaths: [Routes]
    
    @ObservedObject var matchesViewModel = MatchesViewModel()
    
    var body: some View {
            
        VStack () {
            HeaderBack(title: "NEW MATCH") {
                navPaths.removeLast()
            }
            Spacer()
            VStack{
                Text ("**\(matchesViewModel.getUser().name)**, please choose one")
                    .font(.title3)
                    .foregroundColor (Color (
                    red: 0.1568627450980392,
                    green: 0.6862745098039216,
                    blue: 0.691960784323725,
                    opacity: 100)).multilineTextAlignment(.center)
                    .padding(.horizontal,20)
                    .padding(.top, 20)
                Text ("of your sports or add a new one:")
                    .font(.title3)
                    .foregroundColor (Color (
                    red: 0.1568627450980392,
                    green: 0.6862745098039216,
                    blue: 0.691960784323725,
                    opacity: 100)).multilineTextAlignment(.center)
                    .padding(.horizontal,20)
                    .padding(.bottom, 20)
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 10) {
                        ForEach(matchesViewModel.sports, id: \.self) { sport in
                            Button(action: {
                                
                            })
                            {
                                VStack {
                                    VStack {
                                        Text(sport.name)
                                            .font(.title3)
                                            .fontWeight(.thin)
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .multilineTextAlignment(.center)
                                    }
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
                                                        .frame(width: 100, height: 100)
                                                case .failure:
                                                    Image(systemName: "exclamationmark.triangle.fill")
                                                        .foregroundColor(.red)
                                                        .frame(width: 100, height: 100)
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                        }
                                        Spacer()
                                        VStack{
                                            Image(systemName: "chevron.right")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .foregroundColor(.black)
                                                .frame(width: 30, height: 30)
                                                .padding(.top, 60)
                                                .font(Font.title.weight(.thin))
                                        }
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(16)
                            }
                        }
                        Button(action: {
                            
                        })
                        {
                            VStack {
                                VStack {
                                    Text("Add sport")
                                        .font(.title3)
                                        .fontWeight(.thin)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .multilineTextAlignment(.center)
                                }
                                HStack {
                                    VStack{
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(.green)
                                            .frame(width: 100, height: 100)
                                            
                                    }
                                    Spacer()
                                    VStack{
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(.black)
                                            .frame(width: 30, height: 30)
                                            .padding(.top, 60)
                                            .font(Font.title.weight(.thin))
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                        }
                    }
                    .padding()
                Spacer()
            }.background(Color(red: 0.96, green: 0.96, blue: 0.96))
            Spacer()
            FooterView(navPaths: $navPaths)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct NewMatchIView_Previews: PreviewProvider {
    static var previews: some View {
        NewMatchIView(navPaths: .constant([]))
    }
}

