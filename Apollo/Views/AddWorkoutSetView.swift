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
        weight = addBarbell ? calcWeight + 45 : calcWeight
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
        VStack {
            Text("Apollo Strong").font(.largeTitle)
            Image(systemName: "sun.dust")
            List{
                // Weight
                Section {
                    Text("Weight: \(Int(weight))")
                    HStack {
                        Toggle("Barbell", isOn: $addBarbell).onChange(of: addBarbell){calculateFinalWeight()}
                    }
                    HStack {
                        Text("45 lbs: ")
                        Stepper("\(fortyFive)", value: $fortyFive, in:0...30)
                    }.onChange(of: fortyFive){calculateFinalWeight()}
                    HStack {
                        Text("25 lbs: ")
                        Stepper("\(twentyFive)", value: $twentyFive, in:0...30)
                    }.onChange(of: twentyFive){calculateFinalWeight()}
                    HStack {
                        Text("10 lbs: ")
                        Stepper("\(ten)", value: $ten    , in:0...30)
                    }.onChange(of: ten){calculateFinalWeight()}
                    HStack {
                        Text("5 lbs: ")
                        Stepper("\(five)", value: $five, in:0...30)
                    }.onChange(of: five){calculateFinalWeight()}
                    HStack {
                        Text("Adjust by 1 lb ")
                        Stepper("", value: $weight, in:0...1000)
                    }
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
                    // Test to see whether this is working
                    let workoutSet = WorkoutSet(weight: weight, reps: numberReps, exercise: exercise)
                    exercise.history.append(workoutSet)
                    isShowingAddSets = false // close the window
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

#Preview {
    PreviewAddWorkoutSetView()
        .modelContainer(previewContainer)
}

