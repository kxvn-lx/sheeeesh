//
//  ActiveSheet.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 6/4/21.
//

import Foundation

enum ActiveSheet: Identifiable {
    case safariView, subredditView
    
    var id: Int {
        hashValue
    }
}
