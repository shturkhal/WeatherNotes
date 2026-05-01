//  Copyright (c) 2026

import SwiftUI

@main
struct WeatherNotesApp: App {
    
    @StateObject private var appState = AppStateManager()
    @StateObject private var themeManager = AppThemeManager()
    
    private let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .environmentObject(themeManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(themeManager.colorScheme)
        }
    }
}
