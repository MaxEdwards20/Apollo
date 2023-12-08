//
//  AddWorkoutSetView.swift
//  Apollo
//
//  Created by Max Edwards on 11/3/23.
//

import SwiftUI
import SwiftData

struct AddWorkoutSetView: View {
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
    
    var body: some View{
        NavigationStack {
            VStack {
                Text("Apollo Strong").font(.largeTitle)
                List{
                    // Weight
                    Section {
                        HStack {
                            Text("Weight: ")
                                .padding(.trailing, 20)
                            
                            TextField("", value: $weight, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                        HStack {
                            Toggle("Barbell", isOn: $addBarbell).onChange(of: addBarbell){calculateFinalWeight()}
                        }
                        HStack {
                            Text("45 lbs: ")
                                .padding(.trailing, 20)
                            TextField("", value: $fortyFive, formatter:NumberFormatter()).keyboardType(.numberPad)
                            Stepper("", value: $fortyFive, in:0...30)
                        }.onChange(of: fortyFive){calculateFinalWeight()}
                        HStack {
                            Text("25 lbs: ")
                                .padding(.trailing, 20)
                            TextField("", value: $twentyFive, formatter:NumberFormatter()).keyboardType(.numberPad)
                            Stepper("", value: $twentyFive, in:0...30)
                        }.onChange(of: twentyFive){calculateFinalWeight()}
                        HStack {
                            Text("10 lbs: ")
                                .padding(.trailing, 20)
                            TextField("", value: $ten, formatter:NumberFormatter()).keyboardType(.numberPad)
                            Stepper("", value: $ten    , in:0...30)
                        }.onChange(of: ten){calculateFinalWeight()}
                        HStack {
                            Text("5 lbs: ")
                                .padding(.trailing, 20)
                            TextField("", value: $five, formatter:NumberFormatter()).keyboardType(.numberPad)
                            Stepper("", value: $five, in:0...30)
                        }.onChange(of: five){calculateFinalWeight()}
     
                        Button("Reset") {
                            withAnimation{
                                resetWeights()
                            }
                        }
                    }
                    // Reps
                    Section {
                        HStack {
                            Text("Repetitions: ")
                            Stepper("\(numberReps)", value: $numberReps, in:1...50)
                        }
                    }
                    Button("Save"){
                        withAnimation{
                            let workoutSet = WorkoutSet(weight: weight, reps: numberReps) // Create it in context
                            exercise.history?.append(workoutSet)
                            isShowingAddSets = false // close the window
                        }
                    }
                }
            }.toolbar{
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
        AddWorkoutSetView(exercise: exercises[0], isShowingAddSets: .constant(true))
    }
}

#Preview { @MainActor in
    PreviewAddWorkoutSetView()
        .modelContainer(previewContainer)
}

