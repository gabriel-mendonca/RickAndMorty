//
//  EndPointType.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 08/11/22.
//

import Foundation


protocol EndPointType {
    associatedtype GenericCodable: Codable
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask<GenericCodable>? { get }
    var headers: HTTPHeaders? { get }
}

