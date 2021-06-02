//
//  DetailView.swift
//  StarWars
//
//  Created by Mariano Manuel on 5/25/21.
//

import UIKit

class DetailView: UIViewController {
    
    var CardView: MemCard!
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var dateDetail: UILabel!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var locationDetail: UILabel!
    @IBOutlet weak var overviewDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let strURL = CardView.image
        let imageURL = URL(string: strURL)!
        var imageData: Data = Data()
        do {
            imageData = try Data(contentsOf: imageURL)
            self.imageDetail.image = UIImage(data: imageData)!
        } catch  {
            print(error)
            self.imageDetail.image = UIImage(named: "Test")
        }
        self.dateDetail.text = CardView.date
        self.titleDetail.text = CardView.title
        self.locationDetail.text = CardView.location
        self.overviewDetail.text = CardView.overview
    }
}
