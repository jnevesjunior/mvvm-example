//
//  ContactsViewController.swift
//  mvvm-example
//
//  Created by Jose Neves on 16/05/22.
//

import UIKit
import SwiftUI

protocol ContactsViewControllerProtocol: AnyObject {
    func reloadContacts()
    func isLoading(_ isLoading: Bool)
}

final class ContactsViewController: UIViewController {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .black
        view.hidesWhenStopped = true
        view.isAccessibilityElement = false
        
        view.startAnimating()
        
        return view
    }()
    
    lazy var contactsTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        
        view.backgroundColor = .clear
        view.allowsSelection = false
        view.separatorStyle = .none
        
        return view
    }()
    
    var viewModel: ContactsViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        viewModel?.delegate = self
        viewModel?.fetchData()
    }
    
}

extension ContactsViewController: UITableViewDelegate {
    
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getContactsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell,
              let viewModel = viewModel else {
            return UITableViewCell()
        }
        
        cell.setupData(name: viewModel.getNameByRow(indexPath.row))
        
        viewModel.getPhotoByRow(indexPath.row, completion: { image in
            cell.setupPhotoImage(with: image)
        })
        
        return cell
    }
}

extension ContactsViewController: ContactsViewControllerProtocol {
    func reloadContacts() {
        contactsTableView.reloadData()
    }
    
    func isLoading(_ isLoading: Bool) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.activityIndicator.alpha = isLoading ? 1 : 0
            self?.contactsTableView.alpha = isLoading ? 0 : 1
        })
    }
}

extension ContactsViewController: ViewProtocol {
    func buildViews() {
        view.backgroundColor = .white
    }
    
    func configViews() {
        view.addSubViews([
            activityIndicator,
            contactsTableView
        ])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contactsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contactsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contactsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contactsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
}

struct ContactsViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            let viewController = ContactsViewController()
            viewController.viewModel = ContactsViewModel()
            
            return viewController
        }
    }
}
