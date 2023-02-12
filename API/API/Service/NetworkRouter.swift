//
//  NetworkRouter.swift
//  API
//
//  Created by James Beattie on 07/06/2020.
//  Copyright © 2020 James Beattie. All rights reserved.
//

import Foundation
import Combine

protocol NetworkRouter: class {
    associatedtype Endpoint: EndpointType
    
    typealias Completion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()
    
    func request<Value: Codable>(_ route: Endpoint) -> AnyPublisher<Value, Error>
}
