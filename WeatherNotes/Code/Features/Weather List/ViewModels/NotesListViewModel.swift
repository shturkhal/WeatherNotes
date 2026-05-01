//  Copyright (c) 2026

import Foundation
import CoreData

final class NotesListViewModel: ObservableObject {
    @Published var notes: [NoteModel] = []
    @Published var noteText = ""
    @Published var isShowingAddNote = false
    @Published var errorMessage: String?
    
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
                    createdAt: $0.createdAt ?? Date()
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
        
        let note = NoteEntity(context: context)
        note.id = UUID()
        note.text = trimmedText
        note.createdAt = Date()
        
        do {
            try context.save()
            noteText = ""
            isShowingAddNote = false
            loadNotes(context: context)
        } catch {
            errorMessage = "Failed to save note"
        }
    }
}
