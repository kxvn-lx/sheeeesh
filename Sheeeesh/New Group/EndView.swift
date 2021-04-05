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
            Image("f-u")
                .resizable()
                .frame(width: 250, height: 250)
            Text("Why r u still here? 😳")
            Text("Made by @kevinlx_ on twitter")
                .font(.caption)
                .foregroundColor(.secondaryLabel)
        }
        .padding()
    }
}

struct EndView_Previews: PreviewProvider {
    static var previews: some View {
        EndView()
    }
}
