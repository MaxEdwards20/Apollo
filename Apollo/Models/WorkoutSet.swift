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
    var totalWeight:Int {
        weight * reps
    }
    var exercise: Exercise?
    
    init(weight: Int, reps: Int, notes: String = "", exercise: Exercise, timestamp:Date = Date.now) {
        self.id = UUID()
        self.timestamp = timestamp
        self.weight = weight
        self.reps = reps
        self.notes = notes
        self.exercise = exercise
    }
    
    var description: String {
        return "Weight: \(self.weight) Reps: \(self.reps) Exercise: \(String(describing: self.exercise!.name))"
    }
}

extension WorkoutSet : Comparable {
    public static func < (lhs: WorkoutSet, rhs: WorkoutSet) -> Bool {
        lhs.timestamp < rhs.timestamp
    }
}


