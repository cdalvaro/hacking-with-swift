//
//  DetailViewController.swift
//  Milestone-Projects13_15
//
//  Created by Carlos David on 16/08/2020.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var country: String!
    var populations: [Country]?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let populations = populations else { return }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        title = country
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let body = populations.map({ "<p><b>Year</b> \($0.year): \(formatter.string(for: $0.value)!)</p>" }).joined(separator: "")
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }

}
