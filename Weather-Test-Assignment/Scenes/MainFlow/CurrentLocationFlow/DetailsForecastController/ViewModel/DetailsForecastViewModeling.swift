//
//  DetailsForecastViewModeling.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 14.06.2023.
//

import Combine
import Foundation

protocol DetailsForecastViewModeling: ViewModel where Input: DetailsForecastViewModelingInput, Output: DetailsForecastViewModelingOutput {
}

protocol DetailsForecastViewModelingInput {
    var viewDidLoad: PassthroughSubject<Void, Never> { get }
}

protocol DetailsForecastViewModelingOutput {
    var hourlyForecastModel: AnyPublisher<[Forecast]?, Never> { get }
}
