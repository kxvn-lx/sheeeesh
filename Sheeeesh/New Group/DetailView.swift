//
//  DetailView.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 7/4/21.
//

import SwiftUI
import Backend

struct DetailView: View {
    @Binding var meme: Meme
    @State private var shouldShowSafariView = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HomeRow(meme: meme)
            
            Button(action: { self.shouldShowSafariView = true }) {
                HStack {
                    Spacer()
                    Text("View in Reddit")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                    Spacer()
                }
            }
        }
        .padding()
        .sheet(isPresented: $shouldShowSafariView, content: {
            SafariView(urlString: .constant(meme.postLink))
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(meme: .constant(.static_meme))
    }
}
