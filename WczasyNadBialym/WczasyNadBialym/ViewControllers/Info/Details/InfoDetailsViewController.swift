//
//  InfoDetailsViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 22.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit
import WebKit

class InfoDetailsViewController: UIViewController {

    var category : InfoCategoriesEnum = .lake // default
 
    @IBOutlet weak var webView: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        let url = Info.url[category]!
        
        switch category {
        case .lake:
            self.navigationItem.title = "O Jeziorze Białym"
        case .essentials:
            self.navigationItem.title = "Warto wiedzieć"
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
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
