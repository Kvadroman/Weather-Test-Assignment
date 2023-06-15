//
//  ViewModel.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

protocol ViewModel: AnyObject {
    associatedtype Input
    associatedtype Output
    var input: Input { get }
    var output: Output { get }
}
