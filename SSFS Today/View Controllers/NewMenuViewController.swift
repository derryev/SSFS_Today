//
//  NewMenuViewController.swift
//  SSFS Today
//
//  Created by Eva Derryberry on 5/16/24.
//  Copyright © 2024 Brian Wilkinson. All rights reserved.
//

import Foundation

import UIKit
import WebKit

class NewMenuViewController: UIViewController, WKNavigationDelegate {
    
    
    @IBOutlet weak var webViewContainerMenu: WKWebView!
    //var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: webViewContainerMenu.bounds, configuration: WKWebViewConfiguration())
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        self.webViewContainerMenu.addSubview(webView)
        let myURL = URL(string: "https://docs.google.com/document/d/1j9nNBjXAaA5x5gVK87USDUYN9D35N0qIzg-qIzeIZpQ/edit?usp=sharing")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func returnToMainView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

