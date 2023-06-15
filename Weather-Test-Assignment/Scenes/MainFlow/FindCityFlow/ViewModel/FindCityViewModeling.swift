//
//  FindCityViewModeling.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Combine

protocol FindCityViewModeling: ViewModel where Input: FindCityViewModelingInput, Output: FindCityViewModelingOutput {
}

protocol FindCityViewModelingInput {
    var didEnterCityName: PassthroughSubject<String, Never> { get }
}

protocol FindCityViewModelingOutput {
    var foreCastModel: AnyPublisher<WeatherResponseByCityName?, Never> { get }
    var onError: PassthroughSubject<Error, Never> { get }
}

