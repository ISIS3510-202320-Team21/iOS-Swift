//
//  ChatsViewModel.swift
//  SportPal-iOS
//
//  Created by Familia Ramírez Silva on 10/18/23.
//
import SwiftUI

struct ChatsView: View {
    
    @Binding var navPaths: [Routes]

    var body: some View {
            VStack( spacing: 0){
                HeaderBack(title: "CHAT") {
                    navPaths.removeLast()
                }
                ContactView(name: "J Ramirez", level: "Intermediate", title: "Trainer")
                VStack{
                    ChatBubbleView(texto: "What a great workout we just had!", send: false)
                    ChatBubbleView(texto: "Had so much fun last night!", send: true)
                    ChatBubbleView(texto: "Hope to see you again soon", send: false)
                }.padding(.top, 30)
                Spacer()
                TextView()
            }
            .navigationBarBackButtonHidden(true)
            .background(Color(red: 0.961, green: 0.961, blue: 0.961))
    }
}

struct ChatsViewModel_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView(navPaths: .constant([]))
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
            if !send{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 10)
            }
            Text(texto)
                .font(.system(size: 15, weight: .light, design: .default)).padding()
                .foregroundColor( send ? Color.white: Color.black)
                .background( send ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0): .white)
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
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(Color.gray)
                .padding(10)
            VStack(alignment: .leading, spacing: 1 ){
                Text(name + " - " + level)
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                Text(title)
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray)
            }
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
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.black)
            }.padding()

            Spacer()
        }

        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        .padding()
    }
}
