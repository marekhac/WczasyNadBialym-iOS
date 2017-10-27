//
//  MKMapView+FillTheMap.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 08.04.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {

    func fillMap(_ lat: Double, _ lng: Double, _ title: String, _ subtitle: String, _ mapType: MKMapType) {
    
    // generate map
    
    let latitude: CLLocationDegrees = lat
    let longitude: CLLocationDegrees = lng
    let latDelta: CLLocationDegrees = 0.02
    let lonDelta: CLLocationDegrees = 0.02
    let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
    let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
    
    let annotation = MKPointAnnotation()
    annotation.title = title
    annotation.subtitle = subtitle
    annotation.coordinate = location
    
    self.setRegion(region, animated: false)
    self.addAnnotation(annotation)
    self.mapType = mapType
    }
}
