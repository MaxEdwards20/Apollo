//
//  WorkoutSetDetail.swift
//  Apollo
//
//  Created by Max Edwards on 12/5/23.
//

import SwiftUI
import SwiftData

struct WorkoutSetDetail: View {
    var workoutSet: WorkoutSet
    @State var weight: Int = 0
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    var body: some View {
        Form {
            HStack {
                TextField("Weight: ", value: $weight, format: .number)
            }
        }
    }
}

// Create exercise preview
private struct PreviewExerciseDetail: View {
    @Query var exercises: [Exercise]
    // Get an exercise with history
    func getSet(exercises: [Exercise]) -> WorkoutSet {
        for e in exercises{
            if e.history.count > 0 {
                return e.history[0]
            }
        }
        return SampleData().contents[0].history[0]
    }
    
    var body: some View {
        WorkoutSetDetail(workoutSet: getSet(exercises: exercises))
    }
}

#Preview {
    return PreviewExerciseDetail()
        .modelContainer(previewContainer)
}
