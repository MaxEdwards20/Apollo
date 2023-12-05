//
//  WorkoutHistoryRowView.swift
//  Apollo
//
//  Created by Max Edwards on 11/4/23.
//

import SwiftUI

struct WorkoutSetRowView: View {
    @Environment(\.modelContext) private var context
    var exercise: Exercise
    var workoutSet: WorkoutSet
    private func duplicateSet(workoutSet: WorkoutSet){
        withAnimation{
            let duplicateSet = WorkoutSet(weight: workoutSet.weight, reps: workoutSet.reps, exercise: exercise)
            exercise.history.append(duplicateSet) // duplicate the given item
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Date \(workoutSet.timestamp.formatted(date: .numeric, time: .omitted))")
            Text("\(Int(workoutSet.weight)) x \(Int(workoutSet.reps))")
        }.swipeActions(edge: .leading){
            Button {
                duplicateSet(workoutSet: workoutSet)
            } label: {
                Label("Duplicate", systemImage: "plus.circle")
            }
        }.swipeActions(edge: .trailing){
            Button(role: .destructive) {
                context.delete(workoutSet)
                workoutSet.exercise!.history.removeAll(where: {$0.id == workoutSet.id})
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

//#Preview {
//    WorkoutHistoryRowView()
//}
