//
//  ExerciseCellView.swift
//  Apollo
//
//  Created by Max Edwards on 11/4/23.
//

import SwiftUI
import SwiftData

struct ExerciseCellView: View {
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
                Text("\(exercise.group.name)")
                    .font(.title3)
            }
            Spacer()
            if exercise.history.count > 0 {
                Text("Last Set: \(exercise.history.last!.weight) x \(exercise.history.last!.reps)")
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
        ExerciseCellView(exercise: exercises[0])
    }
}

#Preview {
    PreviewExerciseCellView().modelContainer(previewContainer)
}
