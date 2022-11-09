//
//  NetworkRouter.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 08/11/22.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?,_ error: Error?) -> Void

protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

