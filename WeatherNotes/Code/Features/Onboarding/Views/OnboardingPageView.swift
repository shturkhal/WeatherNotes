//  Copyright (c) 2026

import SwiftUI

struct OnboardingPageView: View {
    
    let page: OnboardingPage
    
    var body: some View {
        VStack {
            Spacer(minLength: 40)
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.18))
                    .frame(width: 220, height: 220)
                
                Image(systemName: page.imageName)
                    .font(.system(size: 92, weight: .bold))
                    .foregroundStyle(.white)
            }
            .frame(height: 260)
            VStack(spacing: 14) {
                Text(page.title)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28)
                    .frame(height: 80)
                Text(page.subtitle)
                    .font(.system(size: 17, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 28)
                    .frame(height: 90)
            }
            .frame(height: 180)
            
            Spacer()
        }
    }
}

#Preview {
    OnboardingPageView(
        page: OnboardingPage(
            imageName: "cloud.sun.fill",
            title: "Weather Notes",
            subtitle: "Save your notes with weather information."
        )
    )
    .background(Color.blue)
}
