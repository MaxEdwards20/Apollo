//
//  Exercise.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import Foundation
import SwiftData

@Model
final class Exercise {
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) var name:String // Makes sure we only have 1 exercise
    var maxWeight:Int // Max weight ever lifted for this exercise
//    var bestSet:WorkoutSet? // max total weight done in a set (weight * reps)
//    var history:[WorkoutSet]?
    var group:ExerciseGroup
    
    init( name: String, maxWeight: Int = 0, group:ExerciseGroup) {
        self.id = UUID()
        self.name = name.lowercased()
        self.maxWeight = maxWeight
        self.group = group
    }
    
    // https://developer.apple.com/forums/thread/731416
    public enum ExerciseGroup: String, Codable, CaseIterable, Identifiable {
        case legs
        case arms
        case back
        case chest
        case abs
        case cardio
        
        var name: String {
            rawValue.capitalized
        }
        
        var id: String {
            name
        }
        
//        func hash(into hasher: inout Hasher) {
//            hasher.combine(id)
//            hasher.combine(rawValue.capitalized)
//        }
    }
}






