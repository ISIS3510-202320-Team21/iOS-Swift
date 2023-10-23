//
//  MessagesView.swift
//  SportPal-iOS
//
//  Created by Familia Ramírez Silva on 10/18/23.
//

import SwiftUI


struct MessagesView: View {
    
    @State private var isNavigatingBack: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack(alignment: .topTrailing) {
                    VStack {
                        HeaderBack(title: "MESSAGES") {
                            self.isNavigatingBack = true
                        }
                    }
                    VStack {
                        Button(action:{}) {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .topLeading)
                                .padding(.top, 4)
                                .foregroundColor(Color.black)
                        }.padding()
                    }
                }
                
                VStack{
                MessageView(texto: "How fun was yesterday!", persona: "hombre", nombre: "Benito Martinez")
                MessageView(texto: "Looking forward to meet you again!", persona: "mujer", nombre: "Karol. G")
                }
                Spacer()
//                FooterView(viewModel: FooterViewModel(
//                    homeButtonAction: NavigateToHomeActionStrategy(),
//                    newMatchButtonAction: NavigateToNewMatchActionStrategy(),
//                    profileButtonAction: NavigateToProfileActionStrategy()
//                ))
            }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
        }.navigationBarBackButtonHidden(true)
        .background(NavigationLink(
            destination: LandingView(),
            isActive: $isNavigatingBack,
            label: {EmptyView()}))
    }
}

struct MessagesViewModel_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}


struct MessageView: View {
    @State private var chatClicked: Bool = false
    
    var texto: String
    var persona: String
    var nombre: String
    
    var body: some View {
        NavigationLink(destination: ChatsView(), isActive: $chatClicked) {
            Button(action:{chatClicked = true}){
                HStack() {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .padding(10)
                        .foregroundColor(Color.gray)
                    VStack(alignment: .leading, spacing: 1 ){
                        Text(nombre)
                            .font(.system(size: 16, weight: .bold, design: .default))
                            .fontWeight(.regular)
                            .padding(3)
                            .foregroundColor(Color.black)
                        Text(texto)
                            .font(.system(size: 16, weight: .light, design: .default))
                            .foregroundColor(Color.gray)
                    }
                    
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .padding(10)
                        .foregroundColor(Color.black)
                    
                }.background(Color.white)
            }
            
        }
    }
    
    
}
