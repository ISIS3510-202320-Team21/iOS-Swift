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
    case editprofile
    case claim
    case usermatches
    case notifications
    case messages
    case sportsmatch
    case matchessport
    case matchdetail
    case creatematch
    case analytics
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
                    LandingView(navPaths: $navPaths)
                case .chats:
                    ChatsView(navPaths: $navPaths)
                case .profile:
                    ProfileView(navPaths: $navPaths)
                case .editprofile:
                    EditProfileView(navPaths: $navPaths)
                case .claim:
                    ClaimView(navPaths: $navPaths)
                case .usermatches:
                    UserMatchesView(navPaths: $navPaths)
                case .notifications:
                    NotificationsView(navPaths: $navPaths)
                case .messages:
                    MessagesView(navPaths: $navPaths)
                case .sportsmatch:
                    SportsMatchView(navPaths: $navPaths)
                case .matchessport:
                    MatchesSportView(navPaths: $navPaths)
                case .matchdetail:
                    MatchDetailView(navPaths: $navPaths)
                case .creatematch:
                    CreateMatchView(navPaths: $navPaths)
                case .analytics:
                    AnalyticsView(navPaths: $navPaths)
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
