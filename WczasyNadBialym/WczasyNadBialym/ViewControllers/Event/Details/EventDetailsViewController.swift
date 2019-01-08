//
//  EventDetailsViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 11.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var medmageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var mainView: UIView!
    
    var selectedEventId : String = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        self.view.addBlurSubview(below: contentView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.sharedInstance().getEventDetails(selectedEventId) { (details, error) in
            self.medmageView.downloadImageAsyncAndReturnImage(details.imgMedURL) { (resultImage, error) in
               self.backgroundImageView.image = resultImage
            }
            
            DispatchQueue.main.async {
                self.name.text = details.name.uppercased()
                self.place.text = details.place.uppercased()
                self.startDate.text = details.date.getDate() + ", godz. " + details.date.getHourAndMinutes()
                
                // remove all html tags
                
                let detailsStripped = details.description.removeHTMLTags()
                
                self.descriptionTextView.text = detailsStripped
            }
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
