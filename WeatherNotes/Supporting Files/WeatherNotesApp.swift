//  Copyright (c) 2026

import SwiftUI

@main
struct WeatherNotesApp: App {
    @StateObject private var appState = AppStateManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
    }
}
