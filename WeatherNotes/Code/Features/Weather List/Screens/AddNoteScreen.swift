//  Copyright (c) 2026

import SwiftUI

struct AddNoteScreen: View {
    
    @Environment(\.managedObjectContext) private var context
    @ObservedObject var viewModel: NotesListViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Enter note text", text: $viewModel.noteText, axis: .vertical)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .padding()
                    .frame(minHeight: 120, alignment: .topLeading)
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                
                Button {
                    viewModel.saveNote(context: context)
                } label: {
                    Text("Save")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }
                
                Spacer()
            }
            .padding(20)
            .navigationTitle("New Note")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
