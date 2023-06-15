//
//  Controller.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

protocol Controller: AnyObject {
    associatedtype ViewModelType: ViewModel
    init(viewModel: ViewModelType)
    func bindOutputs(with viewModel: ViewModelType)
}
