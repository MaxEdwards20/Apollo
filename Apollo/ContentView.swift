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
        for i in content {
            _ = SampleData.generateSet(exercise: i)
            _ = SampleData.generateSet(exercise: i)
            _ = SampleData.generateSet(exercise: i)
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                ExerciseView(exercises: exercises)
                    .navigationTitle("Your Exercises")
            }
            .sheet(isPresented: $isPresented, content: {
                AddExerciseView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        isPresented = true
                    } label : {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        generateData()
                    } label : {
                        Text("Dummy Batch")
                    }
                }
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        for i in exercises {
                            context.delete(i)
                        }
                    } label : {
                        Text("Clear Data")
                    }
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
