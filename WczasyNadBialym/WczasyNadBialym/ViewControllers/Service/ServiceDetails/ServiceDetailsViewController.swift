//
//  ServiceDetailsViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 05.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit
import MapKit

class ServiceDetailsViewController: UIViewController {

    var selectedServiceId: String = ""
    var selectedServiceType: String = ""
    let mapType = MKMapType.standard
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup with default images
        
        let serviceImage = UIImage(named: self.selectedServiceType + ".png")
        self.imageView.image = serviceImage
  
        NetworkManager.sharedInstance().getServiceDetails(selectedServiceId) { (service, error) in

            DispatchQueue.main.async() {
                self.nameLabel.text = service.name
                self.streetLabel.text = service.street
                self.cityLabel.text = service.city
                self.phoneLabel.text = service.phone
                
                // remove all html tags
                
                let detailsStripped = service.description.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
                
                self.descriptionTextView.text = detailsStripped
            }
            
            // assign mini image if present
            
            self.imageView.downloadImageAsync(service.miniImgURL)
            
            // map generator
            
            DispatchQueue.main.async() {
                self.mapView.fillMap(service.gpsLat, service.gpsLng, service.name, service.phone, self.mapType)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
