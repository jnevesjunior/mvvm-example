//
//  ContactsViewModel.swift
//  mvvm-example
//
//  Created by Jose Neves on 16/05/22.
//

import Foundation

protocol ContactsViewModelProtocol {
    var delegate: ContactsViewControllerProtocol? { get set }
    
    func feachData()
}

class ContactsViewModel: NSObject, ContactsViewModelProtocol {
    
    var delegate: ContactsViewControllerProtocol?
    private var apiService: APIService!
    
    private var contacts = [Contact]()
    
    override init() {
        super.init()
        
        self.apiService = APIService()
    }
    
    func feachData() {
        delegate?.isLoading(true)
        
        apiService.feachData(completion: { [weak self] contacts in
            self?.contacts = contacts
            
            self?.delegate?.reloadContacts(contacts)
            self?.delegate?.isLoading(false)
        }, completionError: { [weak self] error in
            self?.delegate?.isLoading(false)
            print("----Error----")
            print(error)
            print("-------------")
        })
    }
}
