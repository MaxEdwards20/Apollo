//
//  ApolloApp.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import SwiftUI
import SwiftData

@main
struct ApolloApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Exercise.self, WorkoutSet.self])
        }
        
    }
}
