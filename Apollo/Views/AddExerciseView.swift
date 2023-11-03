//
//  AddExerciseView.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import SwiftUI
import SwiftData

struct AddExerciseView: View {
    
    @State private var name = ""
    @State private var maxWeight:Int = 0
    @State private var group:Exercise.ExerciseGroup = Exercise.ExerciseGroup.abs
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack{
            Form {
                HStack{
                    Text("Exercise: ")
                    TextField("Name", text: $name)
                }
//                HStack{
//                    Text("Personal Record: ")
//                    TextField("Max Weight", value: $maxWeight, format: .number)
//                }
                ExerciseGroupPicker(selectedOption: $group)
            }
            
            .navigationTitle("Add Exercise")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button("Save") {
                        let exercise = Exercise(name: name, maxWeight: maxWeight, group: group)
                        context.insert(exercise) // saves the item
                        dismiss()
                    }.disabled(name.isEmpty)
                }
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
