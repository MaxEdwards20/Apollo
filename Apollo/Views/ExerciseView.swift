//
//  ExerciseView.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import SwiftUI
import SwiftData

struct ExerciseView: View {
    var exercises: [Exercise] // pased from the query in content view
    @Environment(\.modelContext) private var context
    
    private func deleteExercise(indexSet: IndexSet){
        indexSet.forEach{index in
            let exercise = exercises[index]
            context.delete(exercise)
        }
    }
    // TODO: Add Most recent set to the exercise view
    
    var body: some View {
        List {
            ForEach(exercises, id: \.id) { exercise in
                NavigationLink(value: exercise){
                    HStack{
                        // Seems to be limit on only have 2 text fields
                        VStack(alignment: .leading){
                            Text(exercise.name)
                                .font(.title2)
                            Text("\(exercise.group.name)")
                                .font(.title3)
                        }
                    }
                }
            }.onDelete(perform: deleteExercise)
        }.navigationDestination(for: Exercise.self) { exercise in
            ExerciseDetailScreen(exercise: exercise )
        }
    }
}

// Not sure how to get this preview to work
#Preview {
    ExerciseView(exercises: SampleExercises.contents)
        .modelContainer(previewContainer)
}
