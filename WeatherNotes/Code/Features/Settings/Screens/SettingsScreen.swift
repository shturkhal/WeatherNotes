//  Copyright (c) 2026

import SwiftUI

struct SettingsScreen: View {
    
    @EnvironmentObject private var themeManager: AppThemeManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    settingsHeader
                    VStack(spacing: 0) {
                        Toggle(isOn: $themeManager.isDarkThemeEnabled) {
                            HStack(spacing: 12) {
                                Image(systemName: "moon.fill")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(Color.appAccent)
                                Text("Dark theme")
                                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                                    .foregroundStyle(Color.appPrimaryText)
                            }
                        }
                        .tint(Color.appAccent)
                        .padding(16)
                    }
                    .background(Color.appCardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding(.horizontal, 16)
                    
                    Spacer()
                }
                .padding(.top, 24)
            }
            .navigationTitle("Settings")
        }
    }
    
    private var settingsHeader: some View {
        VStack(spacing: 12) {
            Image(systemName: "gearshape.fill")
                .font(.system(size: 52, weight: .semibold))
                .foregroundStyle(Color.appSecondaryText)
            Text("Settings")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundStyle(Color.appPrimaryText)
            Text("Manage your app preferences.")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(Color.appSecondaryText)
        }
    }
}

#Preview {
    SettingsScreen()
        .environmentObject(AppThemeManager())
}
