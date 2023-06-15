//
//  ForeCastProtocol.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 15.06.2023.
//

protocol ForeCastProtocol {
    var date: String { get }
    var temperatureCelsius: String { get }
    var minTemperatureCelsius: String { get }
    var maxTemperatureCelsius: String { get }
    var feelsLikeCelsius: String { get }
    var description: String { get }
    var pressure: String { get }
    var windSpeed: String { get }
    var humidity: String { get }
    var cloudsAll: String { get }
}
