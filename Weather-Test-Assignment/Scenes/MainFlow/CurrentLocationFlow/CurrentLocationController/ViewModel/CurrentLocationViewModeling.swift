//
//  CurrentLocationViewModeling.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Combine
import Foundation

protocol CurrentLocationViewModeling: ViewModel where Input: CurrentLocationViewModelingInput, Output: CurrentLocationViewModelingOutput {
}

protocol CurrentLocationViewModelingInput {
    var viewDidLoad: PassthroughSubject<Void, Never> { get }
    var didTapUpdateWeather: PassthroughSubject<Void, Never> { get }
    var didTapOnSelectedDay: PassthroughSubject<Date, Never> { get }
}

protocol CurrentLocationViewModelingOutput {
    var onGetWeather: AnyPublisher<WeatherResponse?, Never> { get }
    var onError: PassthroughSubject<Error, Never> { get }
    var onOpenDetailsForecast: AnyPublisher<[Forecast]?, Never> { get }
}
