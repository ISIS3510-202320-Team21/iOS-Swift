//
//  NetworkService.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 27/10/23.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {} // Singleton
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
        case invalidURL
        case noData
        case encodingFailed
        case decodingFailed
        case undefined
    }
    
    func request<T: Decodable>(method: HTTPMethod, resource: String, body: Data? = nil, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/\(resource)") else {
                    completion(.failure(NetworkError.invalidURL))
                    return
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = method.rawValue
                
                // Add request body for POST and PUT requests
                if let body = body {
                    request.httpBody = body
                }
                
                // Perform the network request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        completion(.failure(NetworkError.undefined))
                        return
                    }
                    
                    // Handle response
                    guard let data = data else {
                        completion(.failure(NetworkError.noData))
                        return
                    }
                    
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(NetworkError.decodingFailed))
                    }
                }.resume()
    }
}
