//
//  Data+ParseData.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 06.12.2018.
//  Copyright © 2018 Marek Hać. All rights reserved.
//

import Foundation

extension Data {

    typealias ParseMethod = (_ downloadedData : Data) -> Any?
    
    func parseData(using parseMethod : ParseMethod) -> AnyObject? {
        
        let result = parseMethod(self)
        if result != nil {
            return result as AnyObject?
        }
        
        return nil
    }
}
