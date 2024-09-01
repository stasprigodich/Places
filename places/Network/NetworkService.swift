//
//  NetworkService.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import Foundation

// MARK: - Protocol

protocol NetworkServiceProtocol {
    func performRequest(_ request: NetworkRequest) async throws -> Data
}

// MARK: - Implementation

final class NetworkService: NetworkServiceProtocol {

    // MARK: - Internal Methods
    
    func performRequest(_ request: NetworkRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request.urlRequest)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        return data
    }
}

// MARK: - NetworkError

enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case networkFailure
    case invalidURL
}

// MARK: - NetworkRequest

struct NetworkRequest {
    let url: URL
    var method: HTTPMethod = .get
    var headers: [String: String] = [:]
    var body: Data? = nil
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}

// MARK: - HTTPMethod

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
