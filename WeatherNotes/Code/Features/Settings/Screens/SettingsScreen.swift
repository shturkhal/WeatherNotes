//  Copyright (c) 2026

import SwiftUI

struct SettingsScreen: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 52, weight: .semibold))
                        .foregroundStyle(.secondary)
                    
                    Text("Settings")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    
                    Text("Settings will be added later.")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsScreen()
}
