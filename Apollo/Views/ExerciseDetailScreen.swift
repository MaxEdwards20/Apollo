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
   
    
    var body: some View {
        VStack {
            Text(exercise.name).font(.title)
            Text("Personal Record: \(exercise.computeMaxWeight())")
            Text("Body Group: \(exercise.group.name)")
        }
        .onAppear {
            maxWeight = exercise.computeMaxWeight()
        }
        Divider()
        WorkoutHistoryView(exercise: exercise)
    }
    
}

#Preview {
    
    return ExerciseDetailScreen(exercise: SampleExercises.contents[0])
        .modelContainer(previewContainer)
}
