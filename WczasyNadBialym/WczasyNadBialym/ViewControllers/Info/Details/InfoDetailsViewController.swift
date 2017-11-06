//
//  InfoDetailsViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 22.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit

class InfoDetailsViewController: UIViewController, UIWebViewDelegate {

    var category : InfoCategoriesEnum = .lake // default
 
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.addBlurSubview(below: contentTextView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Info.url[category]!
        
        switch category {
            case .lake:
                self.navigationItem.title = "O Jeziorze Białym"
            case .essentials:
                self.navigationItem.title = "Warto wiedzieć"
        }
        
        NetworkManager.sharedInstance().downloadTextAsync(url) { (dataString, error) in
            DispatchQueue.main.async() {
                self.contentTextView.text = dataString as String!
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
