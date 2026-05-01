//  Copyright (c) 2026

import SwiftUI

struct OnboardingScreen: View {
    
    @EnvironmentObject private var appState: AppStateManager
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.9),
                    Color.cyan.opacity(0.65)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack(spacing: 0) {
                TabView(selection: $viewModel.selectedPage) {
                    ForEach(Array(viewModel.pages.enumerated()), id: \.element.id) { index, page in
                        OnboardingPageView(page: page)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                OnboardingDotsView(
                    count: viewModel.pages.count,
                    selectedIndex: viewModel.selectedPage
                )
                .padding(.bottom, 28)
                Button {
                    viewModel.goNext {
                        appState.finishOnboarding()
                    }
                } label: {
                    Text(viewModel.isLastPage ? "Start" : "Next")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.blue)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.12), radius: 12, x: 0, y: 6)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 34)
            }
        }
    }
}

#Preview {
    OnboardingScreen()
        .environmentObject(AppStateManager())
}

