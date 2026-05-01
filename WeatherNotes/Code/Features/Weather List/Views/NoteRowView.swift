//  Copyright (c) 2026

import SwiftUI

struct NoteRowView: View {
    
    let note: NoteModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(note.text)
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.appPrimaryText)
                .lineLimit(2)
            
            HStack(spacing: 8) {
                Text(note.createdAt.formatted(date: .abbreviated, time: .shortened))
                Text("•")
                Text("\(Int(note.temperature.rounded()))°C")
                Text(note.weatherDescription.capitalized)
            }
            .font(.system(size: 14, weight: .medium, design: .rounded))
            .foregroundStyle(Color.appSecondaryText)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
    }
}
