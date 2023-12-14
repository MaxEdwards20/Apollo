//
//  WorkoutHistoryView.swift
//  Apollo
//
//  Created by Max Edwards on 11/3/23.
//

import SwiftUI
import SwiftData

// TODO: Add a graph that shows max weights over time
// TODO: Add a graph that shows total weight over time

struct SetHistoryView: View {
    var exercise: Exercise
    @Environment(\.modelContext) private var context
    @State private var isShowingAddSets = false
    var body: some View {
        VStack{
            Text("History")
                .font(.title3)
            CategorizedSetsView(exercise: exercise)
        }
    }
}

private struct PreviewWorkoutHistoryView: View {
    @Query private var exercises: [Exercise] // one source of truth
    var body: some View {
        SetHistoryView(exercise: exercises[0])
    }
}

#Preview {
    PreviewWorkoutHistoryView()
        .modelContainer(previewContainer)
}


