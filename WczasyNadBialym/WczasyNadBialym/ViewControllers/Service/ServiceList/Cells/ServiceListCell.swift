//
//  ServiceListCell.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 05.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit

class ServiceListCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageMini: UIImageView!
    
    var serviceId: Int?
    var realServiceImage: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
