//
//  EventShowPosterViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 29/05/2019.
//  Copyright © 2019 Marek Hać. All rights reserved.
//

import UIKit
import SVProgressHUD

class EventShowPosterViewController: UIViewController {
    
    var posterImage : UIImage?
    var backgroundImage : UIImage?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // blur main screen while loading the content
        
        self.backgroundImageView.addBlurSubview (style: .light, tag: .loading)
        
        if let backgroundImage = backgroundImage {
            self.backgroundImageView.image = backgroundImage
        }
        
        posterImageView.image = posterImage
    }
}
