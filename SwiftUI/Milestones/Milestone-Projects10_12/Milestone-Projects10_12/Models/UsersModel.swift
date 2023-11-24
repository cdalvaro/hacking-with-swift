//
//  UsersModel.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 1/11/23.
//

import Foundation

enum UsersModel {
    static func fetchUsersFromURL(completion: @escaping ([User]?, Error?) -> Void) {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(nil, error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                let statusCodeError = NSError(domain: "HTTPError", code: httpResponse.statusCode)
                completion(nil, statusCodeError)
                return
            }
            
            guard let data, !data.isEmpty else {
                let dataError = NSError(domain: "NoDataError", code: 0)
                completion(nil, dataError)
                return
            }
            
            completion(Self.parse(json: data), nil)
        }
        
        task.resume()
    }
    
    private static func parse(json: Data) -> [User] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        if let jsonUsers = try? decoder.decode([User].self, from: json) {
            return jsonUsers
        }
        
        return [User]()
    }
}
