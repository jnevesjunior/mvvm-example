//
//  ContactsViewModelStub.swift
//  mvvm-exampleTests
//
//  Created by Jose Neves on 16/05/22.
//

import XCTest
@testable import mvvm_example

final class ContactsViewModelStub: XCTestCase {
    
    var sut: ContactsViewModel!
    var apiServiceMock: APIServiceMock!
    var viewSpy: ContactsViewSpy!
    
    override func setUp() {
        apiServiceMock = APIServiceMock()
        sut = ContactsViewModel(with: apiServiceMock)
        
        viewSpy = ContactsViewSpy()
        sut.delegate = viewSpy
    }

    override func tearDown() {
        sut = nil
        apiServiceMock = nil
        viewSpy = nil
    }
    
    func testFetchContacts() {
        // Given
        apiServiceMock.contactsList.append(Contact(id: 1, name: "teste name", photoURL: "revolut.com"))
        apiServiceMock.contactsList.append(Contact(id: 2, name: "teste name2", photoURL: "revolut.com"))
        
        // When
        sut.fetchData()
        
        // Then
        XCTAssertTrue(viewSpy.isLoadingIsLoadingValue)
        
        XCTAssertEqual(sut.getContactsCount(), 2)
        
        let expectation = expectation(description: "reload items on screen")
        DispatchQueue.main.async(flags: .barrier) { [weak viewSpy] in
            guard let viewSpy = viewSpy else { return }
            
            XCTAssertEqual(viewSpy.reloadContactsCalls, 1)
            
            XCTAssertFalse(viewSpy.isLoadingIsLoadingValue)
            XCTAssertEqual(viewSpy.isLoadingCalls, 2)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchContactsWithError() {
        // Given
        apiServiceMock.isFetchDataError = true
        
        // When
        sut.fetchData()
        
        // Then
        XCTAssertTrue(viewSpy.isLoadingIsLoadingValue)
        
        XCTAssertEqual(sut.getContactsCount(), 0)
        
        let expectation = expectation(description: "reload items on screen")
        DispatchQueue.main.async(flags: .barrier) { [weak viewSpy] in
            guard let viewSpy = viewSpy else { return }
            XCTAssertEqual(viewSpy.reloadContactsCalls, 0)
            
            XCTAssertFalse(viewSpy.isLoadingIsLoadingValue)
            XCTAssertEqual(viewSpy.isLoadingCalls, 2)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
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
