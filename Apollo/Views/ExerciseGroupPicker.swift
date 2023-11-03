//
//  ExerciseGroupPicker.swift
//  Apollo
//
//  Created by Max Edwards on 11/2/23.
//

import SwiftUI

struct ExerciseGroupPicker: View {
    @Binding var selectedOption: Exercise.ExerciseGroup
    
    var body: some View {
        Picker("Group", selection: $selectedOption){
            ForEach(Exercise.ExerciseGroup.allCases){group in
                Text(group.name)
            }
        }.pickerStyle(.wheel)
    }
}

#Preview {
    ExerciseGroupPicker(selectedOption: .constant(Exercise.ExerciseGroup.abs))
}
