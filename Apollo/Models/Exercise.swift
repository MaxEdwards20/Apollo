//
//  Exercise.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import Foundation
import SwiftData

@Model
public class Exercise: CustomStringConvertible {
    var name:String = ""
    var group:ExerciseGroup = ExerciseGroup.abs
    
    @Relationship(deleteRule: .cascade)
    var history : [WorkoutSet]?
    
    // Max weight ever lifted for this exercise
    var maxWeight:Int {
        computeMaxWeight()
    }
    // max total weight done in a set (weight * reps)
    var bestSet:WorkoutSet? {
        computeBestSet()
    }
    
    public var description: String {
        return "Name: \(self.name)"
    }
    
    init( name: String, group: ExerciseGroup) {
        self.name = name.lowercased().capitalized // clean up the name before capitalizing it for looks
        self.group = group
    }
    
    public func getMostRecentSet() -> WorkoutSet? {
        if (self.history == nil || self.history!.count == 0) {return nil}
        var mostRecent: WorkoutSet = self.history![0]
        for i in self.history! {
            if i.timestamp > mostRecent.timestamp {
                mostRecent = i
            }
        }
        return mostRecent
    }
    
    
            
    // https://developer.apple.com/forums/thread/731416
    public enum ExerciseGroup: String, Codable, CaseIterable, Identifiable {
        case legs
        case arms
        case back
        case chest
        case abs
        case shoulders
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
        if self.history != nil {
            for i in self.history!{
                if i.weight > bestWeight {
                    bestWeight = i.weight
                }
            }
        }
        return bestWeight
    }
    
    private func computeBestSet() -> WorkoutSet? {
        if self.history == nil {return nil}
        else {
            var bestSet:WorkoutSet = self.history![0]
            for i in self.history! {
                if i.totalWeight > bestSet.totalWeight {
                    bestSet = i
                }
            }
            return bestSet
        }
    }
    
    public func sortHistory() -> [WorkoutSet]? {
        guard var sortedHistory = history else { return nil }

        sortedHistory.sort(by: { $0.timestamp < $1.timestamp })

        return sortedHistory
    }
    
    // Ideally we could just use the exercise.history here, but SwiftUI has issues with this
    public func categorizeExerciseSetHistory(workoutSets: [WorkoutSet]) -> (today: [WorkoutSet], thisWeek: [WorkoutSet], thisMonth: [WorkoutSet], thisYear: [WorkoutSet]) {
        let currentDate = Date()
        let calendar = Calendar.current
        
        var todaySets: [WorkoutSet] = []
        var thisWeekSets: [WorkoutSet] = []
        var thisMonthSets: [WorkoutSet] = []
        var thisYearSets: [WorkoutSet] = []
        
        // Put each set into the proper categorization
        for workoutSet in workoutSets {
            if calendar.isDateInToday(workoutSet.timestamp) {
                todaySets.append(workoutSet)
            } else if calendar.isDate(workoutSet.timestamp, equalTo: currentDate, toGranularity: .weekOfYear) {
                thisWeekSets.append(workoutSet)
            } else if calendar.isDate(workoutSet.timestamp, equalTo: currentDate, toGranularity: .month)   {
                thisMonthSets.append(workoutSet)
            } else if calendar.isDate(workoutSet.timestamp, equalTo: currentDate, toGranularity: .year)  {
                thisYearSets.append(workoutSet)
            }
        }
        
        // Sort the sets from most recent to last recent
        for var l in [todaySets, thisWeekSets, thisMonthSets, thisYearSets]{
            l.sort {$0.timestamp > $1.timestamp}
        }
        
        return (todaySets, thisWeekSets, thisMonthSets, thisYearSets)
    }
    

}






