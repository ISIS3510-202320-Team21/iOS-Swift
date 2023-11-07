//
//  WeatherService.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 4/11/23.
//

import Foundation

struct WeatherResponse: Codable {
    let main: WeatherMain
    let weather: [WeatherDescription]
    let sys: WeatherSys
    let name: String
}

struct WeatherMain: Codable {
    let temp: Double
}

struct WeatherDescription: Codable {
    let description: String
}

struct WeatherSys: Codable {
    let country: String
}

class WeatherService {
    private let apiKey = "73f9d4b9bbff2c9c3bbf531e06f1fd1f"
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let urlString = "\(baseUrl)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data {
                    do {
                        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                        completion(.success(weatherResponse))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
        } else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}
