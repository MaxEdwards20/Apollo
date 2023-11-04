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
    var name:String
    var group:ExerciseGroup
    // max total weight done in a set (weight * reps)
    var bestSet:WorkoutSet? {
        computeBestSet()
    }
    // Exercise which holds many workout sets
    var history : [WorkoutSet]
    // Max weight ever lifted for this exercise
    var maxWeight:Int {
        computeMaxWeight()
    }
    
    var description: String {
        return "Name: \(self.name)"
    }
    
    init( name: String, group:ExerciseGroup) {
        self.id = UUID()
        self.name = name.lowercased().capitalized // clean up the name before capitalizing it for looks
        self.group = group
        self.history = []
    }
    
    static func delete(_ e: Exercise){
        if let context = e.modelContext{
            context.delete(e)
        }
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
        
        public var id: String {
            name
        }
    }
    
    
    private func computeMaxWeight() -> Int {
        var bestWeight:Int = 0;
        for i in self.history{
            if i.weight > bestWeight {
                bestWeight = i.weight
            }
        }
        return bestWeight
    }
    
    private func computeBestSet() -> WorkoutSet? {
        if self.history.count == 0 {return nil}
        else {
            var bestSet:WorkoutSet = self.history[0]
            for i in self.history {
                if i.totalWeight > bestSet.totalWeight {
                    bestSet = i
                }
            }
            return bestSet
        }
    }
}






