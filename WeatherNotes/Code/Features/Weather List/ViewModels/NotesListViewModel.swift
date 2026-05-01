//  Copyright (c) 2026

import Foundation
import CoreData

@MainActor
final class NotesListViewModel: ObservableObject {
    
    @Published var notes: [NoteModel] = []
    @Published var noteText = ""
    @Published var isShowingAddNote = false
    @Published var isSaving = false
    @Published var errorMessage: String?
    
    private let weatherService = WeatherService()
    private let locationService = LocationService()
    
    func loadNotes(context: NSManagedObjectContext) {
        let request = NoteEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \NoteEntity.createdAt, ascending: false)
        ]
        do {
            let entities = try context.fetch(request)
            notes = entities.map {
                NoteModel(
                    id: $0.id ?? UUID(),
                    text: $0.text ?? "",
                    createdAt: $0.createdAt ?? Date(),
                    temperature: $0.temperature,
                    weatherDescription: $0.weatherDescription ?? "",
                    weatherIcon: $0.weatherIcon ?? "",
                    cityName: $0.cityName ?? "",
                    latitude: $0.latitude,
                    longitude: $0.longitude
                )
            }
        } catch {
            errorMessage = "Failed to load notes"
        }
    }
    
    func saveNote(context: NSManagedObjectContext) {
        let trimmedText = noteText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedText.isEmpty else {
            errorMessage = "Please enter note text"
            return
        }
        
        isSaving = true
        
        Task {
            do {
                let coordinate = try await locationService.requestCurrentLocation()
                
                let weather = try await weatherService.fetchCurrentWeather(
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude
                )
                
                let note = NoteEntity(context: context)
                note.id = UUID()
                note.text = trimmedText
                note.createdAt = Date()
                note.temperature = weather.temperature
                note.weatherDescription = weather.description
                note.weatherIcon = weather.icon
                note.cityName = weather.cityName
                note.latitude = weather.latitude
                note.longitude = weather.longitude
                
                try context.save()
                
                noteText = ""
                isShowingAddNote = false
                isSaving = false
                loadNotes(context: context)
            } catch {
                isSaving = false
                errorMessage = error.localizedDescription
                print("Save note error:", error.localizedDescription)
            }
        }
    }
}
