//  Copyright (c) 2026

import SwiftUI

@main
struct WeatherNotesApp: App {
    @StateObject private var appState = AppStateManager()
    private let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
