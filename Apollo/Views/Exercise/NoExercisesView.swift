//
//  NoExercisesView.swift
//  Apollo
//
//  Created by Max Edwards on 12/8/23.
//

import SwiftUI

struct NoExercisesView: View {
    var body: some View {
        ContentUnavailableView{
            Label("No Exercises", systemImage: "menucard.fill")
        } description: {
            Text("Your created exercises will appear here.")
        }
    }
}

#Preview {
    NoExercisesView()
}
