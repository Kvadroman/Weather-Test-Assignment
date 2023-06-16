//
//  CurrentLocationViewController.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Combine
import CombineCocoa
import SnapKit
import UIKit

class CurrentLocationViewController<T: CurrentLocationViewModeling>: UIViewController, Controller {
    
    typealias ViewModelType = T
    typealias Adapter = CurrentWeatherAdapter
    
    // MARK: - Replies Adapter
    private lazy var currentWeatherAdapter: Adapter<AverageForecast> = {
        return Adapter(tableView: currentWeatherTableView) { [weak self] tableView in
            self?.registerCells(tableView)
        } cellIdentifier: { [weak self] _ in
            self?.getCurrentWeatherCellIdentifier() ?? "Cell"
        } render: { [weak self] item, cell in
            self?.renderCell(item, cell)
        }
    }()
    
    private lazy var currentWeatherTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let viewModel: ViewModelType
    var weatherDateProcessor: WeatherDateProcessorProtocol?
    var cancellables: Set<AnyCancellable> = []
    
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
        viewModel.input.viewDidLoad.send()
        setupConstraints()
        setupNavController()
        bindInputs(for: viewModel)
        bindOutputs(with: viewModel)
    }
    
    private func bindInputs(for viewModel: T) {
        currentWeatherAdapter.selectItem
            .receive(on: DispatchQueue.main)
            .sink { selectedDate in
                viewModel.input.didTapOnSelectedDay.send(selectedDate)
            }
            .store(in: &cancellables)
    }
    
    func bindOutputs(with viewModel: T) {
        viewModel.output.onGetWeather
            .receive(on: DispatchQueue.main)
            .drop(while: { $0 == nil })
            .compactMap { $0 }
            .sink { [weak self] weather in
                self?.navigationItem.title = weather.city.name
                guard let averageForeCast = self?.weatherDateProcessor?.processForecasts(weather.list) else { return }
                self?.currentWeatherAdapter.update(items: averageForeCast, animated: true)
            }
            .store(in: &cancellables)
        
        viewModel.output.onError
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] error in
                self?.showToast(message: error.localizedDescription, seconds: 2)
            }
            .store(in: &cancellables)
    }
    
    private func setupConstraints() {
        view.addSubview(currentWeatherTableView)
        currentWeatherTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupNavController() {
        let imageButton = UIImage(systemName: "arrow.triangle.2.circlepath")
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: imageButton,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightBarButtonTapped))
    }
    
    @objc private func rightBarButtonTapped() {
        viewModel.input.didTapUpdateWeather.send()
    }
}

// MARK: - CurrentWeather Adapter
extension CurrentLocationViewController {
    private func registerCells(_ tableView: UITableView) {
        tableView.register(CurrentWeatherTableViewCell.nib(), forCellReuseIdentifier: getCurrentWeatherCellIdentifier())
    }
    
    private func getCurrentWeatherCellIdentifier() -> String {
        CurrentWeatherTableViewCell.identifier
    }
    
    private func renderCell(_ item: AverageForecast, _ cell: UITableViewCell) {
        guard let cell = cell as? CurrentWeatherTableViewCell else { return }
        cell.configure(with: item)
    }
}
