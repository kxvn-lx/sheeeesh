//
//  SavedMemesView.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 6/4/21.
//

import SwiftUI
import QGrid
import Backend

struct SavedMemesView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var shouldPresentDetaiLView = false
    @State private var selectedMeme: Meme = .static_meme
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                QGrid(
                    viewModel.savedMemes,
                    columns: 3,
                    vSpacing: 0,
                    hSpacing: 0) { meme in
                    SavedMemesRow(meme: meme)
                        .onTapGesture {
                            selectedMeme = meme
                            shouldPresentDetaiLView = true
                        }
                }
                
                VStack {
                    Text("Currently there are \(viewModel.savedMemes.count) saved \(viewModel.savedMemes.count == 1 ? "meme" : "memes").")
                        .font(.caption)
                        .foregroundColor(.secondaryLabel)
                        .padding()
                }
            }
            .navigationTitle(Text("Saved"))
            .sheet(isPresented: $shouldPresentDetaiLView, content: {
                DetailView(meme: $selectedMeme)
            })
        }
    }
}

struct SavedMemesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedMemesView()
    }
}
