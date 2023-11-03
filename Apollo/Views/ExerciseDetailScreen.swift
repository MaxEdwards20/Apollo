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
    @State private var isShowingAddSets = false
    @State private var name:String = ""
    @State private var maxWeight:Int = 0
    @State private var selectedOption: Exercise.ExerciseGroup = Exercise.ExerciseGroup.abs
    // TODO: Add view differences. If we have history, then set all of the values to their approrpiate maxes. If not, use the default values

    var body: some View {
        VStack {
            Text(exercise.name).font(.title)
            Form {
                TextField("Name", text: $name)
                TextField("Max Weight", value: $maxWeight, format: .number)
                ExerciseGroupPicker(selectedOption: $selectedOption)
            }.onAppear{
                selectedOption = exercise.group
            }
            .toolbar(){
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
            Spacer()
            Button("Add a Set"){
                isShowingAddSets = true
            }.popover(isPresented: $isShowingAddSets, content: {
                AddWorkoutSetView(exercise: exercise, isShowingAddSets: $isShowingAddSets)
                    .padding()
            })
            WorkoutHistoryView(exercise: exercise)
        }
    }
}

#Preview {

    return ExerciseDetailScreen(exercise: SampleExercises.contents[0])
        .modelContainer(previewContainer)
}
