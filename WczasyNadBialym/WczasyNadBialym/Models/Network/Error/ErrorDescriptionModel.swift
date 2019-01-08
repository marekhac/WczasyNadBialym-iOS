//
//  ErrorModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 04.10.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

struct ErrorDescriptionModel : Codable {
    
    let description: String
    
    // particularly useful to pass some special information from backend
    // information is stored in the "description" key inside the JSON
    // fe. we can inform user about missed or wrong AppID
    
    static func unwrapFrom(_ jsonData : Data) -> Bool {
        
        var error : ErrorDescriptionModel? = nil
        
        let decoder = JSONDecoder()
        
        do {
            error = try decoder.decode(ErrorDescriptionModel.self, from: jsonData)
        } catch {
            return false
        }
        
        LogEventHandler.report(LogEventType.info, "MESSAGE FROM BACKEND", error!.description)
        return true
    }
}
