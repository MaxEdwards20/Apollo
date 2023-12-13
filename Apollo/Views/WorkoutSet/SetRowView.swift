//
//  WorkoutHistoryRowView.swift
//  Apollo
//
//  Created by Max Edwards on 11/4/23.
//

import SwiftUI

struct SetRowView: View {
    @Environment(\.modelContext) private var context
    var exercise: Exercise
    var workoutSet: WorkoutSet
    
    private func duplicateSet(workoutSet: WorkoutSet){
        withAnimation{
            let duplicateSet = WorkoutSet(weight: workoutSet.weight, reps: workoutSet.reps)
            duplicateSet.exercise = exercise
//            exercise.history?.append(duplicateSet)
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
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}



//#Preview {
//    WorkoutHistoryRowView()
//}
