//
//  WorkoutSetHistory.swift
//  Apollo
//
//  Created by Max Edwards on 12/12/23.
//

import SwiftUI
import SwiftData
import SwiftUICharts

struct SetHistoryChart: View {
    var exercise: Exercise
    

    
    private func maxWeights() -> [(String, Double)] {
        var chartData: [(String, Double)] = []
        var history = exercise.sortHistory()
        if ((history == nil) || ((history?.isEmpty) == true) ){
            return chartData
        }
        for h in history! {
            chartData.append((h.timestamp.formatted(), Double(h.weight)))
        }
        return chartData
    }
    
    private func bestSets() -> [Double]{
        var res: [Double] = []
        
        for h in exercise.history! {
            res.append(Double(h.totalWeight))
        }
        return res
    }
    
    
        
    var body: some View {
        HStack{
            BarChartView(data: ChartData(values: maxWeights()), title: "Max Weight", legend: "Date").padding()
//            LineChartView(data: bestSets(), title: "Highest Volume").padding()
        }.padding()
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
