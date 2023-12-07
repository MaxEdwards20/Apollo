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
        let container = try ModelContainer(for: Exercise.self)
        let configuration = (ModelConfiguration(isStoredInMemoryOnly: true))
        let modelContext = container.mainContext
        // now we add the items into the context
        
        if try modelContext.fetch(FetchDescriptor<Exercise>()).isEmpty {
            let data = SampleData().contents
            // Add the exercises to the context
            data.forEach { exercise in
                container.mainContext.insert(exercise)
            }
            // Add sets to the context for each exercise
            data.forEach {e in
                SampleData.generateSets(exercise: e)
            }
        }
        
        
        // Potentially could add the exercise sets here
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
