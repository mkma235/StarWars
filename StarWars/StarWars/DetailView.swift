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
        navigationController!.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareEvent))
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "share"
     
        self.imageDetail.image = UIImage(data: CardView.imageData)
        self.dateDetail.text = CardView.date
        self.titleDetail.text = CardView.title
        self.locationDetail.text = CardView.location
        self.overviewDetail.text = CardView.overview
    }
    
    @objc func shareEvent() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 0)
            self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let ss = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let AV = UIActivityViewController(activityItems: [ss!], applicationActivities: nil)
            self.present(AV, animated: true, completion: nil)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 0)
            self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let ss = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let AV = UIActivityViewController(activityItems: [ss!], applicationActivities: nil)
            AV.popoverPresentationController?.sourceView = self.view
            AV.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            self.present(AV, animated: true, completion: nil)
        }
        
    }
}
