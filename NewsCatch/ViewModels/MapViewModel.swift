//
//  MapViewModel.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import Foundation
import CoreLocation

class MapViewModel : NSObject , CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var location : CLLocationCoordinate2D?
    
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    
    func startLocationUpdates() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        print("Plats uppdaterad \(locations)")
    }
    
    
    
    
    
}
