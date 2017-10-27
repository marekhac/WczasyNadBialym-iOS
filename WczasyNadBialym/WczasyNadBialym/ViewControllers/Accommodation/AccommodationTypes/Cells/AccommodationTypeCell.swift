//
//  AccomodationCell.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 02.09.2016.
//  Copyright © 2016 Marek Hać. All rights reserved.
//

import UIKit

class AccommodationTypeCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    var shortName: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
