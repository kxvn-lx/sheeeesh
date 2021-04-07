//
//  HomeRow.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 5/4/21.
//

import SwiftUI
import UIKit
import Backend
import SDWebImageSwiftUI

struct HomeRow: View {
    let meme: Meme
    @State private var isSaved = false
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
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
                    Rectangle().foregroundColor(.systemGray6)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .border(Color.secondarySystemBackground, width: 1)
                .cornerRadius(15)
            
            HStack(spacing: 10) {
                Button(action: {
                    TapticHelper.shared.heavyTaptic()
                    isSaved.toggle()
                    
                    viewModel.save(meme: meme)
                }, label: {
                    HStack(spacing: 5) {
                        isSaved ? Image(systemName: "heart.fill") : Image(systemName: "heart")
                        Text(isSaved ? "Saved" : "Save")
                    }
                    .foregroundColor(.systemRed)
                })
                
                Spacer()
                
                Button(action: {
                    download()
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                })
                .foregroundColor(.accentColor)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding([.top, .bottom])
        .onAppear(perform: {
            isSaved = viewModel.savedMemes.contains(meme)
        })
    }
}

extension HomeRow {
    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
    private func download() {
        guard let imageURL = URL(string: meme.url) else { return }
        getDataFromUrl(url: imageURL) { (data, _, error) in
            guard let data = data else { return }
            guard let image = UIImage(data: data) else {
                TapticHelper.shared.errorTaptic()
                return
            }
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            
            TapticHelper.shared.successTaptic()
        }
    }
}

struct HomeRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeRow(meme: Meme.static_meme)
            .padding()
    }
}
