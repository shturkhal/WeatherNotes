//  Copyright (c) 2026

import SwiftUI

final class AppThemeManager: ObservableObject {
    
    @AppStorage("isDarkThemeEnabled") var isDarkThemeEnabled = false
    
    var colorScheme: ColorScheme {
        isDarkThemeEnabled ? .dark : .light
    }
}
