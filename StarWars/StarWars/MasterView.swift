//
//  MasterView.swift
//  StarWars
//
//  Created by Mariano Manuel on 5/25/21.
//

import UIKit
import CoreData

class MasterView: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let cardService = CardService()
    var memCards: [MemCard] = []
    var detailCard: MemCard!
    
    override func loadView() {
        super.loadView()
        
        //Set Core Data
        var firstAppRun = true
        var airPlaneMode = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MemoryCard")
        do {
            let count = try context.count(for: request)
            if count == 10 {
                firstAppRun = false
            }
        } catch {
            print("Failed")
        }
        
        if firstAppRun && !airPlaneMode {
            self.cardService.fetchDetails { Cards in
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
            
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (_) in
                for i in 0..<self.memCards.count {
                    let entity = NSEntityDescription.entity(forEntityName: "MemoryCard", in: context)
                    let MemoryCard = NSManagedObject(entity: entity!, insertInto: context)
                    MemoryCard.setValue(self.memCards[i].id, forKey: "id")
                    MemoryCard.setValue(self.memCards[i].image, forKey: "image")
                    MemoryCard.setValue(self.memCards[i].date, forKey: "date")
                    MemoryCard.setValue(self.memCards[i].title, forKey: "title")
                    MemoryCard.setValue(self.memCards[i].location, forKey: "location")
                    MemoryCard.setValue(self.memCards[i].overview, forKey: "overview")
                }
                do {
                    try context.save()
                } catch {
                    print("Save Error")
                }
            }
        } else {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MemoryCard")
            let idSort = NSSortDescriptor(key: "id", ascending: true)
            request.sortDescriptors = [idSort]
            do {
                let result = try context.fetch(request)
                for MemoryCard in result as! [NSManagedObject] {
                    var memory = MemCard(id: 0, image: "N/A", date: "N/A", title: "N/A", location: "N/A", overview: "N/A")
                    memory.id = MemoryCard.value(forKey: "id") as! Int
                    memory.image = MemoryCard.value(forKey: "image") as! String
                    memory.date = MemoryCard.value(forKey: "date") as! String
                    memory.title = MemoryCard.value(forKey: "title") as! String
                    memory.location = MemoryCard.value(forKey: "location") as! String
                    memory.overview = MemoryCard.value(forKey: "overview") as! String
                    self.memCards.append(memory)
                }
            } catch {
                print("Failed")
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
        for Card in memCards {
            if Card.id == (indexPath.row+1) {
                detailCard = MemCard.init(id: Card.id, image: Card.image, date: Card.date, title: Card.title, location: Card.location, overview: Card.overview)
            }
        }
        let dv = storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailView
        dv.CardView = detailCard
        self.navigationController!.pushViewController(dv, animated: true)
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
                infoCell.setData(image: UIImage(data: imageData)!, date: memCards[indexPath.row].date, title: memCards[indexPath.row].title, location: memCards[indexPath.row].location, overview: memCards[indexPath.row].overview)
            } catch  {
                print(error)
                infoCell.setData(image: UIImage(named: "Test")!, date: memCards[indexPath.row].date, title: memCards[indexPath.row].title, location: memCards[indexPath.row].location, overview: memCards[indexPath.row].overview)
            }
            
            cell = infoCell
        }
        return cell
    }
    
}
