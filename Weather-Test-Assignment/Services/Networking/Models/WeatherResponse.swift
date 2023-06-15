//
//  WeatherResponse.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Combine
import Foundation

struct WeatherResponse: Codable, Equatable, Hashable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [Forecast]
    let city: City
    
    static func == (lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        lhs.cnt == rhs.cnt
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(city)
    }
}

struct City: Codable, Hashable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
    
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}

struct Forecast: Codable, Equatable, Hashable {
    static func == (lhs: Forecast, rhs: Forecast) -> Bool {
        lhs.date == rhs.date
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(visibility)
    }
    
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let sys: Sys
    let dtTxt: String

    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(dt))
    }
    
    var temperatureCelsius: Int {
        Int(main.temp - 273.15)
    }
    
    var minTemperatureCelsius: Int {
        Int(main.tempMin - 273.15)
    }
    
    var maxTemperatureCelsius: Int {
        Int(main.tempMax - 273.15)
    }

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let seaLevel: Int
    let grndLevel: Int
    let humidity: Int
    let tempKf: Double
    
    var feelsLikeCelsius: Int {
        Int(feelsLike - 273.15)
    }

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct Sys: Codable {
    let pod: String
}

struct Rain: Codable {
    let h3: Double

    enum CodingKeys: String, CodingKey {
        case h3 = "3h"
    }
}
