//
//  NetworkController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 20/05/2020.
//  Copyright © 2020 Marek Hać. All rights reserved.
//

import Foundation

public protocol NetworkProtocol {

    typealias completeClousure = (Result<Data, Error>) -> Void
    
    func downloadContent(with request: URLRequest, completionHandlerForDownloadData: @escaping completeClousure)
    func buildURLFromParameters(_ controller: String, _ method: String, _ parameters: [String:String], _ datatype : DownloadedDataType) -> URL
}
