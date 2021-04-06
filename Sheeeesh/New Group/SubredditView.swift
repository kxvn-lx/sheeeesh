//
//  SubredditView.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 6/4/21.
//

import SwiftUI
import Backend

struct SubredditView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedEndpoint: Endpoint
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Spacer()
                        VStack(spacing: 10) {
                            Text("/r")
                                .fontWeight(.bold)
                                .font(.title)
                            Text("Select subreddit to fetch all the memes")
                                .foregroundColor(.secondaryLabel)
                        }
                        Spacer()
                    }
                }
                
                Section {
                    ForEach(Endpoint.allCases, id: \.self) { endpoint in
                        HStack {
                            Text(endpoint.rawValue)
                            Spacer()
                            if selectedEndpoint == endpoint {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.systemBlue)
                            }
                        }
                            .onTapGesture {
                                selectedEndpoint = endpoint
                                TapticHelper.shared.lightTaptic()
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(Text("Subreddit selection"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
