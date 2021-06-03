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
    
    func reformatDate(dateToBeFormatted: String) -> String {
        let testDate = dateToBeFormatted

        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

        let dateTime = testDate.components(separatedBy: "T")
        let date = dateTime[0]
        let dateParts = date.components(separatedBy: "-")
        let year = Int(dateParts[0])
        let month = Int(dateParts[1])!
        let day = Int(dateParts[2])

        let times = dateTime[1]
        let timez = times.components(separatedBy: "Z")
        let time = timez[0]
        let timeParts = time.components(separatedBy: ":")
        var ampm = "am"
        var hour = Int(timeParts[0])
        if hour! > 12 {
            hour! -= 12
            ampm = "pm"
        }
        let minute = Int(timeParts[1])!
        let minutes = String(format: "%02d", minute)
        

        //Ex.) May 4, 2015 at 4:30pm
        let formattedString = "\(months[(month-1)]) \(day!), \(year!) at \(hour!):\(minutes)\(ampm)"

        return formattedString
    }
    
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
            //API Call
            self.cardService.fetchDetails { Cards in
                if let Cards = Cards {
                    for Card in Cards {
                        var memory = MemCard(id: 0, image: "N/A", date: "N/A", title: "N/A", location: "N/A", overview: "N/A", imageData: Data())
                        memory.id = Card.id
                        memory.image = Card.image ?? "placeHolder"
                        memory.date = self.reformatDate(dateToBeFormatted: Card.date)
                        memory.title = Card.title
                        memory.location = Card.locationline1
                        memory.overview = Card.description
                        //Add Image Data
                        let strURL = memory.image
                        let imageURL = URL(string: strURL)!
                        var imageData: Data = Data()
                        do {
                            imageData = try Data(contentsOf: imageURL)
                            memory.imageData = imageData
                        } catch  {
                            print(error)
                            imageData = (UIImage(named: "NoMoon")?.pngData())!
                            memory.imageData = imageData
                        }
                        self.memCards.append(memory)
                    }
                }
                self.collectionView.reloadData()
            }
            //Save Core Data Values
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
                    MemoryCard.setValue(self.memCards[i].imageData, forKey: "imageData")
                }
                do {
                    try context.save()
                } catch {
                    print("Save Error")
                }
            }
        } else {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MemoryCard")
            let idSort = NSSortDescriptor(key:"id", ascending:true)
            request.sortDescriptors = [idSort]
            do {
                let result = try context.fetch(request)
                for MemoryCard in result as! [NSManagedObject] {
                    var memory = MemCard(id: 0, image: "N/A", date: "N/A", title: "N/A", location: "N/A", overview: "N/A", imageData: Data())
                    memory.id = MemoryCard.value(forKey: "id") as! Int
                    memory.image = MemoryCard.value(forKey: "image") as! String
                    memory.date = MemoryCard.value(forKey: "date") as! String
                    memory.title = MemoryCard.value(forKey: "title") as! String
                    memory.location = MemoryCard.value(forKey: "location") as! String
                    memory.overview = MemoryCard.value(forKey: "overview") as! String
                    memory.imageData = MemoryCard.value(forKey: "imageData") as! Data
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
        for memoryCard in memCards {
            if memoryCard.id == (indexPath.row+1) {
                let dv = storyboard?.instantiateViewController(identifier: "DetailView") as! DetailView
                dv.CardView = memoryCard
                navigationController?.pushViewController(dv, animated: true)
            }
        }
    }
}

extension MasterView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CardCell {
            
            infoCell.setData(image: UIImage(data: memCards[indexPath.row].imageData)!, date: memCards[indexPath.row].date, title: memCards[indexPath.row].title, location: memCards[indexPath.row].location, overview: memCards[indexPath.row].overview)
            
            cell = infoCell
        }
        return cell
    }
    
}
