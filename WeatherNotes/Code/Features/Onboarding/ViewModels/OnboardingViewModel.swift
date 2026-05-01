//  Copyright (c) 2026

import Foundation

final class OnboardingViewModel: ObservableObject {
    
    @Published var selectedPage = 0
    
    let pages: [OnboardingPage] = [
        OnboardingPage(
            imageName: "note.text",
            title: "Create Weather Notes",
            subtitle: "Write notes about your walks, trips, runs, or daily moments."
        ),
        OnboardingPage(
            imageName: "cloud.sun.rain.fill",
            title: "Weather Is Added Automatically",
            subtitle: "Every note saves the current weather, temperature, and condition."
        ),
        OnboardingPage(
            imageName: "list.bullet.rectangle.portrait.fill",
            title: "Keep Your Moments Organized",
            subtitle: "View all notes in one place and open details anytime."
        )
    ]
    
    var isLastPage: Bool {
        selectedPage == pages.count - 1
    }
    
    func goNext(onFinish: () -> Void) {
        if isLastPage {
            onFinish()
        } else {
            selectedPage += 1
        }
    }
}
