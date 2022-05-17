//
//  ViewProtocol.swift
//  mvvm-example
//
//  Created by Jose Neves on 16/05/22.
//

import Foundation

protocol ViewProtocol {
    func buildViews()
    func configViews()
    func setupConstraints()
    
    func setupViews()
}

extension ViewProtocol {
    func setupViews() {
        buildViews()
        configViews()
        setupConstraints()
    }
}
