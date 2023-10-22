//
//  MessagesView.swift
//  SportPal-iOS
//
//  Created by Familia Ramírez Silva on 10/18/23.
//

import SwiftUI

struct MessagesViewModel: View {
    var body: some View {
        NavigationView{
            VStack{
                HeaderView(title: "MESSAGES", notifications: true, messages: false)
                
                Button(action:{}) {
                    Spacer()
                    Image("enviar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 38, alignment: .topLeading)
                        .padding(5)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        
                }.padding()
                VStack{
                MessageView(texto: "How fun was yesterday!", persona: "hombre", nombre: "Benito Martinez")
                MessageView(texto: "Looking forward to meet you again!", persona: "mujer", nombre: "Karol. G")
                }
                Spacer()
                FooterView(viewModel: FooterViewModel(
                    homeButtonAction: NavigateToHomeActionStrategy(),
                    newMatchButtonAction: NavigateToNewMatchActionStrategy(),
                    profileButtonAction: NavigateToProfileActionStrategy()
                ))
            }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
        }
    }
}

struct MessagesViewModel_Previews: PreviewProvider {
    static var previews: some View {
        MessagesViewModel()
    }
}
struct MessageView: View {
    
    var texto: String
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
                Text(texto)
                    .font(.system(size: 15, weight: .light, design: .default))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
            }
            
            Spacer()
            Image("Arrow")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)

        }.background(Color.white)
    }
    
    
}
