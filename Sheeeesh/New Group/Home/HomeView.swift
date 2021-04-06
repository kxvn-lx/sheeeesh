//
//  HomeView.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 5/4/21.
//

import SwiftUI
import Backend

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @StateObject var scrollToModel = ScrollToModel()
    @State private var selectedURLString = ""
    @State private var showSafariView = false
    @State private var showSubredditSheet = false
    @State private var paginationCount = -1
    @State private var prevMemesCount = 0
    
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
                                HomeRow(meme: meme, viewModel: self.viewModel)
                                    .onTapGesture {
                                        self.selectedURLString = meme.postLink
                                        showSafariView = true
                                    }
                            }
                        }
                        .padding([.leading, .trailing])
                        .onReceive(scrollToModel.$direction) { action in
                            guard !viewModel.memes.isEmpty else { return }
                            withAnimation {
                                switch action {
                                case .top:
                                    sp.scrollTo(viewModel.memes.first!, anchor: .top)
                                case .end:
                                    sp.scrollTo(viewModel.memes.last!, anchor: .bottom)
                                default:
                                    return
                                }
                            }
                        }
                        
                        VStack {
                            Text("Currently there are \(viewModel.memes.count) memes.")
                                .font(.caption)
                                .foregroundColor(.secondaryLabel)
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    paginationCount += 1
                                    prevMemesCount = viewModel.memes.count
                                    viewModel.fetch()
                                }, label: {
                                    Text("Load More")
                                })
                                Spacer()
                            }
                            .padding()
                            .onAppear(perform: {
                                if paginationCount > -1 {
                                    sp.scrollTo(viewModel.memes[(prevMemesCount - 1)])
                                } else {
                                    sp.scrollTo(viewModel.memes.first!, anchor: .top)
                                }
                            })
                            
                            Spacer()
                            
                            EndView()
                                .frame(height: 750)
                        }
                        .padding([.leading, .trailing])
                    }
                }
                .navigationTitle(Text("Sheeeesh"))
                .sheet(isPresented: $showSafariView, content: {
                    SafariView(urlString: self.$selectedURLString)
                })
                .sheet(isPresented: $showSubredditSheet, content: {
                    SubredditView(selectedEndpoint: $viewModel.endpoint)
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack(spacing: 10) {
                            Menu {
                                Button(action: {
                                    scrollToModel.direction = .top
                                }) {
                                    Label("To first post", systemImage: "chevron.up")
                                }
                                Button(action: {
                                    scrollToModel.direction = .end
                                }) {
                                    Label("To last post", systemImage: "chevron.down")
                                }
                                Button(action: {
                                    paginationCount = -1
                                    viewModel.reload()
                                }) {
                                    Label("Reload fresh memes", systemImage: "arrow.clockwise")
                                }
                            } label: {
                                Image(systemName: "ellipsis.circle")
                            }
                            
                            Button(action: {
                                showSubredditSheet = true
                            }) {
                                Text("/r")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
