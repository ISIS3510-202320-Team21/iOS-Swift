import SwiftUI

class MatchesViewModel: ObservableObject {
    @Published var sports: [Sport] = [
        Sport(name: "Tennis", imageURL: ""),
        Sport(name: "Chess", imageURL: ""),
        Sport(name: "Volleyball", imageURL: ""),
        Sport(name: "Billiards", imageURL: ""),
        Sport(name: "Basketball", imageURL: "")
    ]
}
