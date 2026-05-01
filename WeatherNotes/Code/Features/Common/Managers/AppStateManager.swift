//  Copyright (c) 2026

import SwiftUI

final class AppStateManager: ObservableObject {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboardingStorage = false
    
    @Published var isShowingSplash = true
    
    var hasSeenOnboarding: Bool {
        hasSeenOnboardingStorage
    }
    
    func finishSplash() {
        withAnimation(.easeInOut(duration: 0.35)) {
            isShowingSplash = false
        }
    }
    
    func finishOnboarding() {
        hasSeenOnboardingStorage = true
        objectWillChange.send()
    }
}
