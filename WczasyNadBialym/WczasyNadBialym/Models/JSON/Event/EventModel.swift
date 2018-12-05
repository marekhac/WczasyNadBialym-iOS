//
//  EventModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 26.11.2018.
//  Copyright © 2018 Marek Hać. All rights reserved.
//

import Foundation

struct EventModel : Codable {
    let id : Int
    let name : String
    let place : String
    let date : Date
    let timestamp : Int32
    let imgMedURL : String
    let imgFullURL : String
}
