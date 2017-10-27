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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()     
    
        let url = Info.url[category]!
        
        NetworkManager.sharedInstance().downloadTextAsync(url) { (dataString, error) in
            
            DispatchQueue.main.async() {
                self.contentTextView.text = dataString as String!
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
