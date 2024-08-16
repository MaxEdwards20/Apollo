//
//  AddExerciseView.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import SwiftUI
import SwiftData

// TODO: Add some error handling and update models to only accept 1 exercise of the same name

struct AddExerciseView: View {
    // Initialize the state variables
    @State private var name = ""
    @State private var maxWeight:Int = 0
    @State private var group:Exercise.ExerciseGroup = Exercise.ExerciseGroup.abs
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    private func handleSave(){
        let exercise = Exercise(name: name,  group: group)
        context.insert(exercise) // saves the item
        dismiss()
    }
    
    
    var body: some View {
        NavigationStack{
            Form {
                HStack{
                    Text("Exercise: ")
                    TextField("Name", text: $name)
                }
                ExerciseGroupPicker(selectedOption: $group)
            }
            Button(action: {
                handleSave()
            }) {
                Text("Save")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue)) // Adjust color as needed
                    .foregroundColor(.white)
                    
            }.padding()
            .disabled(name.isEmpty)
            
            .navigationTitle("Add Exercise")

            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button("Close"){
                        dismiss()
                    }
                }
            }
            
        }
        
    }
}


#Preview {
    AddExerciseView()
        .modelContainer(previewContainer)
}
