//
//  HomeServiceApi.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 10/07/22.
//

import Foundation

class HomeServiceApi: Requester {
    
    func getCharactersList(page: Int,onSuccess: @escaping CompletionWithSuccess<Character>, onFailure: @escaping CompletionWithFailure) {
        let header = HeaderHandler().generate(header: .basic)
        let url = urlComposer(using: Endpoint.character, complement: "?page=\(page)")
        let request = requestComposer(using: url, headers: header)
        dataTask(using: request) { (info: Character, response) in
            onSuccess(info)
        } failure: { (error) in
            onFailure(error)
        }
        
    }
}
