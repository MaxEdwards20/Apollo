//
//  WorkoutSetHistory.swift
//  Apollo
//
//  Created by Max Edwards on 12/12/23.
//

import SwiftUI
import SwiftData
import Charts
import SwiftUICharts

struct SetHistoryChart: View {
    var exercise: Exercise    
    // We can't access this view without there being history. Safe to assume there is history
    var body: some View {
        VStack {
            LineChartView(data: exercise.history!.map { Double($0.weight) }, title: "Volume")
                .padding()
        }
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
