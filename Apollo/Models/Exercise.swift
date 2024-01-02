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
    public var description: String {
        return "Name: \(self.name)"
    }
    init(name: String, group: ExerciseGroup) {
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
    
    public func getBestSets() -> [Double]?{
        if (history == nil){return nil}
        var res: [Double] = []
        for h in history! {
            res.append(Double(h.getVolume()))
        }
        return res
    }
    
    public func sortHistory() -> [WorkoutSet]? {
        if (history == nil){return nil}
        var sortedHistory = history!
        sortedHistory.sort(by: { $0.timestamp > $1.timestamp })
        history = sortedHistory // adjust the actual history values
        return sortedHistory
    }

    public func categorizeExerciseSetHistory() -> (today: [WorkoutSet], thisWeek: [WorkoutSet], thisMonth: [WorkoutSet], thisYear: [WorkoutSet]) {
        let currentDate = Date()
        let calendar = Calendar.current
        var todaySets: [WorkoutSet] = []
        var thisWeekSets: [WorkoutSet] = []
        var thisMonthSets: [WorkoutSet] = []
        var thisYearSets: [WorkoutSet] = []
        let h = sortHistory()
        // Put each set into the proper categorization
        for workoutSet in h! {
            if calendar.isDateInToday(workoutSet.timestamp) {
                todaySets.append(workoutSet)
            } else if calendar.isDate(workoutSet.timestamp, equalTo: currentDate, toGranularity: .weekOfYear) {
                thisWeekSets.append(workoutSet)
            } else if calendar.isDate(workoutSet.timestamp, equalTo: currentDate, toGranularity: .quarter)   {
                thisMonthSets.append(workoutSet)
            } else if calendar.isDate(workoutSet.timestamp, equalTo: currentDate, toGranularity: .year)  {
                thisYearSets.append(workoutSet)
            }
        }
        return (todaySets, thisWeekSets, thisMonthSets, thisYearSets)
    }
    
    public func getMaxWeight() -> Int {
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
    
    public func getBestSet() -> WorkoutSet? {
        if self.history == nil {return nil}
        else {
            var bestSet:WorkoutSet = self.history![0]
            for i in self.history! {
                if i.getVolume() > bestSet.getVolume() {
                    bestSet = i
                }
            }
            return bestSet
        }
    }
    
    

}






