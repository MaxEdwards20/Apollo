//
//  AddWorkoutSetView.swift
//  Apollo
//
//  Created by Max Edwards on 11/3/23.
//

import SwiftUI

struct AddWorkoutSetView: View {
    var exercise: Exercise
    @State private var weight:Float = 0
    @State private var numberReps:Int = 0
    @Binding var isShowingAddSets:Bool
    
    var body: some View{
        List{
            TextField("Number of Reps ", value: $numberReps, format: .number)
            TextField("Weight ", value: $weight, format: .number)
        }
        Button("Save"){
            let workoutSet = WorkoutSet(weight: weight, reps: numberReps)
            exercise.history.append(workoutSet)
            isShowingAddSets = false // close the window
        }
    }
}

//#Preview {
//    AddWorkoutSetView(exercise: .constant(SampleExercises.contents[0]), isShowingAddSets: .constant(true))
//        .modelContainer(previewContainer)
//}
