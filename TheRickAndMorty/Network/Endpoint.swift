//
//  Endpoint.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 26/05/22.
//

import Foundation

public class Endpoint {
    typealias EndpointType = (uri: String, method: String)
    
    struct HTTPMethod {
        static let get = "GET"
    }
    
    static let character: EndpointType = (uri: "/character", method: HTTPMethod.get)
}
