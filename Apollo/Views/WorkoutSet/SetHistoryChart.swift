//
//  WorkoutSetHistory.swift
//  Apollo
//
//  Created by Max Edwards on 12/12/23.
//

import SwiftUI
import SwiftData
//import SwiftUICharts

struct SetHistoryChart: View {
    var exercise: Exercise
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

private struct PreviewSetHistoryChart: View {
    @Query private var exercises: [Exercise] // one source of truth
    var body: some View {
        NavigationStack{
            SetHistoryChart(exercise: exercises[0])
        }
    }
}

#Preview {
    PreviewSetHistoryChart()
        .modelContainer(previewContainer)
}
