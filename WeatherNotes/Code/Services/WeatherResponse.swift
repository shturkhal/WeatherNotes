//  Copyright (c) 2026

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: WeatherMainResponse
    let weather: [WeatherInfoResponse]
    let coord: WeatherCoordinateResponse
}

struct WeatherMainResponse: Decodable {
    let temp: Double
}

struct WeatherInfoResponse: Decodable {
    let description: String
    let icon: String
}

struct WeatherCoordinateResponse: Decodable {
    let lat: Double
    let lon: Double
}
