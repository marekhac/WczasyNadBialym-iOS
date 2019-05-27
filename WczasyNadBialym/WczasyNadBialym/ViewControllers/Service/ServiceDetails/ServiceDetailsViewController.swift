//
//  ServiceDetailsViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 05.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD
import GoogleMobileAds
import WebKit

class ServiceDetailsViewController: UIViewController {
    
    var adHandler : AdvertisementHandler?
    let backgroundImageName = "background_gradient2"
    var backgroundImage : UIImage?
    var selectedServiceId: String = ""
    var selectedServiceType: String = ""
    let mapType = MKMapType.standard
    var gpsLat: Double = 0.0
    var gpsLng: Double = 0.0
    var pinTitle: String = ""
    var pinSubtitle: String = ""

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var phoneTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    lazy var viewModel: ServiceDetailsViewModel = {
        return ServiceDetailsViewModel()
    }()
    
    // init view model
    
    func initViewModel () {
        
        viewModel.updateViewClosure = {
            DispatchQueue.main.async {
                
                let serviceDetailsModel = self.viewModel.getServiceDetailsModel()
                
                if let serviceDetailsModel = serviceDetailsModel {
                    
                    self.gpsLat = serviceDetailsModel.gpsLat
                    self.gpsLng = serviceDetailsModel.gpsLng
                    self.pinTitle = serviceDetailsModel.name
                    self.pinSubtitle = serviceDetailsModel.phone
                    
                    // update ui
                    
                    self.nameLabel.text = serviceDetailsModel.name
                    
                    // create address by join street and city
                    
                    var address = serviceDetailsModel.street
                    
                    if (!address.isEmpty) {
                        address = address + ", "
                    }
                    
                    address = address + serviceDetailsModel.city
                    self.addressLabel.text = address
                    
                    var phoneNumber = serviceDetailsModel.phone
                    
                    // add "tel." prefix to phone number (if it's not already present)
                    
                    if (!phoneNumber.isEmpty) {
                        if (!phoneNumber.contains("tel")) {
                            phoneNumber = "tel. " + phoneNumber
                        }
                    }
                    
                    self.phoneTextView.text = phoneNumber
                    
                    // remove all html tags
                    
                    let detailsStripped = serviceDetailsModel.description.removeHTMLTags()
                    self.descriptionTextView.text = detailsStripped
                    
                    // assign med image if present
                    
                    self.imageView.downloadImageAsync(serviceDetailsModel.medImgURL)
             
                    SVProgressHUD.dismiss()
                    
                    // remove blured loading view
                    
                    if let viewWithLoadingTag = self.view.viewWithTag(ViewTag.loading.rawValue) {
                        viewWithLoadingTag.removeFromSuperview()
                    }
                }
            }
        }
        self.viewModel.fetchServiceDetails(for: selectedServiceId)
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // blur background
        
        self.view.addBlurSubview(at: 1, style: UIBlurEffect.Style.light)
        
        // setup background
        
        if let backgroundImage = backgroundImage {
            self.backgroundImageView.image = backgroundImage
        }
        
        // blur main screen while loading the content
        
        self.view.addBlurSubview (style: UIBlurEffect.Style.light, tag: ViewTag.loading)
        
        // setup with default images
        
        let serviceImage = UIImage(named: self.selectedServiceType + ".png")
        self.imageView.image = serviceImage
        
        SVProgressHUD.show()
        
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        displayAdvertisementBanner()
    }
    
    // MARK: - Request for advertisement
    
    func displayAdvertisementBanner() {
        self.adHandler = AdvertisementHandler(bannerAdView: self.bannerView)
        if let adHandler = self.adHandler {
            adHandler.showAd(viewController: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showServiceMap" {
            let controller = segue.destination as! ServiceMapViewController
            controller.gpsLat = self.gpsLat
            controller.gpsLng = self.gpsLng
            controller.pinTitle = self.pinTitle
            controller.pinSubtitle = self.pinSubtitle
        }
    }
}
