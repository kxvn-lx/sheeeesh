//
//  SafariView.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 5/4/21.
//

import UIKit
import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    @Binding var urlString: String

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let url = URL(string: urlString)!
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        return SFSafariViewController(url: url, configuration: config)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) { }
    
    

}
