//  Copyright (c) 2026

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var appState: AppStateManager
    
    var body: some View {
        ZStack {
            if appState.isShowingSplash {
                SplashScreen()
                    .transition(.opacity)
            } else {
                if appState.hasSeenOnboarding {
                    MainTabScreen()
                        .transition(.opacity)
                } else {
                    OnboardingScreen()
                        .transition(.opacity)
                }
            }
        }
        .animation(.easeInOut(duration: 0.35), value: appState.isShowingSplash)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                appState.finishSplash()
            }
        }
    }
}
