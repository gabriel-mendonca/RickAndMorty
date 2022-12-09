//
//  HomeServiceApi.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 10/07/22.
//

import Foundation

enum Result {
    case success(data: Character)
    case failure(error: String?)
}

enum APIHomeEndPoints {
    case character(page: Int)
    case searchCharacters(name: String)
}

extension APIHomeEndPoints: EndPointType {
    var baseURL: URL {
        let url = BaseURL().baseURL
        return URL(string: url)!
    }
    
    var path: String {
            return "character/"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask<Int>? {
        switch self {
        case .character(let page):
            return .requestParameters(urlParameters: ["page":"\(page)"])
        case .searchCharacters(let name):
            return .requestParameters(urlParameters: ["name":"\(name)"])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

class HomeServiceApi: NetworkManager {
    
    internal let router = Router<APIHomeEndPoints>()
    
    func getCharacter(page: Int,completion: @escaping (_ results: Result) -> Void) {
           router.request(.character(page: page)) { (data, _, error) in
               if error != nil {
                   completion(.failure(error: "Please check your network connection"))
               }
               
               if let data = data {
                   do {
                       let character = try JSONDecoder().decode(Character.self, from: data)
                       completion(.success(data: character))
                   } catch {
                       completion(.failure(error: NetworkResponse.unableToDecode.rawValue))
                   }
                   
               }
           }
       }
    
    func getFilterCharacters(name: String, completion: @escaping (_ results: Result) -> Void) {
        router.request(.searchCharacters(name: name)) { (data, _, error) in
            if error != nil {
                completion(.failure(error: "Please check your network connection"))
            }
            
            if let data = data {
                do {
                    let character = try JSONDecoder().decode(Character.self, from: data)
                    completion(.success(data: character))
                } catch {
                    completion(.failure(error: NetworkResponse.unableToDecode.rawValue))
                }
                
            }
        }
    }
}
