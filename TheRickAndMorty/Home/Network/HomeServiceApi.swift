//
//  HomeServiceApi.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 10/07/22.
//

import Foundation

class HomeServiceApi: NetworkManager {
    
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
}
