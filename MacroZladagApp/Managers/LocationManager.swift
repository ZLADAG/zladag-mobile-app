//
//  LocationManager.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 12/12/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    enum CustomAuthorizationStatus {
        case notDetermied
        case denied
        case authorizedWhenInUse
    }
    
    static let shared = LocationManager()
    var manager: CLLocationManager!
    static let googleMapsAPIKey = "AIzaSyCQDBAxzCmbdbHs4y1mTxH5FkI4pNuRZ0U"
    var completion: ((CustomAuthorizationStatus) -> ())?
    var customAuthorizationStatus: CustomAuthorizationStatus = .notDetermied
    var userLocation: CLLocation?
    
    private override init() {
        super.init()
        manager = CLLocationManager()
        manager.delegate = self
    }
    
    public func requestPermission() {
        manager.requestWhenInUseAuthorization()
        self.completion?(self.customAuthorizationStatus)
    }
    
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        defer {
            self.completion?(self.customAuthorizationStatus)
        }
        
        switch manager.authorizationStatus {
        
        case .notDetermined:
            print(".notDetermined")
            self.customAuthorizationStatus = .notDetermied
        case .restricted:
            print(".restricted")
            self.customAuthorizationStatus = .denied
        case .denied: // dont allow
            print(".denied")
            self.customAuthorizationStatus = .denied
            break
        case .authorizedAlways:
            print(".authorizedAlways")
            self.customAuthorizationStatus = .authorizedWhenInUse
            manager.startUpdatingLocation()
        case .authorizedWhenInUse: // allow once
            print(".authorizedWhenInUse")
            self.customAuthorizationStatus = .authorizedWhenInUse
            manager.startUpdatingLocation()
        default:
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations counts >>", locations.count)
        guard let location = locations.first else { return }
        
        let userLocationCoordinate = LocationCoordinate(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        
        self.userLocation = location
        AppAccountManager.shared.chosenLocationCoordinate = userLocationCoordinate
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
