//
//  ExerciseCellView.swift
//  Apollo
//
//  Created by Max Edwards on 11/4/23.
//

import SwiftUI
import SwiftData

struct ExerciseRowView: View {
    var exercise: Exercise
    @Environment(\.modelContext) private var context
    
    
    private func deleteExercise(e: Exercise){
        context.delete(e)
    }
    var body: some View {
        HStack{
            // Seems to be limit on only have 2 text fields
            VStack(alignment: .leading){
                Text(exercise.name)
                    .font(.title2)
            }
            Spacer()
            if exercise.getMostRecentSet() != nil {
                Text("Last Set: \(exercise.getMostRecentSet()!.weight) x \(exercise.getMostRecentSet()!.reps)").onAppear()
            } else {
                Text("Get Started")
            }
        }.swipeActions(edge: .trailing){
            Button(role: .destructive) {
                context.delete(exercise)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

private struct PreviewExerciseCellView: View {
    @Query private var exercises:[Exercise]
    var body: some View {
        ExerciseRowView(exercise: exercises[0])
    }
}

#Preview {
    PreviewExerciseCellView().modelContainer(previewContainer)
}
