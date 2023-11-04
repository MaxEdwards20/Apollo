//
//  WorkoutHistoryView.swift
//  Apollo
//
//  Created by Max Edwards on 11/3/23.
//

import SwiftUI
import SwiftData

// TODO: Make history items clickable to edit them
// TODO: Group History By day, week, month, and year
// TODO: Add a graph that shows max weights over time
// TODO: Add a graph that shows total weight over time

struct WorkoutHistoryView: View {
    var exercise: Exercise
    @Environment(\.modelContext) private var context// We need this to be able to delete items
    @State private var isShowingAddSets = false
    
    private func deleteSet(indexSet: IndexSet){
        // TODO: Create a live update on exerciseDetail when I delete a set here, in the history view
        withAnimation {
            indexSet.map {exercise.history[$0]}.forEach {
                context.delete($0)
            }
        }
    }
    
    private func duplicateSet(workoutSet: WorkoutSet){
        withAnimation{
            let duplicateSet = WorkoutSet(weight: workoutSet.weight, reps: workoutSet.reps, exercise: exercise)
            exercise.history.append(duplicateSet) // duplicate the given item
        }
    }
    
    var body: some View {
        VStack{
            Text("History")
                .font(.title3)
            Button("Add a Set"){
                isShowingAddSets = true
            }.font(.title2)
                .popover(isPresented: $isShowingAddSets, content: {
                    AddWorkoutSetView(exercise: exercise, isShowingAddSets: $isShowingAddSets)
                        .padding()
                })
            List {
                // Sort the list by the time stamps
                ForEach(exercise.history.sorted(by: {$0.timestamp < $1.timestamp}).reversed()) { workoutSet in
                    VStack(alignment: .leading){
                        Text("Date \(workoutSet.timestamp.formatted(date: .numeric, time: .omitted))")
                        Text("Reps: \(workoutSet.reps)")
                        Text("Weight: \(Int(workoutSet.weight))")
                    }.swipeActions(edge: .leading){
                        Button {
                            duplicateSet(workoutSet: workoutSet)
                        } label: {
                            Label("Duplicate", systemImage: "plus.circle")
                        }
                    }.swipeActions(edge: .trailing){
                        Button(role: .destructive) {
                            context.delete(workoutSet)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
    }
}

private struct PreviewWorkoutHistoryView: View {
    @Query private var exercises: [Exercise] // one source of truth
    var body: some View {
        WorkoutHistoryView(exercise: exercises[0])
    }
}

#Preview {
    PreviewWorkoutHistoryView()
        .modelContainer(previewContainer)
}
