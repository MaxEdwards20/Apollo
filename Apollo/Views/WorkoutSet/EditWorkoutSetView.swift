//
//  WorkoutSetDetail.swift
//  Apollo
//
//  Created by Max Edwards on 12/5/23.
//

import SwiftUI
import SwiftData

struct EditWorkoutSetView: View {
    var workoutSet: WorkoutSet
    @State var weight: Int = 0
    @State var reps: Int = 0
    @State var timestamp: Date = Date.now
    @State var notes: String = ""
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    private func loadValues(){
        weight = workoutSet.weight
        reps = workoutSet.reps
        timestamp = workoutSet.timestamp
        notes = (workoutSet.notes != nil) ?  workoutSet.notes! : notes
    }
    
    var body: some View {
        Form {
            Text(workoutSet.exercise != nil ? workoutSet.exercise!.name : "Set")
            HStack {
                TextField("Weight: ", value: $weight, format: .number)
            }
        }.onAppear {
            loadValues()
        }
    }
}

private struct PreviewEditWorkoutSet: View {
    @Query private var sets: [WorkoutSet] // one source of truth
    var body: some View {
        NavigationStack {
            EditWorkoutSetView(workoutSet: sets[0])
        }
    }
}



#Preview {
    PreviewEditWorkoutSet()
        .modelContainer(previewContainer)
}
