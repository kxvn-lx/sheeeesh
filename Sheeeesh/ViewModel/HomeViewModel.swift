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
    
    func fetch() {
        state = .loading
        
        API.shared.request(withEndpoint: endpoint) { [weak self] (memeCollection) in
            DispatchQueue.main.async {
                self?.state = .idle
                self?.memes.appendDistinct(contentsOf: memeCollection.memes, where: { $0.url != $1.url })
            }
        }
    }
    
    func reload() {
        state = .loading
        
        API.shared.request(withEndpoint: endpoint) { [weak self] (memeCollection) in
            DispatchQueue.main.async {
                self?.state = .idle
                self?.memes = memeCollection.memes
            }
        }
    }
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
