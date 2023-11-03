//
//  WorkoutSet.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import Foundation
import SwiftData

@Model
final class WorkoutSet: Identifiable, CustomStringConvertible {
    var id: UUID
    var timestamp: Date
    var weight:Int
    var reps: Int
    var notes:String
    var totalWeight:Int
    var exercise: Exercise?
    
    init(weight: Int, reps: Int, notes: String = "", exercise: Exercise? = nil) {
        self.id = UUID()
        self.timestamp = Date.now
        self.weight = weight
        self.reps = reps
        self.notes = notes
        self.totalWeight = Int(weight) * reps
        self.exercise = exercise
    }
    
    // Problem is that when I delete one of these, it does not update for the exercise
    static func delete(_ workoutSet: WorkoutSet){
        if let context = workoutSet.modelContext {
            context.delete(workoutSet)
        }
    }
    
    var description: String {
        return "Weight: \(self.weight) Reps: \(self.reps) Exercise: \(String(describing: self.exercise?.name))"
    }
}

extension WorkoutSet : Comparable {
    public static func < (lhs: WorkoutSet, rhs: WorkoutSet) -> Bool {
        lhs.timestamp < rhs.timestamp
    }
}


