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

class InfoDetailsViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    var category : InfoCategoriesEnum = .lake // default
    private lazy var networkController = NetworkController(session: URLSession.shared)
    
    @IBOutlet weak var backgroundView: UIView!
    
    // webView added programmatically to workaround XCode bug:
    // WKWebView before iOS 11.0 (NSCoding support was broken in previous versions)
    // https://stackoverflow.com/questions/46221577/xcode-9-gm-wkwebview-nscoding-support-was-broken-in-previous-versions
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        // setup transparent background
        
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        return webView
    }()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        self.view.addSubview(self.webView)
                
        NSLayoutConstraint.activate([
            self.webView.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor),
            self.webView.topAnchor.constraint(equalTo: self.backgroundView.topAnchor),
            self.webView.rightAnchor.constraint(equalTo: self.backgroundView.rightAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor)])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        SVProgressHUD.show()

        self.webView.isHidden = true

        // blur background
        
        self.view.addBlurSubview(at: 1)
        
        // add blured loading view layer
        
        self.view.addBlurSubview(style: .light, tag: .loading)
        
        let url = API.Info.url[category]!
        
        switch category {
        case .lake:
            self.navigationItem.title = "O Jeziorze Białym"
        case .essentials:
            self.navigationItem.title = "Warto wiedzieć"
        case .contact:
            self.navigationItem.title = "Kontakt z nami"
        }
        
        networkController.downloadTextAsync(url) {  (dataString, error) in
            self.updateWebViewWithContent(dataString as String)
        }
    }
    
    func updateWebViewWithContent(_ content: String) {
        DispatchQueue.main.async() {
            if let resourcePath = Bundle.main.resourcePath {
                let url = URL.init(fileURLWithPath: resourcePath)
                self.webView.loadHTMLString(content as String, baseURL: url)
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
