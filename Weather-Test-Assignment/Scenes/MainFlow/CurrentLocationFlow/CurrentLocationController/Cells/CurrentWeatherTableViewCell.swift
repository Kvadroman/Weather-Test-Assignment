//
//  CurrentWeatherTableViewCell.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 14.06.2023.
//

import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {

    static let identifier = "CurrentWeatherTableViewCell"
    @IBOutlet weak var temperatureCelsius: UILabel!
    @IBOutlet weak var minTemperatureCelsius: UILabel!
    @IBOutlet weak var maxTemperatureCelsius: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var clouds: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        temperatureCelsius.text = nil
        minTemperatureCelsius.text = nil
        maxTemperatureCelsius.text = nil
        pressure.text = nil
        windSpeed.text = nil
        humidity.text = nil
        clouds.text = nil
        feelsLikeLabel.text = nil
        descriptionLabel.text = nil
        dateLabel.text = nil
    }
    
    func configure(with model: AverageForecast) {
        dateLabel.text = "Date:" + " " + model.date.convertToString()
        temperatureCelsius.text = "Average temperature: \(model.averageTemperatureCelsius) ℃"
        minTemperatureCelsius.text = "Min Temperature: \(model.minTemperatureCelsius) ℃"
        maxTemperatureCelsius.text = "Max Temperature: \(model.maxTemperatureCelsius) ℃"
        feelsLikeLabel.text = "Feels Like: \(model.averageFeelsLikeCelsius) ℃"
        descriptionLabel.text = "Description:" + " " + (model.weatherDescription)
        pressure.text = "Pressure: \(model.averagePressure) hPa"
        windSpeed.text = "Wind Speed: \(model.averageWindSpeed) mph"
        humidity.text = "Humidity: \(model.averageHumidity) %"
        clouds.text = "Clouds: \(model.averageClouds) %"
    }
    
    func configure(with model: Forecast) {
        dateLabel.text = "Date:" + " " + model.date.convertToHours()
        temperatureCelsius.text = "Temperature: \(model.temperatureCelsius) ℃"
        minTemperatureCelsius.text = "Min Temperature: \(model.minTemperatureCelsius) ℃"
        maxTemperatureCelsius.text = "Max Temperature: \(model.maxTemperatureCelsius) ℃"
        feelsLikeLabel.text = "Feels Like: \(model.main.feelsLikeCelsius) ℃"
        descriptionLabel.text = "Description:" + " " + (model.weather.first?.description.capitalized ?? "")
        pressure.text = "Pressure: \(model.main.pressure) hPa"
        windSpeed.text = "Wind Speed: \(model.wind.speed) mph"
        humidity.text = "Humidity: \(model.main.humidity) %"
        clouds.text = "Clouds: \(model.clouds.all) %"
    }
}
