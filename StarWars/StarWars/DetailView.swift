//
//  DetailView.swift
//  StarWars
//
//  Created by Mariano Manuel on 5/25/21.
//

import UIKit

class DetailView: UIViewController {
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var dateDetail: UILabel!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var locationDetail: UILabel!
    @IBOutlet weak var overviewDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.imageDetail.image = UIImage(named: "Test")
        self.dateDetail.text = "May 26, 2021"
        self.titleDetail.text = "Taylor Swift"
        self.locationDetail.text = "My Heart"
        self.overviewDetail.text = "Everyday"
    }

    func setDetails(image: UIImage, date: String, title: String, location: String, overview: String) {
        self.imageDetail.image = image
        self.dateDetail.text = date
        self.titleDetail.text = title
        self.locationDetail.text = location
        self.overviewDetail.text = overview
    }
}
