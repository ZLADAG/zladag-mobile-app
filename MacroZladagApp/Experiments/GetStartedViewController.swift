//
//  GetStartedViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 12/12/23.
//

import UIKit
import CoreLocation
import GooglePlaces

class GetStartedViewController: UIViewController {
    
    var locationManager: CLLocationManager?
        
    let nameLabel = UILabel()
    let addressLabel = UILabel()
    let button = UIButton()
    
    var isLocationAuthorized = false
    
    private var placesClient: GMSPlacesClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        
//        DispatchQueue.main.async {
//            if CLLocationManager.locationServicesEnabled() {
//                self.placesClient = GMSPlacesClient.shared()
//            }
//            
//        }
        
        setupLocationManager()
        
        setupNameLabel()
        setupAddressLabel()
        setupButton()
        
    }
    
    private func setupLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        
//        print(">>", self.locationManager?.authorizationStatus
        self.locationManager?.requestWhenInUseAuthorization()
        
        
    }
    
    private func setupNameLabel() {
        view.addSubview(nameLabel)
        
        nameLabel.text = "oke"
        nameLabel.textColor = .textBlack
        nameLabel.font = .systemFont(ofSize: 14, weight: .regular)
        nameLabel.sizeToFit()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: view.width),
            nameLabel.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func setupAddressLabel() {
        view.addSubview(addressLabel)
        
        addressLabel.text = "addressLabel"
        addressLabel.textColor = .textBlack
        addressLabel.font = .systemFont(ofSize: 14, weight: .regular)
        addressLabel.sizeToFit()
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addressLabel.widthAnchor.constraint(equalToConstant: view.width),
            addressLabel.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func setupButton() {
        view.addSubview(button)
        
        button.backgroundColor = .red
        button.setTitle("click me", for: .normal)
        button.addTarget(self, action: #selector(onClickButton), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 150),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    @objc private func onClickButton() {
        let placeFields: GMSPlaceField = [.name, .formattedAddress]
        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] (placeLikelihoods, error) in
        guard let strongSelf = self else {
            return
        }

        guard error == nil else {
            print("Current place error: \(error?.localizedDescription ?? "")")
            return
        }

        guard let place = placeLikelihoods?.first?.place else {
            strongSelf.nameLabel.text = "No current place"
            strongSelf.addressLabel.text = ""
            return
        }

        strongSelf.nameLabel.text = place.name
        strongSelf.addressLabel.text = place.formattedAddress
        }
    }
    
}

extension GetStartedViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("When user did not yet determined")
            self.isLocationAuthorized = false
        case .restricted:
            print("Restricted by parental control")
            self.isLocationAuthorized = false
        case .denied:
            print("When user select option Dont't Allow")
            self.isLocationAuthorized = false
        case .authorizedWhenInUse:
            print("When user select option Allow While Using App or Allow Once")
            self.isLocationAuthorized = true
        case .authorizedAlways:
            print("When user select option Change to Always Allow")
            self.isLocationAuthorized = true
        default:
            print("default")
            self.isLocationAuthorized = false
        }
    }
    
    
}
