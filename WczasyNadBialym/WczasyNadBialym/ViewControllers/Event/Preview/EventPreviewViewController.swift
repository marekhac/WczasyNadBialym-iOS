//
//  EventPreviewViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 11.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit
import SVProgressHUD
import GoogleMobileAds

class EventPreviewViewController: UIViewController {
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var bannerViewHeightConstraint: NSLayoutConstraint!
    
    private lazy var networkController = NetworkController(session: URLSession.shared)
    var adHandler : AdvertisementHandler?
    var backgroundImage : UIImage?
    var descriptionText: String?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var fillImageView: UIImageView!
  
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var mainView: UIView!
    
    var selectedEventId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the recognizer to the view.
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        self.fillImageView.addGestureRecognizer(tapRecognizer)
        
        SVProgressHUD.show()
        
        // blur main screen while loading the content
        
        self.view.addBlurSubview (style: .light, tag: .loading)
        
        // setup background
        
        if let backgroundImage = backgroundImage {
            self.backgroundImageView.image = backgroundImage
            self.view.addBlurSubview(below: contentView)
        }
        
        networkController.getEventDetails(selectedEventId) { (details) in
            
            if let details = details {
               
                // download image
                
                self.fillImageView.downloadImageAsync(details.imgFullURL)
                
                // update ui with content
                
                DispatchQueue.main.async {
                    self.name.text = details.name.uppercased()
                    self.place.text = details.place.uppercased()
                    self.startDate.text = details.date.getDate() + ", godz. " + details.date.getHourAndMinutes()
                    
                    // remove all html tags in description
                    
                    self.descriptionText = details.description.removeHTMLTags()
                }
            }
            else {
                LogEventHandler.report(LogEventType.debug, "No Event Details to show")
            }
            
            SVProgressHUD.dismiss()
            
            // remove blured loading view
            DispatchQueue.main.async {
                self.view.removeBlurSubviewForTag(.loading);
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        displayAdvertisementBanner()
    }
    
    @objc func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        if let eventShowPosterViewController = UIStoryboard(name: "EventStoryboard", bundle: nil).instantiateViewController(withIdentifier: "Poster") as? EventShowPosterViewController {
            
            eventShowPosterViewController.posterImage = self.fillImageView.image
            eventShowPosterViewController.backgroundImage = self.backgroundImageView.image
                        
            if let navigator = navigationController {
                navigator.pushViewController(eventShowPosterViewController, animated: true)
            }
        }
    }
    
    // MARK: - Request for advertisement
    
    func displayAdvertisementBanner() {
        self.adHandler = AdvertisementHandler(bannerAdView: self.bannerView)
        if let adHandler = self.adHandler {
            adHandler.adViewHeightConstraint = self.bannerViewHeightConstraint
            adHandler.showAd(viewController: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showEventDetails" {
                let controller = segue.destination as! EventDetailsViewController
                controller.nameText = self.name.text
                controller.descriptionText = self.descriptionText;
                
                if let backgroundImage = backgroundImage {
                    controller.backgroundImage = backgroundImage;
                }
            }
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
