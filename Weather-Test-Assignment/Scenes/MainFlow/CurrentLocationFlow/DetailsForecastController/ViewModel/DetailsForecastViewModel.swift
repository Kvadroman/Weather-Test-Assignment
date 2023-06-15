//
//  DetailsForecastViewModel.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 14.06.2023.
//

import Combine
import Foundation

final class DetailsForecastViewModel: DetailsForecastViewModeling {
    
    struct Input: DetailsForecastViewModelingInput {
        var viewDidLoad: PassthroughSubject<Void, Never>
    }
    
    struct Output: DetailsForecastViewModelingOutput {
        var hourlyForecastModel: AnyPublisher<[Forecast]?, Never>
    }
    
    lazy var input: Input = Input(viewDidLoad: viewDidLoad)
    lazy var output: Output = Output(hourlyForecastModel: hourlyForecastModel)
    
    // Input
    private let viewDidLoad = PassthroughSubject<Void, Never>()
    
    // Output
    private var hourlyForecastModel: AnyPublisher<[Forecast]?, Never> {
        $hourlyForecast.eraseToAnyPublisher()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    @Published private var hourlyForecast: [Forecast]?
    
    init(hourlyForecast: [Forecast]?) {
        self.hourlyForecast = hourlyForecast
    }
}
