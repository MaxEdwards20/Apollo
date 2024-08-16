//
//  ExerciseDetailScreen.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import SwiftUI
import SwiftData

struct ExerciseDetailScreen: View {
    var exercise: Exercise
    @Environment(\.dismiss) private var dismiss
    @State var maxWeight = 0;
    @Environment(\.modelContext) private var context// We need this to be able to delete items
    @State private var isShowingAddSets = false
    @State private var isShowingGraph = false
    // TODO: Add view differences. If we have history, then set all of the values to their appropriate maxes. If not, use the default values
    var body: some View {
        VStack {
            if  (exercise.history == nil) || (exercise.history!.isEmpty) {
                NoSetsView()
            } 
            else {
                VStack{
                    Text("Max Weight: \(exercise.getMaxWeight()) lbs ").font(.title3).padding(.top, -15)
//                    Toggle("Show Graph", isOn: $isShowingGraph).disabled(exercise.history!.count < 3)
                }
                if isShowingGraph {
                    Divider().padding(.bottom, 150)
                    VStack{

                    }.padding()
                } else {
                    Divider()
                    Text("History")
                        .font(.title3)
                    SetHistoryView(exercise: exercise)
                }
            }
            HStack {
                Button(action: {
                    isShowingAddSets = true
                }) {
                    Text("Add a Set")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue)) // Adjust color as needed
                        .foregroundColor(.white)
                }
            }
            .popover(isPresented: $isShowingAddSets, content: {
                AddSetView(exercise: exercise, isShowingAddSets: $isShowingAddSets)
                    .padding()
            })
            
        }
        .navigationTitle(exercise.name)
        .padding()
    }
}


// Create a screen preview
private struct PreviewExerciseDetailScreen: View {
    @Query private var exercises: [Exercise] // one source of truth
    var body: some View {
        NavigationStack{
            ExerciseDetailScreen(exercise: exercises[0])
        }
    }
}

#Preview {
    return PreviewExerciseDetailScreen()
        .modelContainer(previewContainer)
}
