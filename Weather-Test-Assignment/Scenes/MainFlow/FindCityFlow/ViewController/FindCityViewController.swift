//
//  FindCityViewController.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Combine
import UIKit

class FindCityViewController<T: FindCityViewModeling>: UIViewController, Controller, UISearchResultsUpdating {
    
    typealias ViewModelType = T
    
    let viewModel: ViewModelType
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
        view.backgroundColor = .cyan
        navigationController?.navigationBar.prefersLargeTitles = false
        setupSearchController()
        bindOutputs(with: viewModel)
    }
    
    func bindOutputs(with viewModel: T) {
        
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search City"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - UISearchResultsUpdatingDelegate
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}
