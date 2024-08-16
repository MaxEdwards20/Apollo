//
//  AddWorkoutSetView.swift
//  Apollo
//
//  Created by Max Edwards on 11/3/23.
//

import SwiftUI
import SwiftData

struct AddSetView: View {
    @Query var allSets: [WorkoutSet]
    var exercise: Exercise
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var numberReps:Int = 1
    @State private var fortyFive:Int = 0
    @State private var twentyFive:Int = 0
    @State private var ten:Int = 0
    @State private var five:Int = 0
    @State private var weight:Int = 0
    @State private var addBarbell:Bool = false
    @State private var MAX_WEIGHT = 10000
    @State private var isTime = false
    @State private var duration:TimeInterval = 0
    @Binding var isShowingAddSets:Bool
    
    private func calculateFinalWeight(){
        let calcWeight = ((fortyFive * 45) + (twentyFive * 25) + (ten  * 10) + (five * 5))
        weight = addBarbell ? calcWeight * 2 + 45 + weight % 5 : calcWeight + weight % 5
    }
    
    private func resetWeights(){
        weight = 0
        fortyFive = 0
        twentyFive   = 0
        ten = 0
        five = 0
        addBarbell = false
    }
    
    private func handleSave(){
        withAnimation{
            let workoutSet = WorkoutSet(weight: weight, reps: numberReps) // Create it in context
            exercise.history?.append(workoutSet)
            isShowingAddSets = false // close the window
        }
    }
    
    
    var body: some View{
        NavigationStack {
            List{
                Section {
                    HStack {
                        Text("Weight: ")
                            .padding(.trailing, 20)
                        
                        TextField("", value: $weight, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Toggle("Barbell", isOn: $addBarbell)
                            .onChange(of: addBarbell){calculateFinalWeight()}
                    }
                    if (addBarbell){
                        HStack {
                            Text("45 lbs: ")
                                .padding(.trailing, 20)
                            TextField("", value: $fortyFive, formatter:NumberFormatter()).keyboardType(.numberPad)
                            Stepper("", value: $fortyFive, in:0...MAX_WEIGHT/45)
                        }.onChange(of: fortyFive){calculateFinalWeight()}
                        HStack {
                            Text("25 lbs: ")
                                .padding(.trailing, 20)
                            TextField("", value: $twentyFive, formatter:NumberFormatter()).keyboardType(.numberPad)
                            Stepper("", value: $twentyFive, in:0...MAX_WEIGHT/25)
                        }.onChange(of: twentyFive){calculateFinalWeight()}
                        HStack {
                            Text("10 lbs: ")
                                .padding(.trailing, 20)
                            TextField("", value: $ten, formatter:NumberFormatter()).keyboardType(.numberPad)
                            Stepper("", value: $ten    , in:0...MAX_WEIGHT/10)
                        }.onChange(of: ten){calculateFinalWeight()}
                        HStack {
                            Text("5 lbs: ")
                                .padding(.trailing, 20)
                            TextField("", value: $five, formatter:NumberFormatter()).keyboardType(.numberPad)
                            Stepper("", value: $five, in:0...MAX_WEIGHT/5)
                        }.onChange(of: five){calculateFinalWeight()}
                    }
                    
                    if (weight > 0){
                        Button("Reset Weight") {
                            withAnimation{
                                resetWeights()
                            }
                        }
                    }
                }
                Section {
                    HStack {
                        Text("Reps: ").padding(.trailing, 10)
                        TextField("", value: $numberReps, formatter: NumberFormatter()).keyboardType(.numberPad)
                        Stepper("", value: $numberReps, in:1...1000, step: 1)
                    }
                }
                // TODO: Add a "Previous Set" Here
                // Potentially also add a "recommended reps/weight combination for the user
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
            
                .navigationTitle("Add a Set")
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Button("Close"){
                            dismiss()
                        }
                    }
                }
        }
    }
}


private struct PreviewAddWorkoutSetView: View {
    @Query private var exercises: [Exercise] // one source of truth
    var body: some View {
        NavigationStack{
            AddSetView(exercise: exercises[0], isShowingAddSets: .constant(true))
        }
    }
}

#Preview {
    PreviewAddWorkoutSetView()
        .modelContainer(previewContainer)
}

