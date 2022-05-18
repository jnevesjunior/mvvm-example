//
//  ContactsViewModelTests.swift
//  mvvm-exampleTests
//
//  Created by Jose Neves on 16/05/22.
//

import XCTest
@testable import mvvm_example

class ContactsViewModelTests: XCTestCase {
    
    var sut: ContactsViewModel!
    var apiServiceMock: APIServiceMock!
    
    override func setUp() {
        apiServiceMock = APIServiceMock()
        sut = ContactsViewModel(with: apiServiceMock)
    }

    override func tearDown() {
        sut = nil
        apiServiceMock = nil
    }
    
    func testFetchContacts() {
        // Given
        apiServiceMock.contactsList.append(Contact(id: 1, name: "teste name", photoURL: "revolut.com"))
        apiServiceMock.contactsList.append(Contact(id: 2, name: "teste name2", photoURL: "revolut.com"))
        
        // When
        sut.fetchData()
        
        // Then
        XCTAssertEqual(sut.getContactsCount(), 2)
    }
    
    func testFetchContactsWithError() {
        // Given
        apiServiceMock.isFetchDataError = true
        
        // When
        sut.fetchData()
        
        // Then
        XCTAssertEqual(sut.getContactsCount(), 0)
    }
    
    func testGetNameByRow() {
        // Given
        apiServiceMock.contactsList.append(Contact(id: 1, name: "teste name", photoURL: "revolut.com"))
        apiServiceMock.contactsList.append(Contact(id: 2, name: "teste name2", photoURL: "revolut.com"))
        
        // When
        sut.fetchData()
        
        // Then
        XCTAssertEqual(sut.getNameByRow(0), "teste name")
    }
    
    func testGetNameWithOutOfIndexRow() {
        // Given
        apiServiceMock.contactsList.append(Contact(id: 1, name: "teste name", photoURL: "revolut.com"))
        apiServiceMock.contactsList.append(Contact(id: 2, name: "teste name2", photoURL: "revolut.com"))
        
        // When
        sut.fetchData()
        
        // Then
        XCTAssertEqual(sut.getNameByRow(3), "")
    }

}


class APIServiceMock: APIServiceProtocol {
    var contactsList = [Contact]()
    var isFetchDataError = false
    
    func fetchData(completion: @escaping ([Contact]) -> (),
                   completionError: @escaping (Error) -> ()) {
        if isFetchDataError {
            completionError(NSError(domain: "test error", code: 1))
        } else {
            completion(contactsList)
        }
    }
    
    func fetchImage(url: String,
                    completion: @escaping (Data) -> (),
                    completionError: @escaping (Error) -> ()) {
        
    }
    
    
}
