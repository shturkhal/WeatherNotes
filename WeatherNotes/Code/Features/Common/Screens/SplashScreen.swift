//  Copyright (c) 2026

import SwiftUI

struct SplashScreen: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.85),
                    Color.cyan.opacity(0.65)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.18))
                        .frame(width: 150, height: 150)
                        .scaleEffect(isAnimating ? 1.1 : 0.9)
                    
                    Image(systemName: "cloud.sun.fill")
                        .font(.system(size: 72, weight: .bold))
                        .foregroundStyle(.white)
                        .scaleEffect(isAnimating ? 1.05 : 0.95)
                }
                
                VStack(spacing: 8) {
                    Text("Weather Notes")
                        .font(.SerifDisplayRegular(size: 38))
                        .foregroundStyle(.white)
                    
                    Text("Save moments with the weather")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.85))
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}

#Preview {
    SplashScreen()
}
