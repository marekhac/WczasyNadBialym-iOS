//
//  AdvertisementHandler.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 03/04/2019.
//  Copyright © 2019 Marek Hać. All rights reserved.
//

import Foundation
import GoogleMobileAds

class AdvertisementHandler : NSObject, GADBannerViewDelegate {
    
    var adView : GADBannerView
    var adDelegate : AnyObject & GADBannerViewDelegate {
        get {
            return self.adView.delegate!
        }
        set {            
            self.adView.delegate = newValue
        }
    }
    
    init(bannerAdView: GADBannerView) {
        
        self.adView = bannerAdView
        
        super.init()
        
        let adUnitId = Environment().config(PlistKey.AdUnitId)
        
        self.adView.adUnitID = adUnitId
       
        // you can set your own viewController to "catch" GADBannerViewDelegate callback methods
        // use: "adHandler.adDelegate = self" before calling "showAd"
        
        self.adView.delegate = self
    }
    
    func showAd(viewController: UIViewController) {
        
        self.adView.rootViewController = viewController
        
        let request = GADRequest()
        
        // Remove the following line before the app upload
       
        request.testDevices = [ kGADSimulatorID ];

        self.adView.load(request)
    }
    
    // If you not set adDelegate, GADBannerViewDelegate methods will be handled here
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        LogEventHandler.report(LogEventType.debug, "AdvertisementHandler: AdMob ad loaded successfully")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        LogEventHandler.report(LogEventType.debug, "AdvertisementHandler: Failed to receive AdMob ad")
    }
}

