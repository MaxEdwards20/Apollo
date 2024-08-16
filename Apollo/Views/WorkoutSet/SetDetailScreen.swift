//
//  WorkoutSetDetail.swift
//  Apollo
//
//  Created by Max Edwards on 12/5/23.
//

import SwiftUI
import SwiftData

// TODO: Add Apollo logo as background for blank screens or empty space

struct SetDetailScreen: View {
    var workoutSet: WorkoutSet
    
    //    https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield
    enum Field {
        case weight
        case reps
        case date
        case notes
    }
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State var weight: Int = 0
    @State var reps: Int = 0
    @State var timestamp: Date = Date.now
    @State var notes: String?
    @State private var isEditing = false
    
    //TODO: Add cards for each part of set to display them prettier with pictures and coloration
    
    private func loadValues(){
        weight = workoutSet.weight
        reps = workoutSet.reps
        timestamp = workoutSet.timestamp
        print("Timestamp is: ", timestamp)
        notes = workoutSet.notes
        print("Notes are: ", notes ?? "None")
    }
    
    private func toggleIsEditing(){
        withAnimation{
            loadValues()
            isEditing = !isEditing
        }
    }
    
    private func saveChanges(){
        // Validate the changes
        if weight < 0 {weight = 0}
        if reps < 0 {reps = 0}
        // Update the system
        workoutSet.weight = weight
        workoutSet.reps = reps
        workoutSet.timestamp = timestamp
        workoutSet.notes = notes
    }
    
    var body: some View {
        VStack{
            VStack {
                HStack {
                    Text("Weight: ")
                        .padding(.trailing, 10)
                    TextField( "",  value: $weight, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .disabled(!isEditing)
                    if (isEditing){
                        Stepper("", value: $weight, in: 0...2000, step: 1).disabled(!isEditing)
                    }
                }
                HStack {
                    Text("Reps:     ")
                        .padding(.trailing, 10)
                    TextField("", value: $reps, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .disabled(!isEditing)
                    if (isEditing){
                        Stepper("", value: $reps, step: 1).disabled(!isEditing)
                    }
                }
                HStack {
                    Text("Date: ")
                    DatePicker("", selection: $timestamp, in: ...Date())
                        .disabled(!isEditing)
                }
                if (notes != nil && !notes!.isEmpty){
                    HStack {
                        Text("Notes: ")
                            .padding(.trailing, 10)
                        TextField("This felt heavy ...", value: $notes, formatter: DateFormatter())
                            .disabled(!isEditing)
                    }
                }
                Spacer()
            }.padding()
                .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(radius: 5)
            )
            
            if (isEditing){
                Button(action: {
                    saveChanges()
                    toggleIsEditing()
                    //                    dismiss()
                }){
                    Text("Save Changes")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            else {
                Button(action: {
                    toggleIsEditing()
                }) {
                    Text("Edit")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue)) // Adjust color as needed
                        .foregroundColor(.white)
                }.padding()
            }
        }.padding()
            .onAppear {
                loadValues()
            }
            .navigationTitle(isEditing ? "Edit Set Details" : "Set Details")
            .toolbar{
                if isEditing {
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Cancel"){
                            toggleIsEditing()
                        }
                    }
                }
            }
    }
}

private struct PreviewEditWorkoutSet: View {
    @Query private var sets: [WorkoutSet]
    var body: some View {
        NavigationStack {
            SetDetailScreen(workoutSet: sets[0])
        }
    }
}

#Preview {
    PreviewEditWorkoutSet()
        .modelContainer(previewContainer)
}
