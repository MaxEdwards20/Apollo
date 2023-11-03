//
//  ExerciseView.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import SwiftUI
import SwiftData

struct ExerciseView: View {
    @Query private var exercises: [Exercise]
    @Environment(\.modelContext) private var context
    
    
    //    public func addSet(set: WorkoutSet){
    //        // add item to history
    //        history.append(set)
    //        // update corresponding values to show a new PR
    //        if bestSet != nil{
    //            set.totalWeight > bestSet.totalWeight {
    //            bestSet = set
    //        }}
    //        if maxWeight < set.weight {
    //            maxWeight  = set.weight
    //        }
    //    }
    //
    //    // Updates the exercise values to include
    //    public func updateExerciseStats(){
    //        updateBestSet()
    //        updateMaxWeight()
    //    }
    //
    //
    //    private func updateMaxWeight(){
    //        var maxWeight: Float = 0
    //        if history.count > 0 {
    //            for workSet in self.history{
    //                if workSet.weight > maxWeight {
    //                    maxWeight = workSet.weight
    //                }
    //            }
    //        }
    //    }
    //
    //    private func updateBestSet(){
    //        if history.count > 0 {
    //            for s in self.history {
    //                if s.totalWeight > bestSet.totalWeight {
    //                    bestSet = s
    //                }
    //            }
    //        }
    //    }
    
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
                            Text("\(exercise.maxWeight) - \(exercise.group.name)")
                                .font(.caption)

                        }
                    }
                }
            }.onDelete(perform: deleteExercise)
        }.navigationDestination(for: Exercise.self) { exercise in
            ExerciseDetailScreen( exercise:exercise)
        }
    }
}

// Not sure how to get this preview to work
#Preview {
    ExerciseView()
        .modelContainer(previewContainer)
}
