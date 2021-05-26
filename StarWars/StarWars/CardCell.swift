//
//  CardCell.swift
//  StarWars
//
//  Created by Mariano Manuel on 5/25/21.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    func setData(image: UIImage, date: String, title: String, location: String, overview: String) {
        self.imageView.image = image
        self.date.text = date
        self.title.text = title
        self.location.text = location
        self.overview.text = overview
    }
}
