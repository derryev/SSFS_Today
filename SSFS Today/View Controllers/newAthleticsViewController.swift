//
//  NewAthleticsViewController.swift
//  SSFS Today
//
//  Created by Eva Derryberry on 5/20/24.
//  Copyright © 2024 Brian Wilkinson. All rights reserved.
//

import Foundation


import UIKit
import WebKit

class NewAthleticsViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webViewContainerAthletics: WKWebView!
    //var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: webViewContainerAthletics.bounds, configuration: WKWebViewConfiguration())
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        self.webViewContainerAthletics.addSubview(webView)
        let myURL = URL(string: "https://www.instagram.com/ssfs_athletics?igsh=d2tteHV0djd4ZjIw")
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

    
    
    

