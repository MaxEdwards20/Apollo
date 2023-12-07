//
//  WorkoutSetDetail.swift
//  Apollo
//
//  Created by Max Edwards on 12/5/23.
//

import SwiftUI
import SwiftData

struct WorkoutSetDetailView: View {
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


#Preview {
    WorkoutSetDetailView(workoutSet: WorkoutSet(weight: 20, reps: 10, timestamp: Date.now))
        .modelContainer(previewContainer)
}
