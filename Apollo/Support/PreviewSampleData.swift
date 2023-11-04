//
//  PreviewSampleData.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import Foundation
import SwiftData

// Taken from preview sample data here https://docs-assets.developer.apple.com/published/a378001f6c52/BuildingADocumentBasedAppUsingSwiftData.zip

// Article with explanation here
// https://www.hackingwithswift.com/quick-start/swiftdata/how-to-use-swiftdata-in-swiftui-previews

@MainActor
 let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Exercise.self, WorkoutSet.self)
        let configuration = (ModelConfiguration(isStoredInMemoryOnly: true))
        let modelContext = container.mainContext
        if try modelContext.fetch(FetchDescriptor<Exercise>()).isEmpty {
            SampleData().contents.forEach { container.mainContext.insert($0) }
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
