//
//  NetworkRepository.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 14.06.2023.
//

import Alamofire
import Foundation

protocol NetworkByCityNameRepositoryProtocol {
    func getWeatherByCityName(city: String, completion: @escaping ((Result<WeatherResponse, Error>) -> Void))
}

protocol NetworkRepositoryForecastProtocol {
    func getWeatherForecast(with model: ForeCastModel, completion: @escaping ((Result<WeatherResponse, Error>) -> Void))
}

protocol NetworkRepositoryProtocol: NetworkRepositoryForecastProtocol, NetworkByCityNameRepositoryProtocol {
    func getWeatherForecast(with model: ForeCastModel, completion: @escaping ((Result<WeatherResponse, Error>) -> Void))
    func getWeatherByCityName(city: String, completion: @escaping ((Result<WeatherResponse, Error>) -> Void))
}

final class NetworkRepository: NetworkRepositoryProtocol {
    
    func getWeatherForecast(with model: ForeCastModel, completion: @escaping ((Result<WeatherResponse, Error>) -> Void)) {
        performRequest(.getWeather(model: model), completion: completion)
    }
    
    func getWeatherByCityName(city: String, completion: @escaping ((Result<WeatherResponse, Error>) -> Void)) {
        performRequest(.getWeatherByCityName(city: city), completion: completion)
    }
    
    private func performRequest<T: Codable>(_ endpoint: WeatherAPI, completion: @escaping (Result<T, Error>) -> Void) {
        let fullPath = endpoint.baseURL + endpoint.path
        AF.request(fullPath, parameters: endpoint.parameters).validate().responseDecodable(of: T.self) { (response) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
