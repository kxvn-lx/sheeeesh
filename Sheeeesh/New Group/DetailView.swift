//
//  DetailView.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 7/4/21.
//

import SwiftUI
import Backend

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var meme: Meme
    @State private var shouldShowSafariView = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                HomeRow(meme: meme)
                
                Button(action: { self.shouldShowSafariView = true }) {
                    HStack {
                        Spacer()
                        Text("View in Reddit")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                        Spacer()
                    }
                }
            }
            .padding([.leading, .trailing])
            .sheet(isPresented: $shouldShowSafariView, content: {
                SafariView(urlString: .constant(meme.postLink))
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(meme: .constant(.static_meme))
    }
}
