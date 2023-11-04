//
//  ExerciseDetailScreen.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import SwiftUI
import SwiftData

struct ExerciseDetailScreen: View {
    var exercise: Exercise
    @Environment(\.dismiss) private var dismiss
    @State var maxWeight = 0;
    // TODO: Add view differences. If we have history, then set all of the values to their approrpiate maxes. If not, use the default values
    // TODO: Add a timer 
    var body: some View {
        VStack {
            Text(exercise.name).font(.title)
            Text("Personal Record: \(exercise.maxWeight)")
            Text("Body Group: \(exercise.group.name)")
        }
        Divider()
        WorkoutHistoryView(exercise: exercise)
    }
}



// Create a screen preview
private struct PreviewExerciseDetailScreen: View {
    @Query private var exercises: [Exercise] // one source of truth
    var body: some View {
        ExerciseDetailScreen(exercise: exercises[0])
    }
}

#Preview {
    return PreviewExerciseDetailScreen()
        .modelContainer(previewContainer)
}
