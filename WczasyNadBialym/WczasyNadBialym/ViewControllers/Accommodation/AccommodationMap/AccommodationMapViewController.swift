//
//  AccommodationMapViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 08.04.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit
import MapKit
import GoogleMobileAds

class AccommodationMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var bannerView: GADBannerView!
    var adHandler : AdvertisementHandler?
    
    var gpsLat: Double = 0.0
    var gpsLng: Double = 0.0
    var pinTitle: String = ""
    var pinSubtitle: String = ""
    let mapType: MKMapType = MKMapType.hybridFlyover
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.fillMap(self.gpsLat, self.gpsLng, self.pinTitle, self.pinSubtitle, mapType)
        
        // Do any additional setup after loading the view.
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
}
