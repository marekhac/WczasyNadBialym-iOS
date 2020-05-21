//
//  URLSession+DataTask.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 20/05/2020.
//  Copyright © 2020 Marek Hać. All rights reserved.
//

import Foundation

extension URLSession: URLSessionProtocol {
    
    // add dataTask method that return URLSessionDataTaskProtocol
    // no changes in dataTask behavior, just convertion of returning type
    
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
    // has the exact protocol method, resume(), so nothing happens
}
