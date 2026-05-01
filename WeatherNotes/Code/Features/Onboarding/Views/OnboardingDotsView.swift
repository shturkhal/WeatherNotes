//  Copyright (c) 2026

import SwiftUI

struct OnboardingDotsView: View {
    
    let count: Int
    let selectedIndex: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<count, id: \.self) { index in
                Capsule()
                    .fill(index == selectedIndex ? Color.white : Color.white.opacity(0.35))
                    .frame(width: index == selectedIndex ? 24 : 8, height: 8)
                    .animation(.easeInOut(duration: 0.25), value: selectedIndex)
            }
        }
    }
}
