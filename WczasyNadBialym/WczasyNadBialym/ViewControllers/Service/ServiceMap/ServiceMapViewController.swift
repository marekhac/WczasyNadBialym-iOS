//
//  ServiceMapViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 10.11.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit
import MapKit

class ServiceMapViewController: UIViewController, MKMapViewDelegate {
    
    var gpsLat: Double = 0.0
    var gpsLng: Double = 0.0
    var pinTitle: String = ""
    var pinSubtitle: String = ""
    let mapType: MKMapType = MKMapType.hybridFlyover
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.fillMap(self.gpsLat, self.gpsLng, self.pinTitle, self.pinSubtitle, mapType)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

