//
//  ContactsFactory.swift
//  mvvm-example
//
//  Created by Jose Neves on 16/05/22.
//

import Foundation

struct ContactsFactory {
    
    static func build(with viewModel: ContactsViewModelProtocol? = ContactsViewModel()) -> ContactsViewController {
        let view = ContactsViewController()
        view.viewModel = viewModel
        
        return view
    }
}
