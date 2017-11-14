//
//  String+RemoveHTMLTags.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 14.11.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension String {
    func removeHTMLTags() -> String {
         return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
}
