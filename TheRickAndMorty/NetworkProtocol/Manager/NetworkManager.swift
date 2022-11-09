//
//  NetworkManager.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 08/11/22.
//

import Foundation

class NetworkManager {
    
    enum NetworkResponse: String {
        case success
        case authenticationError = "you need to be authentication first"
        case badRequest = "Bad Request"
        case outDated = "The url you requested is outdated"
        case failed = "Network Request Failed"
        case noData = "Response return with no Data to decode"
        case unableToDecode = "we could not decode the response"
    }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResponse {
        print("\n↙️ ======= RESPONSE =======")
        switch response.statusCode {
        case 200...202:
            print("↙️ CODE: \(response.statusCode) - ✅")
            return .success
        case 400...505:
            print("↙️ CODE: \(response.statusCode) - ❌")
            return .authenticationError
        case 505...599:
            print("↙️ CODE: \(response.statusCode) - ⚠️")
            return .badRequest
        case 600:
            print("↙️ CODE: \(response.statusCode) - 🆘")
            return .outDated
        default:
            print("↙️ CODE: \(response.statusCode) - ⛔️")
            return .failed
        }
    }
}

