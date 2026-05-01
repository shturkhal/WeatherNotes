//  Copyright (c) 2026

import SwiftUI

struct NotesListScreen: View {
    
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel = NotesListViewModel()
    @State private var selectedNote: NoteModel?
    @State private var isPulsing = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                if viewModel.notes.isEmpty {
                    emptyStateView
                } else {
                    notesList
                }
                addFloatingButton
            }
            .navigationTitle("Notes")
            .sheet(isPresented: $viewModel.isShowingAddNote) {
                AddNoteScreen(viewModel: viewModel)
                    .presentationDetents([.height(320)])
                    .presentationDragIndicator(.visible)
            }
            .navigationDestination(item: $selectedNote) { note in
                NoteDetailScreen(note: note)
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
                
                withAnimation(.easeInOut(duration: 1.1).repeatForever(autoreverses: true)) {
                    isPulsing = true
                }
            }
        }
    }
    
    private var notesList: some View {
        List {
            ForEach(viewModel.notes) { note in
                NoteRowView(note: note)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedNote = note
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 3, leading: 8, bottom: 3, trailing: 8))
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
    
    private var addFloatingButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    viewModel.isShowingAddNote = true
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.appAccent.opacity(isPulsing ? 0.25 : 0.12))
                            .frame(width: isPulsing ? 82 : 66, height: isPulsing ? 82 : 66)
                        Circle()
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
                            .frame(width: 66, height: 66)
                            .shadow(color: Color.appAccent.opacity(0.4), radius: 12, x: 0, y: 6)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                .scaleEffect(isPulsing ? 1.06 : 1)
                .padding(.trailing, 20)
                .padding(.bottom, 24)
            }
        }
    }
    
    private var emptyStateView: some View {
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
    }
}

#Preview {
    NotesListScreen()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
