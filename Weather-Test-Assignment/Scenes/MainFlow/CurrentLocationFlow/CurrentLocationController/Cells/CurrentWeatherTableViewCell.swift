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
    
    func configure(with model: ForeCastProtocol) {
        if let model = model as? Forecast {
            dateLabel.text = "Date: \(Date(timeIntervalSince1970: TimeInterval(model.dt)).convertToHours())"
        } else {
            dateLabel.text = model.date
        }
        
        temperatureCelsius.text = model.temperatureCelsius
        minTemperatureCelsius.text = model.minTemperatureCelsius
        maxTemperatureCelsius.text = model.maxTemperatureCelsius
        feelsLikeLabel.text = model.feelsLikeCelsius
        descriptionLabel.text = model.description
        pressure.text = model.pressure
        windSpeed.text = model.windSpeed
        humidity.text = model.humidity
        clouds.text = model.cloudsAll
    }
}
