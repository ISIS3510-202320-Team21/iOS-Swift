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
        case decodingFailed
        case encodingFailed
        case noData
        case invalidResponse
        case HTTPError(Int, String)
        case undefined
    }
    
    struct ErrorResponse: Decodable {
        let detail: String
    }
    
    func request(method: HTTPMethod, resource: String, body: Data? = nil, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: "http://172.20.10.4:8000/\(resource)/") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
                
        // Add request body for POST and PUT requests
        if let body = body {
            request.httpBody = body
        }
        
        // Header of body type
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.undefined))
                return
            }
                    
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            let statusCode = httpResponse.statusCode
                       
            guard let responseData = data else {
                completion(.failure(NetworkError.noData))
                return
            }
                       
            if !(200...299).contains(statusCode) {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: responseData)
                    completion(.failure(NetworkError.HTTPError(statusCode, errorResponse.detail)))
                } catch {
                    completion(.failure(NetworkError.decodingFailed))
                }
            } else {
                completion(.success(responseData))
            }
        }.resume()
    }
}
