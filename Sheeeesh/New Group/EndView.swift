//
//  EndView.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 5/4/21.
//

import SwiftUI

struct EndView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Sheeeeeeeesh")
                .font(.caption2)
                .foregroundColor(.tertiaryLabel)
        }
        .padding()
    }
}

struct EndView_Previews: PreviewProvider {
    static var previews: some View {
        EndView()
    }
}
