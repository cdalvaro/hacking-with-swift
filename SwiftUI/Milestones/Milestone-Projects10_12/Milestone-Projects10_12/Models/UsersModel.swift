//
//  UsersModel.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 1/11/23.
//

import Foundation

class UsersModel: ObservableObject {
    @Published var users = [User]()
    
    func fetchUsers() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("Response code: \(httpResponse.statusCode)")
            }
            
            if let error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data {
                DispatchQueue.main.async {
                    self.users = Self.parse(json: data)
                }
            }
        }
        
        task.resume()
    }
    
    func findUserBy(uuid: UUID) -> User? {
        users.first { $0.id == uuid }
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
