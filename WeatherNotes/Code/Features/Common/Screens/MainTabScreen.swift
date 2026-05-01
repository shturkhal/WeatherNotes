//  Copyright (c) 2026

import SwiftUI

struct MainTabScreen: View {
    
    var body: some View {
        TabView {
            NotesListScreen()
                .tabItem {
                    Image(systemName: "note.text")
                    Text("Notes")
                }
            
            SettingsScreen()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    MainTabScreen()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
