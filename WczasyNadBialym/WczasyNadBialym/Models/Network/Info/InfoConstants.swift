//
//  InfoConstants.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 25.10.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

struct Info {
    struct Path {
        
        static let about = "../mobile/lake.html"
        static let essentials = "../mobile/essentials.html"
        static let contact = "../mobile/contact.html"
    }
    
    static let url : [InfoCategoriesEnum : String] = [.lake : Info.Path.about,
                                                      .essentials : Info.Path.essentials,
                                                      .contact : Info.Path.contact]
}
