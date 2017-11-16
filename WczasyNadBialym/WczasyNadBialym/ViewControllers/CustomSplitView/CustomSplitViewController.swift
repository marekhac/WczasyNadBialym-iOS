//
//  CustomSplitViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 07.03.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit

class CustomSplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // to always show master view in portrait mode
        // we call it here to avoid "unbalanced calls to begin/end appearance transitions" errors
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            preferredDisplayMode = .primaryOverlay
        }
    }
    
    // THIS IS VERY IMPORTANT: This way detail view will not cover master view!
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        return true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
