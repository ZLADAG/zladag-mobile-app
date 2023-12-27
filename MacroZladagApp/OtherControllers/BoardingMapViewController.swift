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
    
    let name: String
    let lat: Double
    let long: Double
    
    var mapView : MKMapView!
    
    /// u/ passing data
    var mapViewAttr = MapViewAttributes()
    
    init(name: String, lat: Double, long: Double) {
        self.name = name
        self.lat = lat
        self.long = long
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init mapview attributes
        mapViewAttr.annotationTitle = self.name
        mapViewAttr.latitude =  self.lat
        mapViewAttr.longitude = self.long
        
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
        mapView.isUserInteractionEnabled = true
        
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(placeLatValue, placeLongValue)
        
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = mapViewAttr.annotationTitle

        self.mapView.addAnnotation(objectAnnotation)        
        
        mapView.isZoomEnabled = false
        mapView.isPitchEnabled = false
        mapView.isRotateEnabled = false
        mapView.isScrollEnabled = false
        mapView.isMultipleTouchEnabled = false
        
        // Create a UITapGestureRecognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewTapped(_:)))
        
        // Add the UITapGestureRecognizer to the mapView
        mapView.addGestureRecognizer(tapGesture)
        
        
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
    
    
    private func presentOpenMapUrlAlert(_ title: String, _ message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        // Cancel action
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .destructive,
            handler: nil
        )
        alertController.addAction(cancelAction)
        
        
        // OK Acrion
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { (action) in
                // Handle the "Open Website" button tap
                self.openMapUrl(self.mapViewAttr.latitude, self.mapViewAttr.longitude)
            }
        )
        alertController.addAction(okAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    private func openMapUrl(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        if (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)) {
            // Google Maps is installed, open it with the coordinates
            let _: () = openUrl("comgooglemaps://?q=\(latitude),\(longitude)")
            
        } else {
            // Google Maps is not installed, open it in a web browser
            let _: () = openUrl("https://www.google.com/maps?q=\(latitude),\(longitude)")
        }
    }
    
    private func openUrl(_ urlAddress: String) {
        if let url = URL(string: urlAddress) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
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
    
    // MARK: Selector Functions
    @objc func mapViewTapped(_ sender: UITapGestureRecognizer) {
        presentOpenMapUrlAlert("Open Google Maps", "You will be directed to google maps")
        
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
