//
//  URLSessionProtocol.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 13/08/2019.
//  Copyright © 2019 Marek Hać. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}
