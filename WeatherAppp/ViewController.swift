//
//  ViewController.swift
//  WeatherAppp
//
//  Created by Mehreen Kanwal on 04.02.23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet var temperature : UILabel!
    @IBOutlet var wind : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        App.locationController.setUpLocation()
        App.locationController.delegate = self
//        self.temperature.text = ""
//        self.wind.text = ""
       
    }
}
extension ViewController : LocationControllerDelegate {
    func onLocation(locations: [CLLocation]) {
        print("delegate passed the location")
    }
    
    func onPlacemark(placemark: CLPlacemark) {
        print("delegate passed the placemark")
    }
    
    
}
