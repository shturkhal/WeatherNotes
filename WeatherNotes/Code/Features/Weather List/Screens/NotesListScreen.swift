//  Copyright (c) 2026

import SwiftUI

struct NotesListScreen: View {
    
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel = NotesListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                if viewModel.notes.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "note.text")
                            .font(.system(size: 52, weight: .semibold))
                            .foregroundStyle(Color.appSecondaryText)
                        Text("No notes yet")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.appPrimaryText)
                        Text("Tap plus button to create your first weather note.")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.appSecondaryText)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                } else {
                    List {
                        ForEach(viewModel.notes) { note in
                            NoteRowView(note: note)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.isShowingAddNote = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(Color.appAccent)
                    }
                }
            }
            .sheet(isPresented: $viewModel.isShowingAddNote) {
                AddNoteScreen(viewModel: viewModel)
                    .presentationDetents([.height(320)])
                    .presentationDragIndicator(.visible)
            }
            .alert("Error", isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onAppear {
                viewModel.loadNotes(context: context)
            }
        }
    }
}

#Preview {
    NotesListScreen()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
