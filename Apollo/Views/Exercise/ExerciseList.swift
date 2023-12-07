//
//  ExerciseView.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import SwiftUI
import SwiftData

struct ExerciseList: View {
    var exercises: [Exercise]
    // Create groups based on each type
    var body: some View {
            List {
                ForEach(Exercise.ExerciseGroup.allCases.sorted(by: {$0.name < $1.name})) { group in
                    let groupExercises = exercises.filter({$0.group == group})
                    if !groupExercises.isEmpty{
                        Section(header: Text(group.name)) {
                            ForEach(exercises.filter { $0.group == group }) { exercise in
                                NavigationLink(destination: ExerciseDetailScreen(exercise: exercise)) {
                                    ExerciseRowView(exercise: exercise)
                                }
                            }
                        }
                    }
                }
            }
    }
}


private struct PreviewExerciseView: View {
    @Query private var exercises: [Exercise]
    var body: some View {
        ExerciseList(exercises: exercises)
    }
}

#Preview {
    PreviewExerciseView()
        .modelContainer(previewContainer)
}
