//
//  InfoCategoriesCell.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 16.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit

class InfoCategoriesCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    var selectedCategory : InfoCategoriesEnum = .lake // default
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
