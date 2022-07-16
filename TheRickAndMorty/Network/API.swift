//
//  API.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 26/05/22.
//

import Foundation

class API {
    enum Enviroment: String {
        case baseUrl = "https://rickandmortyapi.com/api"
        
        func getValue() -> String {
            return self.rawValue
        }
    }
    
    let enviroment: Enviroment
    
    init(withEnviroment env: Enviroment? = nil) {
        if let enviroment = env {
            self.enviroment = enviroment
        } else {
            self.enviroment = EnvConfig.url
        }
    }
    
    lazy var homeService = HomeServiceApi(withEnviroment: enviroment)
}
