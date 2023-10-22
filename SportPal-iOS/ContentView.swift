//
//  ContentView.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 2/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("LoadingScreen")
            }.onAppear {                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isLoading = true
                }
            }
            .background(
                        NavigationLink(destination: LoginView(), isActive: $isLoading) {
                            EmptyView()
                        }
            )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
