//
//  LocatioController.swift
//  WeatherAppp
//
//  Created by Mehreen Kanwal on 05.02.23.
//

import UIKit
import CoreLocation

protocol LocationControllerDelegate {
    func onLocation(locations:[CLLocation])
    func onPlacemark(placemark:CLPlacemark)
}

class LocatioController: NSObject, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var delegate : LocationControllerDelegate?
    
   
       
   public func setUpLocation(){
       locationManager.delegate = self
       locationManager.requestWhenInUseAuthorization()
       DispatchQueue.global().async { [self] in
           if (CLLocationManager.locationServicesEnabled()){
               locationManager.startUpdatingLocation()
               print("Location enabled")
           } else {
               print("Location not enabled")
           }
       }
       }
    
    
    
   public func displayLocationInfo(_ placemark: CLPlacemark?) {
            if let containsPlacemark = placemark {

                print("your location is:-",containsPlacemark)
                let locality = (containsPlacemark.locality != nil) ?  containsPlacemark.locality:""
                let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
                let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
                let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""

                print("locality  \(locality!)")
                print("postalCode  \(postalCode!)")
                print("administrativeArea  \(administrativeArea!)")
                print("country  \(country!)")
//                
            }

        }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       let userLocation :CLLocation = locations[0] as CLLocation
//
//       print("user latitude = \(userLocation.coordinate.latitude)")
//       print("user longitude = \(userLocation.coordinate.longitude)")
//

       let geocoder = CLGeocoder()
       geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
           if (error != nil){
               print("error in reverseGeocode")
           }
           let placemark = placemarks! as [CLPlacemark]
           if placemark.count > 0{
               let placemark = placemarks![0]
               self.displayLocationInfo(placemark)
               if let delegate = self.delegate {
            print("delegate has some information")
            self.delegate?.onLocation(locations: locations)
                   self.delegate?.onPlacemark(placemark: placemark)
           
        }

           }
       }

//   }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
//      {
//
//          let location = locations.last! as CLLocation
//
//          let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//                print (center)
//      }
         
    
              
    }
}

