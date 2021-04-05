//
//  HomeView.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 5/4/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    @State private var selectedURLString = ""
    @State private var showSafariView = false
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .navigationTitle(Text("Sheeeesh"))
            case .idle:
                List {
                    Section {
                        ForEach(viewModel.memes, id: \.postLink) { meme in
                            HomeRow(meme: meme)
                                .onTapGesture {
                                    self.selectedURLString = meme.postLink
                                    showSafariView = true
                                }
                        }
                    }

                    Section {
                        HStack {
                            Spacer()
                            Button(action: {
                                viewModel.fetch()
                            }, label: {
                                Text("Load More")
                            })
                            Spacer()
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle(Text("Sheeeesh"))
                .sheet(isPresented: $showSafariView, content: {
                    SafariView(urlString: self.$selectedURLString)
                })
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
