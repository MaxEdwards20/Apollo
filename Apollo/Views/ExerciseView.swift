//
//  ExerciseView.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import SwiftUI
import SwiftData

struct ExerciseView: View {
    var exercises: [Exercise] // passed from the query in content view
    @Environment(\.modelContext) private var context
    
    var groupedExercises: [Exercise.ExerciseGroup: [Exercise]] {
        Dictionary(grouping: exercises, by: {$0.group})
    }
    
    // Create groups based on each type
    var body: some View {
        List {
            ForEach(groupedExercises.keys.sorted{$0.name < $1.name}, id: \.self) { group in
                Section(header: Text(group.name)) {
                    ForEach(groupedExercises[group]!, id: \.id) { exercise in
                        NavigationLink(destination: ExerciseDetailScreen(exercise: exercise)) {
                            ExerciseCellView(exercise: exercise)
                        }
                    }
                }
            }
        }
    }
    
//    var body: some View {
//        List {
//            ForEach(exercises) { exercise in
//                NavigationLink(value: exercise){
//                    ExerciseCellView(exercise: exercise)
//                }
//            }.onDelete(perform: deleteExercise)
//        }.navigationDestination(for: Exercise.self) { exercise in
//            ExerciseDetailScreen(exercise: exercise )
//        }
//    }
}


private struct PreviewExerciseView: View {
    @Query private var exercises: [Exercise]
    var body: some View {
        ExerciseView(exercises: exercises)
    }
}

#Preview {
    PreviewExerciseView()
        .modelContainer(previewContainer)
}
