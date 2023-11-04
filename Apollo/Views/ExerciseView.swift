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
                        Spacer()
                        if exercise.history.count > 0 {
                            Text("Last Set: \(exercise.history.last!.weight) x \(exercise.history.last!.reps)")
                        } else {
                            Text("Get Started")
                        }
                    }
                }
            }.onDelete(perform: deleteExercise)
        }.listStyle(.insetGrouped)
            .navigationDestination(for: Exercise.self) { exercise in
            ExerciseDetailScreen(exercise: exercise )
        
        }
    }
}

// Create a screen preview
private struct PreviewExerciseView: View {
    @Query private var exercises: [Exercise] // one source of truth
    var body: some View {
        ExerciseView(exercises: exercises)
    }
}

#Preview {
    PreviewExerciseView()
        .modelContainer(previewContainer)
}
