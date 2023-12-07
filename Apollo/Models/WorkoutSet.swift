//
//  WorkoutSet.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import Foundation
import SwiftData

@Model
class WorkoutSet: CustomStringConvertible {
    var id: UUID = UUID()
    var timestamp: Date = Date.now
    var weight:Int = 0
    var reps: Int = 0
    
    var totalWeight:Int {
        weight * reps
    }
    var notes:String?
    var exercise:Exercise?
    
    init(weight: Int, reps: Int, timestamp: Date = Date.now, notes: String? = nil) {
        self.timestamp = timestamp
        self.weight = weight
        self.reps = reps
        if notes != nil {self.notes = notes}
    }
    
    var description: String {
        return "Weight: \(self.weight) Reps: \(self.reps)"
    }
}



