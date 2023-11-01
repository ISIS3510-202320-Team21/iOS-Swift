//
//  NavigationStackCoordinator.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 31/10/23.
//

import SwiftUI

enum Routes {
    case login
    case signup
    case landing
    case chats
    case profile
}

struct NavigationStackCoordinator: View {
    @State private var navPaths = [Routes]()

    var body: some View {
        NavigationStack(path: $navPaths) {
            LoginView(navPaths: $navPaths).navigationDestination(for: Routes.self) { r in
                switch(r) {
                case .login:
                    LoginView(navPaths: $navPaths)
                case .signup:
                    SignupView(navPaths: $navPaths)
                case .landing:
                    LandingView()
                case .chats:
                    ChatsView()
                case .profile:
                    ProfileView()
                }
            }
        }
    }
}

struct NavigationStackCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackCoordinator()
    }
}
