//
//  MainTabBarController.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Combine
import UIKit

class MainTabBarController<T: MainTabBarViewModeling>: UITabBarController, Controller {
    
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
        bindOutputs(with: viewModel)
    }
    
    func bindOutputs(with viewModel: T) {
        
    }
}

