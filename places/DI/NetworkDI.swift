//
//  NetworkDI.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

protocol NetworkDI {
    
    var networkServiceProtocol: NetworkServiceProtocol { get }
}

extension DI: NetworkDI {
    
    static var network: NetworkDI {
        shared()
    }

    var networkServiceProtocol: NetworkServiceProtocol {
        stored(by: #function) {
            NetworkService()
        }
    }
}

