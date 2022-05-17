//
//  Contact.swift
//  mvvm-example
//
//  Created by Jose Neves on 16/05/22.
//

import Foundation

struct Contact: Decodable {
    var id: Int
    var name: String
    var photoURL: String
    
    init(id: Int, name: String = "", photoURL: String = "") {
        self.id = id
        self.name = name
        self.photoURL = photoURL
    }
    
}
