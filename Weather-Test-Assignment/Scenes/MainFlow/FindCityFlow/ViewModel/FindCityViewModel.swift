//
//  FindCityViewModel.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Combine
import Foundation

final class FindCityViewModel: FindCityViewModeling {
    
    struct Input: FindCityViewModelingInput {
        var didEnterCityName: PassthroughSubject<String, Never>
    }
    
    struct Output: FindCityViewModelingOutput {
        var foreCastModel: AnyPublisher<WeatherResponseByCityName?, Never>
        var onError: PassthroughSubject<Error, Never>
    }
    
    lazy var input: Input = Input(didEnterCityName: didEnterCityName)
    lazy var output: Output = Output(foreCastModel: foreCastModel, onError: onError)
    
    // Input
    private let didEnterCityName = PassthroughSubject<String, Never>()
    
    // Output
    private var foreCastModel: AnyPublisher<WeatherResponseByCityName?, Never> {
        $weatherModel.eraseToAnyPublisher()
    }
    private let onError = PassthroughSubject<Error, Never>()
    
    @Published private var weatherModel: WeatherResponseByCityName?
    private let weatherRepo: WeatherByCityRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(weatherRepo: WeatherByCityRepositoryProtocol) {
        self.weatherRepo = weatherRepo
        bind()
    }
    
    private func bind() {
        didEnterCityName
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .drop(while: { $0 == "" })
            .removeDuplicates()
            .sink { [weak self] cityName in
                self?.getWeather(by: cityName)
            }
            .store(in: &cancellables)
    }
    
    private func getWeather(by cityName: String) {
        weatherRepo.fetchWeatherByCityName(with: cityName) { [weak self] result in
            switch result {
            case .success(let weatherModel):
                self?.weatherModel = weatherModel
            case .failure(let failure):
                self?.onError.send(failure)
            }
        }
    }
}
