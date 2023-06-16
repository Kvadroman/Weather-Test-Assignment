//
//  FindCityViewController.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Combine
import SnapKit
import UIKit

class FindCityViewController<T: FindCityViewModeling>: UIViewController, Controller, UISearchBarDelegate {
    
    typealias ViewModelType = T
    
    let viewModel: ViewModelType
    
    private lazy var cityName: FindCityLabel = {
        let view = FindCityLabel()
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    private lazy var temperatureCelsiusLabel: FindCityLabel = {
        FindCityLabel()
    }()
    
    private lazy var tempMinCelsiusLabel: FindCityLabel = {
        FindCityLabel()
    }()
    
    private lazy var tempMaxCelsiusLabel: FindCityLabel = {
        FindCityLabel()
    }()
    
    private lazy var feelsLikeCelsiusLabel: FindCityLabel = {
        FindCityLabel()
    }()
    
    private lazy var pressureLabel: FindCityLabel = {
        FindCityLabel()
    }()
    
    private lazy var speedLabel: FindCityLabel = {
        FindCityLabel()
    }()
    
    private lazy var humidityLabel: FindCityLabel = {
        FindCityLabel()
    }()
    
    private lazy var cloudsLabel: FindCityLabel = {
        FindCityLabel()
    }()
    
    private lazy var descriptionLabel: FindCityLabel = {
        FindCityLabel()
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    
    required init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: \(coder) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        setupConstraints()
        setupSearchController()
        bindOutputs(with: viewModel)
    }
    
    func bindOutputs(with viewModel: T) {
        viewModel.output.foreCastModel
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .compactMap { $0 }
            .sink { [weak self] weather in
                self?.setupWeather(by: weather)
            }
            .store(in: &cancellables)
        
        viewModel.output.onError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showToast(message: error.localizedDescription, seconds: 4)
            }
            .store(in: &cancellables)
    }
    
    private func setupConstraints() {
        view.addSubview(stackView)
        stackView.addArrangedSubviews([
            cityName,
            temperatureCelsiusLabel,
            tempMinCelsiusLabel,
            tempMaxCelsiusLabel,
            feelsLikeCelsiusLabel,
            pressureLabel,
            speedLabel,
            humidityLabel,
            cloudsLabel,
            descriptionLabel,
        ])
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search City"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupWeather(by model: WeatherResponseByCityName) {
        cityName.text = "City: \(model.name)"
        temperatureCelsiusLabel.text = model.main.temperatureCelsius
        tempMinCelsiusLabel.text = model.main.minTemperatureCelsius
        tempMaxCelsiusLabel.text = model.main.maxTemperatureCelsius
        feelsLikeCelsiusLabel.text = model.main.feelsLikeCelsius
        pressureLabel.text = "Pressure: \(model.main.pressure) hPa"
        speedLabel.text = "Wind Speed: \(model.wind.speed) mph"
        humidityLabel.text = "Humidity: \(model.main.humidity) %"
        cloudsLabel.text = "Clouds: \(model.clouds.all) %"
        descriptionLabel.text = "Description: \(model.weather.first?.description ?? "")"
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel.input.didEnterCityName.send(text)
        searchBar.text = ""
    }
}
