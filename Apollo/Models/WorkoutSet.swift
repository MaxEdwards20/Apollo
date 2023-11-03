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
    
    init(weight: Float, reps: Int, notes: String = "") {
        self.id = UUID()
        self.timestamp = Date.now
        self.weight = weight
        self.reps = reps
        self.notes = notes
        self.totalWeight = Int(weight) * reps
    }
}

//extension WorkoutSet {
//    static let sampleData: [WorkoutSet] =
//    [
//        WorkoutSet(weight: 225, reps: 1, notes: "Felt Heavy"),
//        WorkoutSet(weight: 275, reps: 4),
//        WorkoutSet(weight: 45, reps: 10)
//    ]
//}
//

