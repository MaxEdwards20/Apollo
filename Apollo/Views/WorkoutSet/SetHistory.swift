//
//  WorkoutHistoryView.swift
//  Apollo
//
//  Created by Max Edwards on 11/3/23.
//

import SwiftUI
import SwiftData

// TODO: Make history items clickable to edit them
// TODO: Add a graph that shows max weights over time
// TODO: Add a graph that shows total weight over time

struct SetHistory: View {
    @Query var workoutSets: [WorkoutSet]
    var exercise: Exercise
    @State private var history: [WorkoutSet] = []
    @State private var today: [WorkoutSet] = []
    @State private var thisWeek: [WorkoutSet] = []
    @State private var thisMonth: [WorkoutSet] = []
    @State private var thisYear: [WorkoutSet] = []
    @Environment(\.modelContext) private var context
    @State private var isShowingAddSets = false
    
    private func getExerciseHistory(exercise: Exercise) -> [WorkoutSet]{
        var h : [WorkoutSet] = []
        for s in workoutSets {
            if s.exercise != nil && s.exercise!.id == exercise.id {
                h.append(s)
            }
        }
        return h
    }
    
    //TODO: Make the duplicate and and add set buttons show up in the context
    
    private func initializeData(){
        history = getExerciseHistory(exercise: exercise)
        let categorized = exercise.categorizeExerciseSetHistory(workoutSets: history)
        today = categorized.today
        thisWeek = categorized.thisWeek
        thisMonth = categorized.thisMonth
        thisYear = categorized.thisYear
    }
    
    var body: some View {
        VStack{
            Text("History")
                .font(.title3)
            List {
                if !today.isEmpty{
                    Section(header: Text("Today")) {
                        ForEach(today) { workoutSet in
                            NavigationLink(destination: SetDetailScreen(workoutSet: workoutSet)){
                                SetRowView(exercise: exercise, workoutSet: workoutSet)
                            }
                        }
                    }
                }
                if !thisWeek.isEmpty{
                    Section(header: Text("This Week")) {
                        ForEach(thisWeek) { workoutSet in
                            NavigationLink(destination: SetDetailScreen(workoutSet: workoutSet)){
                                SetRowView(exercise: exercise, workoutSet: workoutSet)
                            }
                        }
                    }
                }
                // TODO: Make this a include the past 4 weeks. Right now it cuts off at the beginning of the month
                if !thisMonth.isEmpty{
                    Section(header: Text("This Month")) {
                        ForEach(thisMonth) { workoutSet in
                            NavigationLink(destination: SetDetailScreen(workoutSet: workoutSet)){
                                SetRowView(exercise: exercise, workoutSet: workoutSet)
                            }
                        }
                    }
                }
                if !thisYear.isEmpty{
                    Section(header: Text("This Year")) {
                        ForEach(thisYear) { workoutSet in
                            NavigationLink(destination: SetDetailScreen(workoutSet: workoutSet)){
                                SetRowView(exercise: exercise, workoutSet: workoutSet)
                            }
                        }
                    }
                }
            }
        }.onAppear{
            initializeData()
        }
    }
}

private struct PreviewWorkoutHistoryView: View {
    @Query private var exercises: [Exercise] // one source of truth
    var body: some View {
        SetHistory(exercise: exercises[0])
    }
}

#Preview {
    PreviewWorkoutHistoryView()
        .modelContainer(previewContainer)
}


