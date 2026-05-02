//  Copyright (c) 2026

import SwiftUI

struct NoteDetailScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    let note: NoteModel
    private var weatherIconURL: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(note.weatherIcon)@4x.png")
        
    }
    
    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 18) {
                    noteCard
                    weatherCard
                }
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Color.appAccent)
                }
            }
        }
    }
    
    private var noteCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            sectionHeader(
                icon: "note.text",
                title: "Note"
            )
            Text(note.text)
                .font(.SerifDisplayRegular(size: 22))
                .foregroundStyle(Color.appPrimaryText)
                .fixedSize(horizontal: false, vertical: true)
            detailRow(
                icon: "clock",
                title: "Date and time",
                value: note.createdAt.formatted(date: .long, time: .shortened)
            )
        }
        .detailCard()
    }
    
    private var weatherCard: some View {
        VStack(spacing: 22) {
            sectionHeader(
                icon: "cloud.sun.fill",
                title: "Weather"
            )
            weatherIconView
            temperatureView
            VStack(spacing: 12) {
                detailRow(
                    icon: "cloud.fill",
                    title: "Condition",
                    value: note.weatherDescription.capitalized
                )
                
                detailRow(
                    icon: "location.fill",
                    title: "Location",
                    value: note.cityName
                )
            }
        }
        .detailCard()
    }
    
    private var weatherIconView: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.appAccent.opacity(0.22),
                            Color.appAccent.opacity(0.06)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 132, height: 132)
                .overlay(
                    Circle()
                        .strokeBorder(Color.appAccent.opacity(0.18), lineWidth: 1)
                )
                .shadow(color: Color.appAccent.opacity(0.18), radius: 18, x: 0, y: 8)
            AsyncImage(url: weatherIconURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .scaleEffect(0.8)
                        .tint(Color.appAccent)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 104, height: 104)
                case .failure:
                    Image(systemName: "cloud.fill")
                        .font(.system(size: 48, weight: .semibold))
                        .foregroundStyle(Color.appAccent)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
    
    private var temperatureView: some View {
        VStack(spacing: 4) {
            Text("\(Int(note.temperature.rounded()))°C")
                .font(.robotoBold(size: 46))
                .foregroundStyle(Color.appPrimaryText)
            Text(note.weatherDescription.capitalized)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.appSecondaryText)
        }
    }
    
    private func sectionHeader(icon: String, title: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.robotoBold(size: 15))
                .foregroundStyle(.white)
                .frame(width: 30, height: 30)
                .background(
                    Circle()
                        .fill(Color.appAccent)
                )
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(Color.appPrimaryText)
            
            Spacer()
        }
    }
    
    private func detailRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.appAccent)
                .frame(width: 28, height: 28)
                .background(
                    Circle()
                        .fill(Color.appAccent.opacity(0.12))
                )
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.appSecondaryText)
                Text(value)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.appPrimaryText)
            }
            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.appBackground.opacity(0.65))
        )
    }
}

private extension View {
    func detailCard() -> some View {
        self
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 22)
                    .fill(Color.appCardBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
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
    }
}


#Preview {
    NavigationStack {
        NoteDetailScreen(
            note: NoteModel(
                id: UUID(),
                text: "Morning coffee on the balcony — perfect sunny start",
                createdAt: Date(),
                temperature: 22.3,
                weatherDescription: "clear sky",
                weatherIcon: "01d",
                cityName: "Odesa",
                latitude: 46.48,
                longitude: 30.72
            )
        )
    }
}
