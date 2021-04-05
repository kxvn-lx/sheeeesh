//
//  HomeRow.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 5/4/21.
//

import SwiftUI
import Backend
import SDWebImageSwiftUI

struct HomeRow: View {
    let meme: Meme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(meme.title)
                        .fontWeight(.bold)
                    
                    Text("r/\(meme.subreddit)")
                        .font(.caption2)
                        .foregroundColor(Color.secondaryLabel)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 10) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                        Text("\(meme.author)")
                    }
                    .foregroundColor(.secondaryLabel)
                }
                .font(.caption)
            }
            
            WebImage(url: URL(string: meme.url))
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .border(Color.secondarySystemBackground, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(10)
        }
        .padding([.top, .bottom])
    }
}

struct HomeRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeRow(meme: Meme.static_meme)
            .padding()
    }
}
