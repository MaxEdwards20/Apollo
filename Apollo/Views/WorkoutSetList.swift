//
//  WorkoutHistoryView.swift
//  Apollo
//
//  Created by Max Edwards on 11/3/23.
//

import SwiftUI
import SwiftData

// TODO: Make history items clickable to edit them
// TODO: Group History By day, week, month, and year
// TODO: Add a graph that shows max weights over time
// TODO: Add a graph that shows total weight over time

struct WorkoutSetList: View {
    var exercise: Exercise
    @Environment(\.modelContext) private var context// We need this to be able to delete items
    @State private var isShowingAddSets = false
    
    func categorizeWorkoutSets(workoutSets: [WorkoutSet]) -> (today: [WorkoutSet], thisWeek: [WorkoutSet], pastMonth: [WorkoutSet], pastYear: [WorkoutSet]) {
        let currentDate = Date()
        let calendar = Calendar.current
        
        var todaySets: [WorkoutSet] = []
        var thisWeekSets: [WorkoutSet] = []
        var pastMonthSets: [WorkoutSet] = []
        var pastYearSets: [WorkoutSet] = []
        
        // Put each set into the proper categorization
        for workoutSet in workoutSets {
            if calendar.isDateInToday(workoutSet.timestamp) {
                todaySets.append(workoutSet)
            } else if calendar.isDate(workoutSet.timestamp, equalTo: currentDate, toGranularity: .weekOfYear) {
                thisWeekSets.append(workoutSet)
            } else if calendar.isDate(workoutSet.timestamp, equalTo: currentDate, toGranularity: .month)   {
                pastMonthSets.append(workoutSet)
            } else if calendar.isDate(workoutSet.timestamp, equalTo: currentDate, toGranularity: .year)  {
                pastYearSets.append(workoutSet)
            }
        }
        
        // Sort the sets from most recent to last recent
        for var l in [todaySets, thisWeekSets, pastMonthSets, pastYearSets]{
            l.sort {$0.timestamp > $1.timestamp}
        }
        
        return (todaySets, thisWeekSets, pastMonthSets, pastYearSets)
    }
    
    var body: some View {
        let categorizedSets = categorizeWorkoutSets(workoutSets: exercise.history)
        VStack{
            Text("History")
                .font(.title3)

        }
        List {
            if !categorizedSets.today.isEmpty{
                Section(header: Text("Today")) {
                    ForEach(categorizedSets.today) { workoutSet in
                        NavigationLink(destination: WorkoutSetDetail(workoutSet: workoutSet)){
                            WorkoutSetRowView(exercise: exercise, workoutSet: workoutSet)
                        }
                    }
                }
            }
            
            if !categorizedSets.thisWeek.isEmpty{
                Section(header: Text("This Week")) {
                    ForEach(categorizedSets.thisWeek) { workoutSet in
                        NavigationLink(destination: WorkoutSetDetail(workoutSet: workoutSet)){
                            WorkoutSetRowView(exercise: exercise, workoutSet: workoutSet)
                        }
                    }
                }
            }// TODO: Make this a include the past 4 weeks. Right now it cuts off at the beginning of the month
            if !categorizedSets.pastMonth.isEmpty{
                Section(header: Text("This Month")) {
                    ForEach(categorizedSets.pastMonth) { workoutSet in
                        NavigationLink(destination: WorkoutSetDetail(workoutSet: workoutSet)){
                            WorkoutSetRowView(exercise: exercise, workoutSet: workoutSet)
                        }
                    }
                }
            }
            if !categorizedSets.pastYear.isEmpty{
                Section(header: Text("Past Year")) {
                    ForEach(categorizedSets.pastYear) { workoutSet in
                        NavigationLink(destination: WorkoutSetDetail(workoutSet: workoutSet)){
                            WorkoutSetRowView(exercise: exercise, workoutSet: workoutSet)
                        }
                    }
                }
            }
        }
        // Make this a pill
        HStack {
            Button(action: {
                isShowingAddSets = true
            }) {
                Text("Add a Set")
                    .font(.title2)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue)) // Adjust color as needed
                    .foregroundColor(.white)
            }.frame(maxWidth: .infinity)
        }.popover(isPresented: $isShowingAddSets, content: {
            AddWorkoutSetView(exercise: exercise, isShowingAddSets: $isShowingAddSets)
                .padding()
            }
    )}
}
private struct PreviewWorkoutHistoryView: View {
    @Query private var exercises: [Exercise] // one source of truth
    var body: some View {
        WorkoutSetList(exercise: exercises[0])
    }
}

#Preview {
    PreviewWorkoutHistoryView()
        .modelContainer(previewContainer)
}


