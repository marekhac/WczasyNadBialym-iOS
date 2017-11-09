//
//  ServiceDetailsViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 05.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit

class ServiceDetailsViewController: UIViewController {

    var selectedServiceId: String = ""
    var selectedServiceType: String = ""
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
