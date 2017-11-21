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
    var gpsLat: Double = 0.0
    var gpsLng: Double = 0.0
    var pinTitle: String = ""
    var pinSubtitle: String = ""
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add background and blur for content view
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient2")!)
        self.view.addBlurSubview(at: 0)

        // setup with default images
        
        let serviceImage = UIImage(named: self.selectedServiceType + ".png")
        self.imageView.image = serviceImage
  
        NetworkManager.sharedInstance().getServiceDetails(selectedServiceId) { (service, error) in
            
            // store gps location
            
            if let service = service {
                
                self.gpsLat = service.gpsLat
                self.gpsLng = service.gpsLng
                self.pinTitle = service.name
                self.pinSubtitle = service.phone
                
                // update ui
                
                DispatchQueue.main.async() {
                    self.nameLabel.text = service.name
                    self.streetLabel.text = service.street
                    self.cityLabel.text = service.city
                    self.phoneLabel.text = service.phone
                    
                    // remove all html tags
                    
                    let detailsStripped = service.description.removeHTMLTags()
                    
                    self.descriptionTextView.text = detailsStripped
                }
                
                // assign mini image if present
                
                self.imageView.downloadImageAsync(service.miniImgURL)
                
                // map generator
                
                DispatchQueue.main.async() {
                    self.mapView.fillMap(service.gpsLat, service.gpsLng, service.name, service.phone, self.mapType)
                }
            }
            else {
                DispatchQueue.main.async() {
                    self.view.addBlurSubview(style: .light, animation: .curveLinear)
                }
            }
        }
        // Do any additional setup after loading the view.
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
