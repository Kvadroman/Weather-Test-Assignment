//
//  CurrentLocationViewModel.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Combine
import Foundation

final class CurrentLocationViewModel: CurrentLocationViewModeling {
    
    struct Input: CurrentLocationViewModelingInput {
        var viewDidLoad: PassthroughSubject<Void, Never>
        var didTapUpdateWeather: PassthroughSubject<Void, Never>
        var didTapOnSelectedDay: PassthroughSubject<Date, Never>
    }
    
    struct Output: CurrentLocationViewModelingOutput {
        var onGetWeather: AnyPublisher<WeatherResponse?, Never>
        var onError: PassthroughSubject<Error, Never>
        var onOpenDetailsForecast: AnyPublisher<[Forecast]?, Never>
    }
    
    lazy var input: Input = Input(viewDidLoad: viewDidLoad,
                                  didTapUpdateWeather: didTapUpdateWeather,
                                  didTapOnSelectedDay: didTapOnSelectedDay)
    lazy var output: Output = Output(onGetWeather: onGetWeather,
                                     onError: onError,
                                     onOpenDetailsForecast: onOpenDetailsForecast)
    
    // Input
    private let viewDidLoad = PassthroughSubject<Void, Never>()
    private let didTapUpdateWeather = PassthroughSubject<Void, Never>()
    private let didTapOnSelectedDay = PassthroughSubject<Date, Never>()
    
    // Output
    private var onGetWeather: AnyPublisher<WeatherResponse?, Never> {
        $weatherResponse.eraseToAnyPublisher()
    }
    private let onError = PassthroughSubject<Error, Never>()
    private var onOpenDetailsForecast: AnyPublisher<[Forecast]?, Never> {
        $hourlyForecast.eraseToAnyPublisher()
    }
    
    private let weatherRepo: WeatherRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []
    @Published private var weatherResponse: WeatherResponse?
    @Published private var hourlyForecast: [Forecast]?
    
    init(weatherRepo: WeatherRepositoryProtocol) {
        self.weatherRepo = weatherRepo
        bind()
    }
    
    private func bind() {
        viewDidLoad
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.getWeather()
            }
            .store(in: &cancellables)
        
        didTapUpdateWeather
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.getWeather()
            }
            .store(in: &cancellables)
        
        didTapOnSelectedDay
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] selectedDate in
                self?.hourlyForecast = self?.weatherResponse?.list.filter { forecast in
                    guard let date = forecast.dateAsDate else { return false }
                    return date.isSameDay(as: selectedDate)
                }
            }
            .store(in: &cancellables)
        
        weatherRepo.error
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .compactMap { $0 }
            .sink { [weak self] error in
                self?.onError.send(error)
            }
            .store(in: &cancellables)

    }
    
    private func getWeather() {
        weatherRepo.fetchWeather { [weak self] result in
            switch result {
            case .success(let weather):
                self?.weatherResponse = weather
            case .failure(let error):
                self?.onError.send(error)
            }
        }
    }
}
