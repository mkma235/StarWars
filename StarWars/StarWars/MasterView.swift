//
//  MasterView.swift
//  StarWars
//
//  Created by Mariano Manuel on 5/25/21.
//

import UIKit

class MasterView: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSource = ["AAA", "BBB", "CCC", "DDD", "EEE", "FFF", "GGG"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Star Wars"

        //Set Deletages
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

}

extension MasterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Item")
    }
}

extension MasterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CardCell {
            infoCell.setData(image: UIImage(named: "Test")!, date: dataSource[indexPath.row], title: "Title", location: "Location", overview: "Overview: Testing Testing Testing Testing Testing Testing Testing Testing Testing Testing Testing Testing Testing Testing")
            cell = infoCell
        }
        return cell
    }
    
}
