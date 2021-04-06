//
//  HomeView.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 5/4/21.
//

import SwiftUI
import Backend

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @StateObject var scrollToModel = ScrollToModel()
    @State private var selectedURLString = ""
    @State private var activeSheet: ActiveSheet?
    @State private var paginationCount = -1
    @State private var prevMemesCount = 0
    @State private var shouldAutoScroll = false
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .navigationTitle(Text("For You"))
            case .idle:
                ScrollView {
                    ScrollViewReader { sp in
                        LazyVStack {
                            ForEach(viewModel.memes, id:\.self) { meme in
                                HomeRow(meme: meme)
                                    .environmentObject(viewModel)
                                    .onTapGesture {
                                        self.selectedURLString = meme.postLink
                                        activeSheet = .safariView
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
                                    shouldAutoScroll = true
                                }, label: {
                                    Text("Load More")
                                })
                                Spacer()
                            }
                            .padding()
                            .onAppear(perform: {
                                if shouldAutoScroll {
                                    withAnimation {
                                        if paginationCount > -1 {
                                            sp.scrollTo(viewModel.memes[(prevMemesCount - 1)])
                                        } else {
                                            sp.scrollTo(viewModel.memes.first!, anchor: .top)
                                        }
                                    }
                                    
                                    shouldAutoScroll = false
                                }
                            })
                        }
                        .padding([.leading, .trailing])
                    }
                }
                .navigationTitle(Text("For You"))
                .sheet(item: $activeSheet) { item in
                    switch item {
                    case .safariView:
                        SafariView(urlString: self.$selectedURLString)
                    case .subredditView:
                        SubredditView(selectedEndpoint: $viewModel.endpoint)
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
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
                            activeSheet = .subredditView
                        }) {
                            Text("/r")
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
