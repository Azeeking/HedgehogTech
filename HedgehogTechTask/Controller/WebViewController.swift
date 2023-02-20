//
//  WebViewController.swift
//  HedgehogTechTask
//
//  Created by Azik on 19.02.2023.
//

import Foundation
import UIKit
import WebKit

class WebViewController : UIViewController, WKUIDelegate {
    
    @IBOutlet private weak var webView: WKWebView!
    
    var sourceURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequest()
    }
    
    private func loadRequest() {
        let url = sourceURL
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
}
