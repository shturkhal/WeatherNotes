//  Copyright (c) 2026

import SwiftUI

struct SettingsScreen: View {
    
    @EnvironmentObject private var themeManager: AppThemeManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    headerView
                    VStack(spacing: 12) {
                        Toggle(isOn: $themeManager.isDarkThemeEnabled) {
                            Text("Dark Mode")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(Color.appPrimaryText)
                        }
                        .tint(Color.appAccent)
                        .padding(16)
                        .background(Color.appCardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Settings")
                .font(.custom("DMSerifDisplay-Regular", size: 34))
                .fontWeight(.bold)
                .foregroundStyle(Color.appPrimaryText)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
}

#Preview {
    SettingsScreen()
        .environmentObject(AppThemeManager())
}
