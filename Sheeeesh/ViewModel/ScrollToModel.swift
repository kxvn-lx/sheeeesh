//
//  ScrollToModel.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 5/4/21.
//

import Foundation

class ScrollToModel: ObservableObject {
    enum Action {
        case end
        case top
    }
    @Published var direction: Action? = nil
}
