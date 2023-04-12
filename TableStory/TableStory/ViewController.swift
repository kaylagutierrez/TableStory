//
//  ViewController.swift
//  TableStory
//
//  Created by Gutierrez, Kayla M on 3/22/23.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "Bar 1919", neighborhood: "Blue Star Arts Complex", desc: "A trendy establishment with a speakeasy vibe, where nicely-dressed bartenders concoct award-winning cocktails.", lat: 29.409880, long: -98.495750, imageName: "1919"),
    Item(name: "Havana Bar", neighborhood: "Downtown", desc: "An intimate candle-lit bar featuring high end cocktails served in an old hotel basement.", lat: 29.430800, long: -98.489870, imageName: "havana"),
    Item(name: "The Modernist", neighborhood: "The Pearl", desc: "A speakeasy-style cocktail bar with 1960's Mid Century vibes & specialty drinks (and mocktails!)", lat: 29.443000, long: -98.474830, imageName: "modernist"),
    Item(name: "Bar Loretta", neighborhood: "King William District", desc: "A rustic bar & restaurant serving up modern American eats & creative cocktails. ", lat: 29.413990, long: -98.491240, imageName: "loretta"),
    Item(name: "The Moons Daughters", neighborhood: "The Riverwalk", desc: "A captivating rooftop lounge that overlooks downtown San Antonio. Offers custom drinks & bar bites with both indoor & outdoor seating.", lat: 29.431800, long: -98.489140, imageName: "moonsdaughters")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var theTable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
   }


   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
       let item = data[indexPath.row]
       cell?.textLabel?.text = item.name
       let image = UIImage(named: item.imageName)
                    cell?.imageView?.image = image
                    cell?.imageView?.layer.cornerRadius = 10
                    cell?.imageView?.layer.borderWidth = 5
                    cell?.imageView?.layer.borderColor = UIColor.white.cgColor
       return cell!
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    }
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "ShowDetailSegue" {
                  if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                      // Pass the selected item to the detail view controller
                      detailViewController.item = selectedItem
                  }
              }
          }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
        let coordinate = CLLocationCoordinate2D(latitude: 29.431800, longitude: -98.489140)
               let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
               mapView.setRegion(region, animated: true)
               
            // loop through the items in the dataset and place them on the map
                for item in data {
                   let annotation = MKPointAnnotation()
                   let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                   annotation.coordinate = eachCoordinate
                       annotation.title = item.name
                       mapView.addAnnotation(annotation)
                       }

             
        
        
        // Do any additional setup after loading the view.
    }


}

