//
//  HomeView.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 5/4/21.
//

import SwiftUI
import Backend

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    @State private var selectedURLString = ""
    @State private var showSafariView = false
    @State private var paginationCount = -1
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .navigationTitle(Text("Sheeeesh"))
            case .idle:
                ScrollView {
                    ScrollViewReader { sp in
                        LazyVStack {
                            ForEach(viewModel.memes, id: \.self) { meme in
                                HomeRow(meme: meme)
                                    .onTapGesture {
                                        self.selectedURLString = meme.postLink
                                        showSafariView = true
                                    }
                                Divider()
                            }
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                viewModel.fetch()
                            }, label: {
                                Text("Load More")
                            })
                            Spacer()
                        }
                        .padding()
                        .onAppear(perform: {
                            paginationCount += 1
                            if paginationCount > 0 {
                                sp.scrollTo(viewModel.memes[(API.shared.FETCH_COUNT * paginationCount) - 2])
                            }
                        })
                    }
                }
                .padding([.leading, .trailing])
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
