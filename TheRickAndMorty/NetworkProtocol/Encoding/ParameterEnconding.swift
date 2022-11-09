//
//  ParameterEnconding.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 08/11/22.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterURLEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public protocol ParameterHTTPBodyEncoder {
    static func encode<T: Codable>(urlRequest: inout URLRequest, with parameters: T) throws
}

public enum NetworkEnconderError: String, Error {
    case parametersNil = "Parameters were nil"
    case encondingFailed = "Parameters encoding failed"
    case missingURL = "URL is nil"
}

