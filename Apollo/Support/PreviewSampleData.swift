//
//  PreviewSampleData.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import Foundation
import SwiftData

// Taken from preview sample data here https://docs-assets.developer.apple.com/published/a378001f6c52/BuildingADocumentBasedAppUsingSwiftData.zip

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: Exercise.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let modelContext = container.mainContext
        if try modelContext.fetch(FetchDescriptor<Exercise>()).isEmpty {
            SampleExercises.contents.forEach { container.mainContext.insert($0) }
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
