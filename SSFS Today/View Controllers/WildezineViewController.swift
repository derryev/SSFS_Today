//
//  WildezineViewController.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/14/17 on behalf of Sandy Spring Friends School
//  Copyright © 2017 SSFS. All rights reserved.
//
//

import UIKit
import WebKit

class WildezineViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var activtyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webViewContainer: UIView!
    //var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: webViewContainer.bounds, configuration: WKWebViewConfiguration())
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        activtyIndicator.hidesWhenStopped = true
        self.webViewContainer.addSubview(webView)
        self.webViewContainer.addSubview(activtyIndicator)
        
        let myURL = URL(string: "https://wildezine.com/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
    
    func showActivityIndicator(show: Bool) {
        if show {
            activtyIndicator.startAnimating()
        } else {
            activtyIndicator.stopAnimating()
        }
        
    }
    
    @IBAction func returnToMainView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
