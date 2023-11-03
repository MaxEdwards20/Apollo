//
//  WorkoutSet.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import Foundation
import SwiftData

@Model
final class WorkoutSet: Identifiable {
    var id: UUID
    var timestamp: Date
    var weight:Float
    var reps: Int
    var notes:String
    var totalWeight:Int
    var exercise: Exercise?
    
    init(weight: Float, reps: Int, notes: String = "") {
        self.id = UUID()
        self.timestamp = Date.now
        self.weight = weight
        self.reps = reps
        self.notes = notes
        self.totalWeight = Int(weight) * reps
    }
    
    static func delete(_ workoutSet: WorkoutSet){
        if let context = workoutSet.modelContext {
            context.delete(workoutSet)
        }
    }
}

extension WorkoutSet : Comparable {
    public static func < (lhs: WorkoutSet, rhs: WorkoutSet) -> Bool {
        lhs.timestamp < rhs.timestamp
    }
}


