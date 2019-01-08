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
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        self.setupCurrentTemperature()
    }
    
    func setupCurrentTemperature() {
        NetworkManager.sharedInstance().getCurrentMeasurement() { (weather, error) in
            
            let currentTemperature = weather.temp.rounded()
            LogEventHandler.report(LogEventType.info, "Current temperature: \(currentTemperature)");
            
            DispatchQueue.main.async {
                self.temperatureLabel.text = String(currentTemperature) + " °C"
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBlurSubview(at: 1)
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
