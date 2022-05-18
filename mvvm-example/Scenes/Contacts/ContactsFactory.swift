//
//  ContactsFactory.swift
//  mvvm-example
//
//  Created by Jose Neves on 16/05/22.
//

import Foundation

struct ContactsFactory {
    
    static func build(with viewModel: ContactsViewModelProtocol? = nil,
                      apiService: APIServiceProtocol = APIService()) -> ContactsViewController {
        var viewModel = viewModel
        if viewModel == nil {
            viewModel = ContactsViewModel(with: apiService)
        }
        
        let view = ContactsViewController()
        view.viewModel = viewModel
        
        return view
    }
}
