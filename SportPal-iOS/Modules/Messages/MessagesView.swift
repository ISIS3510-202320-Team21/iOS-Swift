//
//  MessagesView.swift
//  SportPal-iOS
//
//  Created by Familia Ramírez Silva on 10/18/23.
//

import SwiftUI


struct MessagesView: View {
    
    @Binding var navPaths: [Routes]
    
    var body: some View {
            VStack{
                ZStack(alignment: .topTrailing) {
                    VStack {
                        HeaderBack(title: "MESSAGES") {
                            navPaths.removeLast()
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
                MessageView(navPaths: .constant([]), texto: "How fun was yesterday!", persona: "hombre", nombre: "Benito Martinez")
                MessageView(navPaths: .constant([]), texto: "Looking forward to meet you again!", persona: "mujer", nombre: "Karol. G")
                }
                Spacer()
            }.navigationBarBackButtonHidden(true)
            .background(Color(red: 0.961, green: 0.961, blue: 0.961))
    }
}

struct MessagesViewModel_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(navPaths: .constant([]))
    }
}


struct MessageView: View {
   
    @Binding var navPaths: [Routes]
    
    var texto: String
    var persona: String
    var nombre: String
    
    var body: some View {
            Button(action:{navPaths.append(.chats)}){
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
