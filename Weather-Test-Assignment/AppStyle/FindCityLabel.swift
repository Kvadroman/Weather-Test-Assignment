//
//  FindCityLabel.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 15.06.2023.
//

import UIKit

final class FindCityLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
