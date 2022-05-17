//
//  ContactsViewModel.swift
//  mvvm-example
//
//  Created by Jose Neves on 16/05/22.
//

import Foundation
import UIKit

protocol ContactsViewModelProtocol: AnyObject {
    var delegate: ContactsViewControllerProtocol? { get set }
    
    func fetchData()
    func getContactsCount() -> Int
    func getNameByRow(_ row: Int) -> String
    func getPhotoByRow(_ row: Int, completion: @escaping (UIImage) -> Void)
}

final class ContactsViewModel: ContactsViewModelProtocol {
    
    weak var delegate: ContactsViewControllerProtocol?
    
    private var apiService: APIService!
    private var contacts = [Contact]()
    
    private var loadedImages = [LoadedImage]()
    
    struct LoadedImage {
        var id: Int
        var image: UIImage?
    }
    
    init() {
        self.apiService = APIService()
    }
    
    func fetchData() {
        delegate?.isLoading(true)
        
        apiService.fetchData(completion: { [weak self] contacts in
            self?.contacts = contacts
            
            self?.delegate?.reloadContacts()
            self?.delegate?.isLoading(false)
        }, completionError: { [weak self] error in
            self?.delegate?.isLoading(false)
            print("----Error----")
            print(error)
            print("-------------")
        })
    }
    
    func getContactsCount() -> Int {
        return contacts.count
    }
    
    func getNameByRow(_ row: Int) -> String {
        if row >= contacts.count {
            return ""
        }
        
        return contacts[row].name
    }
    
    func getPhotoByRow(_ row: Int, completion: @escaping (UIImage) -> Void) {
        if row >= contacts.count {
            return
        }
        
        let contact = contacts[row]
        
        let loadedImageFilter = loadedImages.filter { loadedImage in
            loadedImage.id == contact.id
        }
        
        if let loadedImage = loadedImageFilter.first,
           let image = loadedImage.image {
            completion(image)
            return
        }
        
        apiService.fetchImage(url: contact.photoURL,
                              completion: { [weak self] imageData in
            if let image = UIImage(data: imageData) {
                self?.loadedImages.append(LoadedImage(id: contact.id, image: image))
                completion(image)
            }
        }, completionError: { [weak self] error in
            self?.delegate?.isLoading(false)
            print("----Error----")
            print(error)
            print("-------------")
        })
    }
}
