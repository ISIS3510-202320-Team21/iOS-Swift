//
//  SportPal_iOSApp.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 2/10/23.
//

import SwiftUI

@main
struct SportPal_iOSApp: App {
    
//    @StateObject var user = UserModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
