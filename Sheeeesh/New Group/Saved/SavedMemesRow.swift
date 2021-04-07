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
    
    var body: some View {
        GeometryReader { proxy in
            WebImage(url: URL(string: meme.url))
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.systemGray6)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .clipped()
        .aspectRatio(1, contentMode: .fit)
    }
}

struct SavedMemesRow_Previews: PreviewProvider {
    static var previews: some View {
        SavedMemesRow(meme: .static_meme)
    }
}
