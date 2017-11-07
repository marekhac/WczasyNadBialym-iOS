//
//  MainViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 25.01.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBlurSubview(at: 1)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    // MARK: - Actions
    
    
    @IBAction func eventsAction(_ sender: UIButton) {
       self.tabBarController?.selectedIndex = MenuTabsEnum.events.rawValue
    }
    
    @IBAction func servicesAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = MenuTabsEnum.services.rawValue
    }
    
    @IBAction func informationsAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = MenuTabsEnum.informations.rawValue
    }
    
    @IBAction func accommodationTypesAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = MenuTabsEnum.accommodations.rawValue
    }
}
