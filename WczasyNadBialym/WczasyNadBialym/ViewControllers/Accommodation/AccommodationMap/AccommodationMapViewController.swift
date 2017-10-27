//
//  AccommodationMapViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 08.04.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit
import MapKit

class AccommodationMapViewController: UIViewController, MKMapViewDelegate {

    var gpsLat: Double = 0.0
    var gpsLng: Double = 0.0
    let mapType: MKMapType = MKMapType.hybridFlyover
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.fillMap(self.gpsLat, self.gpsLng, "Title", "Subtitle", mapType)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
