//
//  BoardingMapViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 17/10/23.
//

import UIKit
import MapKit
import CoreLocation

struct MapViewAttributes {
    var annotationTitle : String!
    var latitude : CLLocationDegrees!
    var longitude : CLLocationDegrees!
}

class BoardingMapViewController: UIViewController, MKMapViewDelegate {

    var mapView : MKMapView!
    
    /// u/ passing data
    var mapViewAttr = MapViewAttributes()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init mapview attributes
        mapViewAttr.annotationTitle = "Apple Developer Academy (Place Name)"
        mapViewAttr.latitude =  -6.301966049661171
        mapViewAttr.longitude = 106.65301280644293
        
        //Initialize the map
        createMapView()
        mapView.delegate = self
    }
    

    private func createMapView() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        let latDelta:CLLocationDegrees = 0.01
        let longDelta:CLLocationDegrees = 0.01
        let placeLatValue: CLLocationDegrees = mapViewAttr.latitude
        let placeLongValue: CLLocationDegrees = mapViewAttr.longitude
        
        let theSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let pointLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(placeLatValue, placeLongValue)
        
        let region:MKCoordinateRegion = MKCoordinateRegion(center: pointLocation, span: theSpan)
        mapView.setRegion(region, animated: true)
        
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(placeLatValue, placeLongValue)
        
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = mapViewAttr.annotationTitle
        self.mapView.addAnnotation(objectAnnotation)
                
        view.addSubview(mapView)
        setMapConstraint()
    }
    
    private func setMapConstraint(){
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 150)
        ])
        print("cek")
    }
    
    /// Keep only (don't delete) - func ok but data not accurate
    private func getAddress(latitude:Double, longitude:Double){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Location name
            if let locationName = placeMark.location {
                print("placeMark-locationName: \(locationName)")
            }
            // Street address
            if let street = placeMark.thoroughfare {
                print("placeMark-street: \(street)")
            }
            // City
            if let city = placeMark.locality {
                print("placeMark-city: \(city)")
            }
            // State
            if let state = placeMark.administrativeArea {
                print("placeMark-state: \(state)")
            }
            // Zip code
            if let zipCode = placeMark.postalCode {
                print("placeMark-zipCode: \(zipCode)")
            }
            // Country
            if let country = placeMark.country {
                print("placeMark-country: \(country)")
            }
            
            print("placeMark:\(String(describing: placeMark.name))")
        })

    }
    
    /// Keep only (don't delete) - func ok but data not accurate
    private func getLocation() {
        let geocoder = CLGeocoder()

        geocoder.geocodeAddressString("Apple Developer Academy @BINUS, Sampora, Kabupaten Tangerang, Banten") { (placemarks, error) in

          if error != nil {
            return
          } else if let placemarks = placemarks {

            if let coordinate = placemarks.first?.location?.coordinate {
               //Here's your coordinate
                self.mapViewAttr.latitude = coordinate.latitude
                self.mapViewAttr.longitude = coordinate.longitude
            }
          }
        }
    }
    

}
