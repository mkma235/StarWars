//
//  MasterView.swift
//  StarWars
//
//  Created by Mariano Manuel on 5/25/21.
//

import UIKit

class MasterView: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let cardService = CardService()
    
    //Offline Copy
    struct MemCard {
        var id: Int
        var image: String
        var date: String
        var title: String
        var location: String
        var overview: String
    }
    var memCards: [MemCard] = []
    
    override func loadView() {
        super.loadView()
        if memCards.count != 10 {
            cardService.fetchDetails { Cards in
                if let Cards = Cards {
                    for Card in Cards {
                        var memory = MemCard(id: 0, image: "N/A", date: "N/A", title: "N/A", location: "N/A", overview: "N/A")
                        memory.id = Card.id
                        memory.image = Card.image ?? "placeHolder"
                        memory.date = Card.date
                        memory.title = Card.title
                        memory.location = Card.locationline1
                        memory.overview = Card.description
                        self.memCards.append(memory)
                    }
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Star Wars"

        //Set Deletages
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }

}

extension MasterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Item")
    }
}

extension MasterView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CardCell {
            
            let strURL = memCards[indexPath.row].image
            let imageURL = URL(string: strURL)!
            var imageData: Data = Data()
            do {
                imageData = try Data(contentsOf: imageURL)
            } catch  {
                print(error)
            }
            infoCell.setData(image: (UIImage(data: imageData) ?? UIImage(named: "Test"))!, date: memCards[indexPath.row].date, title: memCards[indexPath.row].title, location: memCards[indexPath.row].location, overview: memCards[indexPath.row].overview)
            cell = infoCell
        }
        return cell
    }
    
}
