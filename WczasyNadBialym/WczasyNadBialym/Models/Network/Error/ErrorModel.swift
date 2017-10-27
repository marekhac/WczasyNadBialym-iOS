//
//  ErrorModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 04.10.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

struct ErrorModel : Codable {
    
    let description: String
    
    static func unwrapFrom(_ jsonData : Data) -> Bool {
        
        var error : ErrorModel? = nil
        
        let decoder = JSONDecoder()
        
        do {
            error = try decoder.decode(ErrorModel.self, from: jsonData)
        } catch {
            return false
        }
        
        ErrorHandler.report("MESSAGE FROM BACKEND", error!.description)
        return true
    }
}
