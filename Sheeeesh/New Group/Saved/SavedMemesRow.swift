//
//  SavedMemesRow.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 7/4/21.
//

import SwiftUI
import Backend
import SDWebImageSwiftUI

struct SavedMemesRow: View {
    let meme: Meme
    @State private var isSaved = false
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GeometryReader { proxy in
                WebImage(url: URL(string: meme.url))
                    .resizable()
                    .placeholder {
                        Rectangle().foregroundColor(.systemGray6)
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
                    .border(Color.secondarySystemBackground, width: 1)
                    .cornerRadius(15)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .clipped()
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(15)
            
            HStack(spacing: 10) {
                Button(action: {
                    TapticHelper.shared.heavyTaptic()
                    isSaved.toggle()
                    viewModel.save(meme: meme)
                }, label: {
                    HStack(spacing: 5) {
                        isSaved ? Image(systemName: "heart.fill") : Image(systemName: "heart")
                    }
                    .foregroundColor(.systemRed)
                })
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding([.top, .bottom])
        .onAppear(perform: {
            isSaved = viewModel.savedMemes.contains(meme)
        })
    }
}

struct SavedMemesRow_Previews: PreviewProvider {
    static var previews: some View {
        SavedMemesRow(meme: .static_meme)
    }
}
