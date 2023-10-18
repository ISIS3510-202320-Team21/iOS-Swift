//
//  ChatsViewModel.swift
//  SportPal-iOS
//
//  Created by Familia Ramírez Silva on 10/18/23.
//

import SwiftUI

struct ChatsViewModel: View {
    var body: some View {
        NavigationView{
            VStack( spacing: 0){
                HeaderView(title: "CHAT", notifications: false, messages: true)
                ContactView(name: "J Ramirez", level: "intermediate", title: "Trainer")
                VStack{
                    ChatBubbleView(texto: "What a great workout we just had!", send: false)
                    ChatBubbleView(texto: "Had so much fun last night!", send: true)
                    ChatBubbleView(texto: "Hope to see you again soon", send: false)
                }
                Spacer()
                TextView()
                Footer()
            }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
        }
    }
}

struct ChatsViewModel_Previews: PreviewProvider {
    static var previews: some View {
        ChatsViewModel()
    }
}

struct ChatBubbleView: View {
    
    var texto: String
    var send: Bool
    
    var body: some View {
        HStack() {
            
            if send{
                Spacer()
            }
            Text(texto)
                
                .font(.system(size: 15, weight: .light, design: .default)).padding()
                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                .background( send ? Color.blue: .white)
                .clipShape(RoundedRectangle(cornerRadius: 36.0, style: .continuous))
                .padding(6)
            if !send{
                Spacer()
            }
            
        }
    }
}

struct ContactView: View {
    
    var name: String
    var level: String
    var title: String
    
    var body: some View {
        
        HStack() {
            Image("LoginImg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Text(name + " -")
                .font(.system(size: 20))
            Text(level)
                .font(.system(size: 20))
            Spacer()
        }.background(Color.white)
    }
}

struct TextView: View {
    
    @State private var mensaje: String = ""

    
    var body: some View {
        
        HStack() {
            TextField(
                "Write your message here",
                text: $mensaje
                )
            .padding()
            Spacer()
            Button(action:{}) {
                Image("enviar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            }.padding()
            
            Spacer()
        }
        
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        .padding()
        
        
    }
}
