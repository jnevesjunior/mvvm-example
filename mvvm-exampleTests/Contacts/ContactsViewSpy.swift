//
//  ContactsViewSpy.swift
//  mvvm-exampleTests
//
//  Created by Jose Neves on 18/05/22.
//

import Foundation
@testable import mvvm_example

final class ContactsViewSpy: ContactsViewControllerProtocol {
    
    var reloadContactsCalls = 0
    func reloadContacts() {
        reloadContactsCalls += 1
    }
    
    var isLoadingCalls = 0
    var isLoadingIsLoadingValue: Bool!
    func isLoading(_ isLoading: Bool) {
        isLoadingCalls += 1
        isLoadingIsLoadingValue = isLoading
    }
    
}
