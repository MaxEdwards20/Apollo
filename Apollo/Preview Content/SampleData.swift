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
    
    static func generateSets(num: Int = 5, exercise: Exercise){
        for _ in 1...num {
            generateSet(exercise: exercise)
        }
    }
    
    static func generateSet(exercise: Exercise) {
        // Determine a random time interval within the last week, month, or year
        let currentDate = Date()
        let timeInterval: TimeInterval
        switch Int.random(in: 0...2) {
            case 0:
                // Within the last week (604800 seconds)
                timeInterval = TimeInterval.random(in: 0...604800)
            case 1:
                // Within the last month (2592000 seconds)
                timeInterval = TimeInterval.random(in: 604801...2592000)
            default:
                // Within the last year (31536000 seconds)
                timeInterval = TimeInterval.random(in: 2592001...31536000)
        }
        
        let lowerBound = currentDate.addingTimeInterval(-timeInterval)
        let randomTimestamp = Date(timeInterval: TimeInterval.random(in: lowerBound.timeIntervalSinceReferenceDate...currentDate.timeIntervalSinceReferenceDate), since: Date(timeIntervalSinceReferenceDate: 0))
        
        let s = WorkoutSet(weight: Int.random(in: 50...300), reps: Int.random(in: 1...30), timestamp: randomTimestamp)
        s.exercise = exercise
    }
}
