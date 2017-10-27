//
//  AccommodationGalleryContentViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 11.04.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit

class AccommodationGalleryContentViewController: UIViewController {

    var pageIndex: Int = 0
    var pictureURL: String!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.imageView.downloadImageAsync(pictureURL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
