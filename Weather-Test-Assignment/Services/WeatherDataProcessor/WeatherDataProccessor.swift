//
//  WeatherDataProccessor.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 14.06.2023.
//

import Foundation

protocol WeatherDateProcessorProtocol {
    func processForecasts(_ forecasts: [Forecast]) -> [AverageForecast]
}

class WeatherDateProcessor: WeatherDateProcessorProtocol {
    private let calendar = Calendar.current

    func processForecasts(_ forecasts: [Forecast]) -> [AverageForecast] {
        let groupedForecasts = groupForecastsByDay(forecasts)
        return calculateAverages(groupedForecasts)
    }

    private func groupForecastsByDay(_ forecasts: [Forecast]) -> [Date: [Forecast]] {
        return Dictionary(grouping: forecasts) { forecast in
            calendar.startOfDay(for: forecast.date)
        }
    }

    private func calculateAverages(_ groupedForecasts: [Date: [Forecast]]) -> [AverageForecast] {
        var averagedForecasts: [AverageForecast] = []

        for (date, forecasts) in groupedForecasts {
            let averageTemp = forecasts.map { $0.temperatureCelsius }.reduce(0, +) / forecasts.count
            let minTemp = forecasts.map { $0.minTemperatureCelsius }.min() ?? 0
            let maxTemp = forecasts.map { $0.maxTemperatureCelsius }.max() ?? 0
            let averageFeelsLikeCelsius = forecasts.map { $0.main.feelsLikeCelsius }.reduce(0, +) / forecasts.count
            let averagePressure = forecasts.map { $0.main.pressure }.reduce(0, +) / forecasts.count
            let averageWindSpeed = forecasts.map { Int($0.wind.speed) }.reduce(0, +) / forecasts.count
            let averageHumidity = forecasts.map { $0.main.humidity }.reduce(0, +) / forecasts.count
            let averageClouds = forecasts.map { $0.clouds.all }.reduce(0, +) / forecasts.count
            let weatherDescription = forecasts.first?.weather.first?.description ?? ""

            // Construct a new AverageForecast instance from the averaged values
            let averagedForecast = AverageForecast(
                date: date,
                averageTemperatureCelsius: Double(averageTemp),
                minTemperatureCelsius: Double(minTemp),
                maxTemperatureCelsius: Double(maxTemp),
                averageFeelsLikeCelsius: Double(averageFeelsLikeCelsius),
                averagePressure: Double(averagePressure),
                averageWindSpeed: Double(averageWindSpeed),
                averageHumidity: averageHumidity,
                averageClouds: averageClouds,
                weatherDescription: weatherDescription
            )

            averagedForecasts.append(averagedForecast)
        }

        // sort by date
        return averagedForecasts.sorted { ($0.date as Date) < ($1.date as Date) }
    }
}
