//
//  SavedMemesView.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 6/4/21.
//

import SwiftUI

struct SavedMemesView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @StateObject var scrollToModel = ScrollToModel()
    @State private var selectedURLString = ""
    @State private var showSafariView = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollViewReader { sp in
                    LazyVStack {
                        ForEach(viewModel.savedMemes, id:\.self) { meme in
                            HomeRow(meme: meme)
                                .environmentObject(viewModel)
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
                        Text("Currently there are \(viewModel.savedMemes.count) saved \(viewModel.savedMemes.count == 1 ? "meme" : "memes").")
                            .font(.caption)
                            .foregroundColor(.secondaryLabel)
                            .padding()
                    }
                    .padding([.leading, .trailing])
                }
            }
            .navigationTitle(Text("Saved"))
            .sheet(isPresented: $showSafariView, content: {
                SafariView(urlString: self.$selectedURLString)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
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
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
    }
}

struct SavedMemesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedMemesView()
    }
}
