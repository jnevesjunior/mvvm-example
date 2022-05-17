//
//  UIView+Extensions.swift
//  mvvm-example
//
//  Created by Jose Neves on 16/05/22.
//

import UIKit

extension UIView {
    
    func addSubViews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview($0)
        }
    }
}
