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
    @Published var endpoint: Endpoint = .random {
        didSet {
            reload()
        }
    }
    
    init() {
        fetch()
    }
    
    
    /// Fetch new memes, and append it to the memes array.
    func fetch() {
        state = .loading
        
        API.shared.request(withEndpoint: endpoint) { [weak self] (memeCollection) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.state = .idle
                self.memes.appendDistinct(contentsOf: memeCollection.memes, where: { $0.url != $1.url })
            }
        }
    }
    
    /// Fetch new memes and replace it to the memes array
    func reload() {
        state = .loading
        
        API.shared.request(withEndpoint: endpoint) { [weak self] (memeCollection) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.state = .idle
                self.memes = memeCollection.memes
            }
        }
    }
    
    // MARK: - Private methods
    
}

extension Array {
    public mutating func appendDistinct<S>(contentsOf newElements: S, where condition:@escaping (Element, Element) -> Bool) where S : Sequence, Element == S.Element {
      newElements.forEach { (item) in
        if !(self.contains(where: { (selfItem) -> Bool in
            return !condition(selfItem, item)
        })) {
            self.append(item)
        }
    }
  }
}
