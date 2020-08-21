//
//  YFWebViewScreen.swift
//  YogiFi
//
//  Created by NFCIndia on 19/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class YFWebViewScreen: UIViewController {
       var webView: WKWebView!
        var url: URL?
        override func loadView() {
            super.loadView()
            webView = WKWebView()
            webView.navigationDelegate = self
            view = webView
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            if let url = url {
                webView.load(URLRequest(url: url))
                webView.allowsBackForwardNavigationGestures = true
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }

    extension YFWebViewScreen: WKNavigationDelegate {
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            YFLoadingIndicator.show(view: self.view)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            YFLoadingIndicator.hide(view: self.view)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            YFLoadingIndicator.hide(view: self.view)
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated {
                guard let url = navigationAction.request.url else {
                    decisionHandler(.allow)
                    return
                }
                let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                if components?.scheme == "http" || components?.scheme == "https" {
                    UIApplication.shared.open(url)
                    decisionHandler(.cancel)
                } else {
                    decisionHandler(.allow)
                }
            } else {
                decisionHandler(.allow)
            }
        }
}
