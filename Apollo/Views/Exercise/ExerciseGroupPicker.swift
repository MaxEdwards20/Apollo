//
//  ExerciseGroupPicker.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import SwiftUI

struct ExerciseGroupPicker: View {
    @Binding var selectedOption: Exercise.ExerciseGroup
    
    // SwiftUI needs the selectedOption and tag to be the same values
    // https://stackoverflow.com/questions/66617659/picker-selection-not-updating
    
    var body: some View {
        List {
            Picker("Group", selection: $selectedOption){
                ForEach(Exercise.ExerciseGroup.allCases){group in
                    Text(group.name)
                        .tag(group)
                }
            }
        }
    }
}

#Preview {
    ExerciseGroupPicker(selectedOption: .constant(Exercise.ExerciseGroup.abs))
}
