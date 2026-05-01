//  Copyright (c) 2026

import SwiftUI

struct NoteRowView: View {
    
    let note: NoteModel
    
    private var weatherIconURL: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(note.weatherIcon)@2x.png")
    }
    
    var body: some View {
        HStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 3)
                .fill(
                    LinearGradient(
                        colors: [Color.appAccent, Color.appAccent.opacity(0.4)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 4)
                .padding(.vertical, 16)
                .padding(.leading, 16)
            HStack(spacing: 14) {
                weatherIconView
                VStack(alignment: .leading, spacing: 8) {
                    Text(note.text)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.appPrimaryText)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(Color.appSecondaryText.opacity(0.7))
                        Text(note.createdAt.formatted(date: .abbreviated, time: .shortened))
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.appSecondaryText)
                        Spacer()
                        temperatureBadge
                    }
                }
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.appCardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.6),
                                    Color.white.opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: Color.black.opacity(0.07), radius: 16, x: 0, y: 6)
                .shadow(color: Color.appAccent.opacity(0.06), radius: 8, x: 0, y: 2)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
    }
    
    private var temperatureBadge: some View {
        HStack(spacing: 2) {
            Image(systemName: "thermometer.medium")
                .font(.system(size: 11, weight: .semibold))
            Text("\(Int(note.temperature.rounded()))°")
                .font(.system(size: 13, weight: .bold, design: .rounded))
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(
            Capsule()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.appAccent,
                            Color.appAccent.opacity(0.75)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: Color.appAccent.opacity(0.35), radius: 6, x: 0, y: 3)
        )
    }
    
    private var weatherIconView: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.appAccent.opacity(0.18),
                            Color.appAccent.opacity(0.06)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 54, height: 54)
                .overlay(
                    Circle()
                        .strokeBorder(Color.appAccent.opacity(0.15), lineWidth: 1)
                )
            
            AsyncImage(url: weatherIconURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .scaleEffect(0.65)
                        .tint(Color.appAccent)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                case .failure:
                    Image(systemName: "cloud.fill")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.appAccent)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 0) {
            NoteRowView(
                note: NoteModel(
                    id: UUID(),
                    text: "Walked in the park after work",
                    createdAt: Date(),
                    temperature: 9.75,
                    weatherDescription: "overcast clouds",
                    weatherIcon: "04d",
                    cityName: "Pushcha-Vodytsya",
                    latitude: 50.45,
                    longitude: 30.52
                )
            )
            NoteRowView(
                note: NoteModel(
                    id: UUID(),
                    text: "Morning coffee on the balcony — perfect sunny start",
                    createdAt: Date().addingTimeInterval(-86400),
                    temperature: 22.3,
                    weatherDescription: "clear sky",
                    weatherIcon: "01d",
                    cityName: "Odesa",
                    latitude: 46.48,
                    longitude: 30.72
                )
            )
        }
        .padding(.vertical, 12)
    }
    .background(Color.appBackground)
}
