//
//  UIStackView+Extensions.swift
//  mvvm-example
//
//  Created by Jose Neves on 16/05/22.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview($0)
        }
    }
}
