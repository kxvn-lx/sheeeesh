//
//  HomeView.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 5/4/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .navigationTitle(Text("Sheeeesh"))
            case .idle:
                List {
                    Section {
                        ForEach(viewModel.memes, id: \.postLink) { HomeRow(meme: $0) }
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
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
