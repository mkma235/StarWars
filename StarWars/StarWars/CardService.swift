//
//  CardService.swift
//  StarWars
//
//  Created by Mariano Manuel on 5/26/21.
//

import Foundation

//
// MARK: - Card Service
//
class CardService {
    //
    // MARK: - Card Details Fetch Call
    //
    struct Card: Codable {
        var id: Int
        var description: String
        var title: String
        var timestamp: String
        var image: String?
        var phone: String?
        var date: String
        var locationline1: String
        //var locationline2: String
    }
    
    let starWarsURL = "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/feed.json"
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage = ""

    func fetchDetails(completion: @escaping ([Card]?) -> Void) {
        dataTask?.cancel()
        //Fetch StarWars Details
        guard let url = URL(string: starWarsURL) else { return }
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data {
                let response = try? JSONDecoder().decode([Card].self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        }
        dataTask?.resume()
    }
}
