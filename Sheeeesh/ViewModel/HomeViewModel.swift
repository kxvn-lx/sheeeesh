//
//  HomeViewModel.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 5/4/21.
//

import Foundation
import Backend

class HomeViewModel: ObservableObject {
    enum State {
        case loading
        case idle
    }

    @Published private(set) var state = State.loading
    @Published private(set) var memes = [Meme]()
    
    init() {
        fetch()
    }
    
    func fetch() {
        state = .loading
        
        API.shared.request { [weak self] (memeCollection) in
            DispatchQueue.main.async {
                self?.state = .idle
                self?.memes = memeCollection.memes
            }
        }
    }
    
}
