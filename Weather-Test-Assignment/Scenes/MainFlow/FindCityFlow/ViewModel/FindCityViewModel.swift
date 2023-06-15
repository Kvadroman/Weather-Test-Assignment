//
//  FindCityViewModel.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Foundation

final class FindCityViewModel: FindCityViewModeling {
    
    struct Input: FindCityViewModelingInput {
        
    }
    
    struct Output: FindCityViewModelingOutput {
        
    }
    
    lazy var input: Input = Input()
    lazy var output: Output = Output()
    
    private let weatherRepo: WeatherByCityRepositoryProtocol
    
    init(weatherRepo: WeatherByCityRepositoryProtocol) {
        self.weatherRepo = weatherRepo
        bind()
    }
    
    private func bind() {
    }
}
