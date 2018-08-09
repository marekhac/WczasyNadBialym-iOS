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

class ServiceDetailsViewController: UIViewController {

    let backgroundImageName = "background_gradient2"

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
    @IBOutlet weak var scrollView: UIScrollView!
    
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
                    
                    DispatchQueue.main.async() {
                        self.nameLabel.text = serviceDetailsModel.name
                        self.streetLabel.text = serviceDetailsModel.street
                        self.cityLabel.text = serviceDetailsModel.city
                        self.phoneLabel.text = serviceDetailsModel.phone
                        
                        // remove all html tags
                        
                        let detailsStripped = serviceDetailsModel.description.removeHTMLTags()
                        
                        self.descriptionTextView.text = detailsStripped
                    }
                    
                    // assign mini image if present
                    
                    self.imageView.downloadImageAsync(serviceDetailsModel.miniImgURL)
                    
                    // map generator
                    
                    DispatchQueue.main.async() {
                        self.mapView.fillMap(serviceDetailsModel.gpsLat, serviceDetailsModel.gpsLng,
                                             serviceDetailsModel.name, serviceDetailsModel.phone, self.mapType)
                        
                        SVProgressHUD.dismiss()
                        self.scrollView.isHidden = false
                    }
                }
                else {
                    DispatchQueue.main.async() {
                        self.view.addBlurSubview(style: .light, animation: .curveLinear)
                    }
                }
            }
        }

        viewModel.fetchServiceDetails(for: selectedServiceId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // hide everything while loading
        
        self.scrollView.isHidden = true
        
        // add background and blur for content view
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: backgroundImageName)!)
        self.view.addBlurSubview(at: 0)

        // setup with default images
        
        let serviceImage = UIImage(named: self.selectedServiceType + ".png")
        self.imageView.image = serviceImage
        
        SVProgressHUD.show()
        
        initViewModel()
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
