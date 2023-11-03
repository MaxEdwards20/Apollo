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
            }
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
