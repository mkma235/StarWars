//
//  MemCard.swift
//  StarWars
//
//  Created by Mariano Manuel on 6/2/21.
//

import Foundation

//Offline Copy
struct MemCard {
    var id: Int
    var image: String
    var date: String
    var title: String
    var location: String
    var overview: String
    
    init(id: Int, image: String, date: String, title: String, location: String, overview: String) {
        self.id = id
        self.image = image
        self.date = date
        self.title = title
        self.location = location
        self.overview = overview
    }
}
