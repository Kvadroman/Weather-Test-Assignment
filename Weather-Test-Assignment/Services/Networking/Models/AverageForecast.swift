//
//  AverageForecast.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 14.06.2023.
//

import Foundation

struct AverageForecast: Hashable {
    let date: Date
    let averageTemperatureCelsius: Double
    let minTemperatureCelsius: Double
    let maxTemperatureCelsius: Double
    let averageFeelsLikeCelsius: Double
    let averagePressure: Double
    let averageWindSpeed: Double
    let averageHumidity: Int
    let averageClouds: Int
    let weatherDescription: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
}
