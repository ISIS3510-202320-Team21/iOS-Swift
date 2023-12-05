//
//  ContentView.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 2/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var networkMonitor = NetworkMonitor()
    @State private var showAlert = false
    
    var body: some View {
        NavigationStackCoordinator()
            .onChange(of: networkMonitor.isActive) { newValue in
                showAlert = !newValue}
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("No Internet Connection"),
                    message: Text("Limited features on the app."),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
