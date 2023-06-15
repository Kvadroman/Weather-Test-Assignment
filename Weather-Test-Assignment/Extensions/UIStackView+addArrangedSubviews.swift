//
//  UIStackView+addArrangedSubviews.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 15.06.2023.
//
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView?]) {
        let validSubviews = views.compactMap { $0 }
        validSubviews.forEach { self.addArrangedSubview($0) }
    }
}
