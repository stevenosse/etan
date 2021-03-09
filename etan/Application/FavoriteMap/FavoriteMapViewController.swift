//
//  FavoriteMapViewController.swift
//  etan
//
//  Created by Nossedjou Steve on 09/03/2021.
//

import UIKit
import MapKit

class FavoriteMapViewController: UIViewController {
    @IBOutlet weak var favoritesMap: MKMapView!
    
    lazy var viewModel: FavoriteMapViewModel = {
        return FavoriteMapViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Carte des favoris"
        
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }

    func fetchData() {
        let favorites = viewModel.getFavorites()
        for favorite in favorites {
            let annotation = MKPointAnnotation()
            let stopName = (favorite.value(forKeyPath: "stopName") as! String)
            let latitude = (favorite.value(forKeyPath: "latitude") as! Double)
            let longitude = (favorite.value(forKeyPath: "longitude") as! Double)
            annotation.title = stopName
             //You can also add a subtitle that displays under the annotation such as
             annotation.subtitle = "One day I'll go here..."
            annotation.coordinate = CLLocationCoordinate2D(latitude: longitude, longitude: latitude)
            
            favoritesMap.addAnnotation(annotation)
        }
    }
}
