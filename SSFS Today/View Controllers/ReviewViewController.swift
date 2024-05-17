//
//  ReviewViewController.swift
//  SSFS Today
//
//  Created by Eva Derryberry on 5/16/24.
//  Copyright © 2024 Brian Wilkinson. All rights reserved.
//

import Foundation



import UIKit
import WebKit

class ReviewViewController: UIViewController, WKNavigationDelegate {
    
    
    @IBOutlet weak var webViewContainerReview: WKWebView!
    //var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: webViewContainerReview.bounds, configuration: WKWebViewConfiguration())
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        self.webViewContainerReview.addSubview(webView)
        let myURL = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfz3rVOOGHBDmrAEx2Z3KRmmrMJGQvQm7V-L6_rIFZWg5GkhA/viewform")
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
