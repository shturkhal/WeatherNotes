//  Copyright (c) 2026

import Foundation

enum WeatherServiceError: LocalizedError {
    case invalidURL
    case invalidResponse(statusCode: Int, message: String)
    case emptyWeather
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid weather URL"
        case .invalidResponse(let statusCode, let message):
            return "Weather API error \(statusCode): \(message)"
        case .emptyWeather:
            return "Weather data is empty"
        }
    }
}

final class WeatherService {
    
    private var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "WeatherAPIKey") as? String else {
            fatalError("Weather API Key not found")
        }
        return key
    }
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchCurrentWeather(latitude: Double, longitude: Double) async throws -> WeatherData {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        guard let url = components?.url else {
            throw WeatherServiceError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw WeatherServiceError.invalidResponse(statusCode: 0, message: "")
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            let message = String(data: data, encoding: .utf8) ?? ""
            throw WeatherServiceError.invalidResponse(
                statusCode: httpResponse.statusCode,
                message: message
            )
        }
        
        let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        guard let weather = decoded.weather.first else {
            throw WeatherServiceError.emptyWeather
        }
        
        return WeatherData(
            temperature: decoded.main.temp,
            description: weather.description,
            icon: weather.icon,
            cityName: decoded.name,
            latitude: decoded.coord.lat,
            longitude: decoded.coord.lon
        )
    }
}
