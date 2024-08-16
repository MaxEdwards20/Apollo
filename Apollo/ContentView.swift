//
//  ContentView.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isPresented: Bool = false
    @Query private var exercises: [Exercise] // one source of truth
    @Environment(\.modelContext) private var context
    private func generateData(){
        let content = SampleData().contents
        for i in content {
            context.insert(i)
        }
        content.forEach {e in
            SampleData.generateSets(exercise: e)
        }
    }
    
//    private func handleSave(){
//        withAnimation{
//            let workoutSet = WorkoutSet(weight: weight, reps: numberReps) // Create it in context
//            exercise.history?.append(workoutSet)
//            isShowingAddSets = false // close the window
//        }
//    }
    
    var body: some View {
        NavigationStack{
            VStack {
                ExerciseList(exercises: exercises)
                    .navigationTitle("Your Exercises")
            }
            .sheet(isPresented: $isPresented, content: {
                AddExerciseView()
            })
            Button(action: {
                isPresented = true
            }) {
                Text("Add Exercise")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue)) // Adjust color as needed
                    .foregroundColor(.white)
            }.padding()
        }
           
                // Used for testing purposes. This generates demo data and also deletes it
//                ToolbarItem(placement: .topBarLeading){
//                    Button {
//                        generateData()
//                    } label : {
//                        Text("GenData")
//                    }
//                }
//                ToolbarItem(placement: .topBarLeading){
//                    Button {
//                        for i in exercises {
//                            if i.name.lowercased().contains("test"){
//                                context.delete(i)
//                            }
//                        }
//                    } label : {
//                        Text("DelData")
//                    }
//                }
        }
    }

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
