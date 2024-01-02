//
//  CategorizedSetsView.swift
//  Apollo
//
//  Created by Max Edwards on 12/13/23.
//

import SwiftUI
import SwiftData

struct CategorizedSetsView: View {
    var exercise: Exercise
    private var computed: (today: [WorkoutSet], thisWeek: [WorkoutSet], thisMonth: [WorkoutSet], thisYear: [WorkoutSet]) {
        exercise.categorizeExerciseSetHistory()
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

            if !computed.thisMonth.isEmpty{
                Section(header: Text("This Quarter")) {
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
