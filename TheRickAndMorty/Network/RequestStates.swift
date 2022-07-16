//
//  RequestStates.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 12/07/22.
//

import Foundation

enum RequestStates<T> {
    case loading
    case errored(error: ErrorHandler.ErrorResponse)
    case load(data: T)
    case empty
}

