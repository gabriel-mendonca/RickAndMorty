//
//  RickAndMortyDetailsNetwork.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 23/08/22.
//

import Foundation

enum ResultDetail {
    case success(data: DetailsModel)
    case failure(error: String?)
}

enum APIDetailsEndPoints {
    case character(id: Int)
}

extension APIDetailsEndPoints: EndPointType {
    
    var baseURL: URL {
        let url = BaseURL().baseURL
        return URL(string: url)!
    }
    
    var path: String {
        switch self {
        case .character(let id):
            return "character/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    
    var task: HTTPTask<Int>? {
        nil
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
}

class RickAndMortyDetailsNetwork: NetworkManager {
    private let router = Router<APIDetailsEndPoints>()
    
    func getDetails(id: Int, completion: @escaping (_ result: ResultDetail) -> Void) {
        router.request(.character(id: id)) { data, response, error in
            if error != nil {
                completion(.failure(error: "Please check your network connection"))
            }
            
            if let data = data {
                do {
                    let detail = try JSONDecoder().decode(DetailsModel.self, from: data)
                    completion(.success(data: detail))
                } catch {
                    completion(.failure(error: NetworkResponse.unableToDecode.rawValue))
                }
            }
        }
    }
}
