//
//  AccommodationListCell.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 14.09.2016.
//  Copyright © 2016 Marek Hać. All rights reserved.
//

import UIKit

class AccommodationListCell: UITableViewCell {

    @IBOutlet weak var imageMini: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var accommodationId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }    
}
