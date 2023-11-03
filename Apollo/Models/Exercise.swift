//
//  Exercise.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import Foundation
import SwiftData

@Model
final class Exercise: Identifiable, CustomStringConvertible {
    var id: UUID
    var name:String // Makes sure we only have 1 exercise
    var maxWeight:Int // Max weight ever lifted for this exercise
    var group:ExerciseGroup
    var bestSet:WorkoutSet? // max total weight done in a set (weight * reps)
    
    // Exercise which holds many workout sets
    @Relationship(deleteRule: .cascade, inverse: \WorkoutSet.exercise) var history : [WorkoutSet]
    
    init( name: String, maxWeight: Int = 0, group:ExerciseGroup) {
        self.id = UUID()
        self.name = name.lowercased().capitalized // clean up the name before capitalizing it for looks
        self.maxWeight = maxWeight
        self.group = group
        self.history = []
    }
    
    static func delete(_ e: Exercise){
        if let context = e.modelContext{
            context.delete(e)
        }
    }
    
    func addWorkoutSet(s: WorkoutSet){
        self.history.append(s)
        self.computeMaxWeight() // adjust for the new values
    }
    
    func deleteWorkoutSet(s: WorkoutSet){
        if let context = s.modelContext {
            context.delete(s)
        }
        self.computeMaxWeight()
    }
    
    
    func computeMaxWeight() -> Int {
        var bestWeight:Int = 0;
        for i in self.history{
            if i.weight > bestWeight {
                bestWeight = i.weight
            }
        }
        self.maxWeight = bestWeight
        return bestWeight
    }
    
    var description: String {
        return "Name: \(self.name) History: \(self.history) "
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
    }
}






