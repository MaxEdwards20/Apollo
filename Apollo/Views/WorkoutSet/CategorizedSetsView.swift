//
//  CategorizedSetsView.swift
//  Apollo
//
//  Created by Max Edwards on 12/13/23.
//

import SwiftUI
import SwiftData

struct CategorizedSetsView: View {
    @Query var workoutSets: [WorkoutSet]
    var exercise: Exercise
    private var history: [WorkoutSet] {
        // SwiftData CloudKit Sync Video 59:47
        workoutSets.filter {$0.exercise!.id == exercise.id}
    }
    private var computed: (today: [WorkoutSet], thisWeek: [WorkoutSet], thisMonth: [WorkoutSet], thisYear: [WorkoutSet]) {
        exercise.categorizeExerciseSetHistory(workoutSets: history)
    }
    var body: some View {
        List {
            if !computed.today.isEmpty{
                Section(header: Text("Today")) {
                    ForEach(computed.today) { workoutSet in
                        NavigationLink(destination: SetDetailScreen(workoutSet: workoutSet)){
                            SetRowView(exercise: exercise, workoutSet: workoutSet)
                        }
                    }
                }
            }
            if !computed.thisWeek.isEmpty{
                Section(header: Text("This Week")) {
                    ForEach(computed.thisWeek) { workoutSet in
                        NavigationLink(destination: SetDetailScreen(workoutSet: workoutSet)){
                            SetRowView(exercise: exercise, workoutSet: workoutSet)
                        }
                    }
                }
            }
            // TODO: Make this a include the past 4 weeks. Right now it cuts off at the beginning of the month
            if !computed.thisMonth.isEmpty{
                Section(header: Text("This Month")) {
                    ForEach(computed.thisMonth) { workoutSet in
                        NavigationLink(destination: SetDetailScreen(workoutSet: workoutSet)){
                            SetRowView(exercise: exercise, workoutSet: workoutSet)
                        }
                    }
                }
            }
            if !computed.thisYear.isEmpty{
                Section(header: Text("This Year")) {
                    ForEach(computed.thisYear) { workoutSet in
                        NavigationLink(destination: SetDetailScreen(workoutSet: workoutSet)){
                            SetRowView(exercise: exercise, workoutSet: workoutSet)
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    CategorizedSetsView()
//}
