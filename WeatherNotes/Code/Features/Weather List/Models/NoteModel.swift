//  Copyright (c) 2026

import Foundation

struct NoteModel: Identifiable {
    let id: UUID
    let text: String
    let createdAt: Date
    let temperature: Double
    let weatherDescription: String
    let weatherIcon: String
    let cityName: String
    let latitude: Double
    let longitude: Double
}
