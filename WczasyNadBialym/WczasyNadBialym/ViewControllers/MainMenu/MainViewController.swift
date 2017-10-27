//
//  MainViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 25.01.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  self.tabBarController?.tabBar.isHidden = true;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func accommodationTypesAction(_ sender: Any) {
        
        print("AccommodationTypesAction");
        self.tabBarController?.selectedIndex = 2
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        
        if segue.identifier == "AccommodationTypesSegue"  {

            print("AccommodationTypesSegue")
            //(segue.destination as! AppTabBarController).selectedIndex = 1
            (segue.destination as! AppTabBarController).selectedIndex = 1
        }
        
        if segue.identifier == "InformationsSegue"  {
                    
            print("InformationsSegue")
            (segue.destination as! AppTabBarController).selectedIndex = 0
        }
        */
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
