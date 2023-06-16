//
//  DetailsForecastViewController.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 14.06.2023.
//

import Combine
import CombineCocoa
import SnapKit
import UIKit

class DetailsForecastViewController<T: DetailsForecastViewModeling>: UIViewController, Controller {
    
    typealias ViewModelType = T
    typealias Adapter = CurrentWeatherAdapter
    
    // MARK: - Replies Adapter
    private lazy var detailsForecastAdapter: Adapter<Forecast> = {
        return Adapter(tableView: detailsForecastTableView) { [weak self] tableView in
            self?.registerCells(tableView)
        } cellIdentifier: { [weak self] _ in
            self?.getCurrentWeatherCellIdentifier() ?? "Cell"
        } render: { [weak self] item, cell in
            self?.renderCell(item, cell)
        }
    }()
    
    private lazy var detailsForecastTableView: UITableView = {
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
        viewModel.input.viewDidLoad.send()
        setupConstraints()
        setupViews()
        bindOutputs(with: viewModel)
    }
    
    func bindOutputs(with viewModel: T) {
        viewModel.output.hourlyForecastModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] weather in
                self?.detailsForecastAdapter.update(items: weather, animated: true)
            }
            .store(in: &cancellables)
    }
    
    private func setupConstraints() {
        view.addSubview(detailsForecastTableView)
        detailsForecastTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: - DetailsForecast Adapter
extension DetailsForecastViewController {
    private func registerCells(_ tableView: UITableView) {
        tableView.register(CurrentWeatherTableViewCell.nib(), forCellReuseIdentifier: getCurrentWeatherCellIdentifier())
    }
    
    private func getCurrentWeatherCellIdentifier() -> String {
        CurrentWeatherTableViewCell.identifier
    }
    
    private func renderCell(_ item: Forecast, _ cell: UITableViewCell) {
        guard let cell = cell as? CurrentWeatherTableViewCell else { return }
        cell.configure(with: item)
    }
}

