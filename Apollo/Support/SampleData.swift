//
//  SampleExercises.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import Foundation

// Information on deletions
//https://stackoverflow.com/questions/77382754/swiftdata-persistentmodel-swift540-fatal-error-unsupported-relationship-key-p

final class SampleData {
     var contents: [Exercise] {
        generateData()
    }
    
    private func generateData() -> [Exercise] {
        let bench  = Exercise(name: "Test Bench Press", group: Exercise.ExerciseGroup.chest)
        let squat = Exercise(name: "Test Squat", group: Exercise.ExerciseGroup.legs)
        let deadlift = Exercise(name: "Test Deadlift", group: Exercise.ExerciseGroup.back)
        let curl = Exercise(name: "Test Barbell Curl", group: Exercise.ExerciseGroup.arms)
        let pullup = Exercise(name: "Test Pullup", group: Exercise.ExerciseGroup.back)
        let run = Exercise(name: "Test Run", group: Exercise.ExerciseGroup.cardio)
        return [bench, squat, deadlift, curl, pullup, run]
    }
    
    static func generateSet(exercise: Exercise) -> WorkoutSet {
        return WorkoutSet(weight: Int.random(in: 50...300), reps: Int.random(in: 1...30), exercise: exercise)
    }
}
