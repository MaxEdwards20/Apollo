//
//  WorkoutSet.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import Foundation
import SwiftData

@Model
public class WorkoutSet: CustomStringConvertible {
    var timestamp: Date = Date.now
    var weight:Int = 0
    var reps: Int = 0
    var duration:TimeInterval?
    var notes:String?
    var exercise:Exercise?
    
    init(weight: Int, reps: Int, timestamp: Date = Date.now, notes: String? = nil, duration: TimeInterval? = nil) {
        self.timestamp = timestamp
        self.weight = weight
        self.reps = reps
        if notes != nil {self.notes = notes}
        if duration != nil {self.duration = duration}
    }
    
    public var description: String {
        return "Weight: \(self.weight) Reps: \(self.reps)"
    }
    
    public func getVolume() -> Int{
        return weight == 0 ? reps : reps * weight
    }
}



