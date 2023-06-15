//
//  MainTabBarViewModel.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Foundation

final class MainTabBarViewModel: MainTabBarViewModeling {
    
    struct Input: MainTabBarViewModelingInput {
        
    }
    
    struct Output: MainTabBarViewModelingOutput {
        
    }
    
    lazy var input: Input = Input()
    lazy var output: Output = Output()
}
