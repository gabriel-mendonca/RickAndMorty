//
//  HTTPTask.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 08/11/22.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask<T: Codable> {
    case request
    case requestParameters(urlParameters: Parameters?)
    case requestPatametersAndHeaders(urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}

