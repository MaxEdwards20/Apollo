//
//  ExerciseDetailScreen.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import SwiftUI

struct ExerciseDetailScreen: View {
    let exercise: Exercise
    @State private var name:String = ""
    @State private var maxWeight:Int = 0
    @State private var selectedOption: Exercise.ExerciseGroup = Exercise.ExerciseGroup.abs
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Max Weight", value: $maxWeight, format: .number)
            ExerciseGroupPicker(selectedOption: $selectedOption)
        }.toolbar(){
            ToolbarItem(){
                Button("Update"){
                    exercise.name = name
                    exercise.maxWeight = maxWeight
                    exercise.group = selectedOption
                    dismiss()
                }
            }
        }
        .onAppear {
            name = exercise.name
            maxWeight = exercise.maxWeight
        }
    }
}

#Preview {
    ExerciseDetailScreen(exercise: SampleExercises.contents[0]).modelContainer(for: [Exercise.self, WorkoutSet.self])
}
