//
//  SampleExercises.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import Foundation

struct SampleExercises {
    static var contents: [Exercise] = [
        Exercise(name: "Bench Press", maxWeight: 225, group: Exercise.ExerciseGroup.chest),
        Exercise(name: "Squat", group: Exercise.ExerciseGroup.legs),
        Exercise(name: "Deadlift", group: Exercise.ExerciseGroup.back),
        Exercise(name: "Barbell Curl", maxWeight: 35, group: Exercise.ExerciseGroup.arms)
    ]
}
