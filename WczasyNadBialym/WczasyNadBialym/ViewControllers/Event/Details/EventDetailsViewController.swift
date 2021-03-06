//
//  EventDetailsViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 24/05/2019.
//  Copyright © 2019 Marek Hać. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class EventDetailsViewController: UIViewController {
   
    var nameText : String?
    var descriptionText: String?
    var backgroundImage : UIImage?
    var adHandler : AdvertisementHandler?
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var bannerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayAdvertisementBanner()
        
        // add blur layer over background
        self.view.addBlurSubview(below: contentView)
        
        // setup background with real service image (if exists)
        
        if let backgroundImage = backgroundImage {
            self.backgroundImageView.image = backgroundImage
        }
        
        self.nameLabel.text = self.nameText
        self.descriptionTextView.text = self.descriptionText
    }
    
    // MARK: - Request for advertisement
    
    func displayAdvertisementBanner() {
        self.adHandler = AdvertisementHandler(bannerAdView: self.bannerView)
        if let adHandler = self.adHandler {
            adHandler.adViewHeightConstraint = self.bannerViewHeightConstraint
            adHandler.showAd(viewController: self)
        }
    }
}
