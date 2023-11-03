//
//  WorkoutHistoryView.swift
//  Apollo
//
//  Created by Max Edwards on 11/3/23.
//

import SwiftUI
import SwiftData

struct WorkoutHistoryView: View {
    var exercise: Exercise // We need this to be able to delete items
    @Environment(\.modelContext) private var context
    private func deleteSet(indexSet: IndexSet){
        withAnimation {
            indexSet.map {exercise.history[$0]}.forEach {context.delete($0)}
        }
    }
    
    private func duplicateSet(workoutSet: WorkoutSet){
        withAnimation{
            let duplicateSet = WorkoutSet(weight: workoutSet.weight, reps: workoutSet.reps)
            exercise.history.append(duplicateSet) // duplicate the given item
        }
    }
    
    // TODO: Add a duplicate function to add another set of the same weights and reps
    // TODO: Make history items clickable to edit them
    // TODO: Group History By day, week, month, and year
    var body: some View {
        VStack{
            Text("\(exercise.name) History")
                .font(.title2)
            Spacer()
            List {
                ForEach(exercise.history, id: \.id) { workoutSet in
                    // Seems to be limit on only have 2 text fields
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
                    }
                }.onDelete(perform: deleteSet)
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
