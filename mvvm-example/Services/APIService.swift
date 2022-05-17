//
//  APIService.swift
//  mvvm-example
//
//  Created by Jose Neves on 16/05/22.
//

import Foundation

final class APIService {
    
    private let mockURL = "https://run.mocky.io/v3/d26d86ec-fb82-48a7-9c73-69e2cb728070"
    
    init() {
        
    }
        
    func feachData(completion: @escaping ([Contact]) -> (),
                   completionError: @escaping (Error) -> ()) {
        guard let url = URL(string: mockURL) else {
            completionError(NSError(domain: "url unavailable", code: 1))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error {
                completionError(error)
                return
            }
            
            guard let jsonData = data else {
                completionError(NSError(domain: "empty respose", code: 2))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Contact].self, from: jsonData)
                
                completion(decoded)
            } catch let error {
                completionError(error)
            }
        }.resume()
    }
}
