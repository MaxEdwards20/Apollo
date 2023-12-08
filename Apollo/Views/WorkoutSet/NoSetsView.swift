//
//  NoSetsView.swift
//  Apollo
//
//  Created by Max Edwards on 12/8/23.
//

import SwiftUI

struct NoSetsView: View {
    var body: some View {
        ContentUnavailableView{
            Label("No Sets", systemImage: "menucard.fill")
        } description: {
            Text("As you record sets, they will appear here.")
        }
    }
}

#Preview {
    NoSetsView()
}
