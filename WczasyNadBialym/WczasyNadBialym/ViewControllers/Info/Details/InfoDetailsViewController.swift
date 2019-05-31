//
//  InfoDetailsViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 22.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class InfoDetailsViewController: UIViewController, WKNavigationDelegate {

    var category : InfoCategoriesEnum = .lake // default
 
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        self.webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        SVProgressHUD.show()

        self.webView.isHidden = true

        // blur background
        
        self.view.addBlurSubview(style: .light, tag: .loading)
        
        let url = Info.url[category]!
        
        switch category {
        case .lake:
            self.navigationItem.title = "O Jeziorze Białym"
        case .essentials:
            self.navigationItem.title = "Warto wiedzieć"
        case .contact:
            self.navigationItem.title = "Kontakt z nami"
        }
        
        NetworkManager.sharedInstance().downloadTextAsync(url) { (dataString, error) in
            DispatchQueue.main.async() {

                if let resourcePath = Bundle.main.resourcePath {
                    let url = URL.init(fileURLWithPath: resourcePath)
                    self.webView.loadHTMLString(dataString as String, baseURL: url)
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        self.view.removeBlurSubviewForTag(.loading)
        SVProgressHUD.dismiss()
        self.webView.isHidden = false
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        let app = UIApplication.shared
        if let url = navigationAction.request.url {
            if url.scheme == "mailto" {
                if app.canOpenURL(url) {
                    app.openURL(url)
                }
                
                decisionHandler(.cancel)
                return
            }
        }
        
        decisionHandler(.allow)
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
