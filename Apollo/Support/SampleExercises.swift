//
//  SampleExercises.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import Foundation

final class SampleExercises {
     var contents: [Exercise] {
        generateData()
    }
    
    private func generateData() -> [Exercise] {
        // create a bench
        let bench  = Exercise(name: "Bench Press", group: Exercise.ExerciseGroup.chest)
        bench.history.append(WorkoutSet(weight: 10, reps: 10, notes: "Hard on chest", exercise: bench))
        bench.history.append(WorkoutSet(weight: 225, reps: 1,  exercise: bench))
        bench.history.append(WorkoutSet(weight: 255, reps: 1, exercise: bench))
        bench.history.append(WorkoutSet(weight: 90, reps: 15, exercise: bench))
        // Add to data
        
        let squat = Exercise(name: "Squat", group: Exercise.ExerciseGroup.legs)
        generateWorkoutHistory(exercise: squat)
        
        let deadlift = Exercise(name: "Deadlift", group: Exercise.ExerciseGroup.back)
        generateWorkoutHistory(exercise: deadlift)
        
        let curl = Exercise(name: "Barbell Curl", group: Exercise.ExerciseGroup.arms)
        generateWorkoutHistory(exercise: curl)
    
        let pullup = Exercise(name: "Pullup", group: Exercise.ExerciseGroup.back)
        
        return [bench, squat, deadlift, curl, pullup]
    }
    
    private func generateWorkoutHistory(exercise: Exercise) {
        for _ in 1...5 {
            exercise.history.append(generateSet(exercise: exercise))
        }
    }
    
    private func generateSet(exercise: Exercise) -> WorkoutSet {
        return WorkoutSet(weight: Int.random(in: 50...300), reps: Int.random(in: 1...30))
    }
}
