//
//  SearchLocationViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 09/12/23.
//

import UIKit
import GooglePlaces
import Foundation

struct PredictionResult {
    let result: NSAttributedString
    let type: String
    let placeID: String
}

class SearchLocationViewController: UIViewController {
    
    // THE PRESENTING VIEW CONTROLLERS
    weak var mainView: MainHeaderCollectionReusableView?
    weak var ubahViewController: UbahPencarianViewController?
    
    var resultText: UITextView?
    var fetcher: GMSAutocompleteFetcher?
    var predictions = [PredictionResult]()
    
    // MARK: UI COMPONENTS
    let textFieldContainerView = UIView()
    let textField = UITextField()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light
        
        LocationManager.shared.requestPermission()
        
        LocationManager.shared.completion = { isAuthorized in
            switch isAuthorized {
            case .notDetermied:
                break
            case .denied:
                self.dismiss(animated: true)
            case .authorizedWhenInUse:
                break
            }
        }
        
        setupGMSAutocompleteFetcher()
        setupNavBar()
        setupTextField()
        setupTableView()
        
    }
    
    private func setupNavBar() {
        let navView = UIView()
        navView.frame = CGRect(x: 0, y: 0, width: 354, height: 32)
        navView.backgroundColor = .clear
        
        let navLabel = UILabel()
        navLabel.text = "Pilih Lokasi"
        navLabel.backgroundColor = .clear
        navLabel.textColor = .textBlack
        navLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        navLabel.frame = CGRect(x: 0, y: (32 - 23) / 2, width: 290, height: 23)
        
        navView.addSubview(navLabel)
        
        let closeButton = UIButton()
        let closeButtonImageView = UIImageView(image: UIImage(named: "close-button-nobg"))
        closeButtonImageView.contentMode = .scaleAspectFit
        closeButtonImageView.backgroundColor = .clear
        closeButtonImageView.layer.opacity = 0.45
        closeButtonImageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        closeButton.addSubview(closeButtonImageView)
        closeButton.frame = CGRect(x: navView.frame.maxX - 32, y: 0, width: 32, height: 32)
        navView.addSubview(closeButton)
        
        closeButton.addTarget(self, action: #selector(closeSheet), for: .touchUpInside)
        navigationItem.titleView = navView
    }
    
    private func setupTextField() {
        let iconImageView = UIImageView(image: UIImage(named: "location-icon"))
        
        view.addSubview(textFieldContainerView)
        view.addSubview(iconImageView)
        view.addSubview(textField)
        
        // CONTAINER
        textFieldContainerView.layer.cornerRadius = 4
        textFieldContainerView.layer.masksToBounds = true
        textFieldContainerView.layer.borderColor = UIColor.customOrange.cgColor
        textFieldContainerView.backgroundColor = .clear
        textFieldContainerView.layer.borderWidth = 1
        
        // ICON
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.backgroundColor = .clear
        
        // UI TEXTFIELD
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.autoresizingMask = .flexibleWidth
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.attributedPlaceholder = NSAttributedString(string: "Cari nama kota, area, dll.")
        textField.font = .systemFont(ofSize: 14, weight: .semibold)
        textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        textFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textFieldContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldContainerView.widthAnchor.constraint(equalToConstant: 342),
            textFieldContainerView.heightAnchor.constraint(equalToConstant: 44),
            
            iconImageView.centerYAnchor.constraint(equalTo: textFieldContainerView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: 8),
            iconImageView.widthAnchor.constraint(equalToConstant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 16),
            
            textField.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: 5),
            textField.bottomAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: -5),
            textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 4),
            textField.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -8)
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = .clear
        
        tableView.register(DekatSayaTableViewCell.self, forCellReuseIdentifier: DekatSayaTableViewCell.identifier)
        tableView.register(AutocompleteResultTableViewCell.self, forCellReuseIdentifier: AutocompleteResultTableViewCell.identifier)
        tableView.register(EmptyAutocompleteResultTableViewCell.self, forCellReuseIdentifier: EmptyAutocompleteResultTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func closeSheet() {
        self.mainView?.delegate?.dismiss(animated: true)

//        if let controllerDelegate {
//            dismiss(animated: true)
//        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        fetcher?.sourceTextHasChanged(textField.text!)
    }
    
    // MARK: GOOGLE MAPS
    private func setupGMSAutocompleteFetcher() {
        // THESE ARE CODES PROVIDED FROM: https://developers.google.com/maps/documentation/places/ios-sdk/autocomplete#use_the_fetcher
        
        // Set up the autocomplete filter.
        let filter = GMSAutocompleteFilter()
        filter.countries = ["ID"]
        filter.types = ["locality", "administrative_area_level_1", "administrative_area_level_2", "sublocality", "point_of_interest"]
        
        /*
         locality, administrative_area_level_1, administrative_area_level_2 = Kota
         sublocality = Kel/Desa
         point_of_interest = Area
         */

        // Create a new session token.
        let token: GMSAutocompleteSessionToken = GMSAutocompleteSessionToken.init()

        // Create the fetcher.
        self.fetcher = GMSAutocompleteFetcher(filter: filter)
        self.fetcher?.delegate = self
        self.fetcher?.provide(token)
    }
    
    private func setupLoadingScreen() {
        
        let loadingScreen = UIView()
        loadingScreen.backgroundColor = .lightGray
        loadingScreen.layer.opacity = 0.2
        
        let spinner: UIActivityIndicatorView = {
            let spinner = UIActivityIndicatorView()
            spinner.style = .large
            spinner.color = .customOrange
            spinner.backgroundColor = .clear
            return spinner
        }()
        
        view.addSubview(loadingScreen)
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        loadingScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingScreen.topAnchor.constraint(equalTo: view.topAnchor),
            loadingScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: loadingScreen.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: loadingScreen.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        spinner.startAnimating()
    }
    
}

extension SearchLocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.textField.text!.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DekatSayaTableViewCell.identifier, for: indexPath) as! DekatSayaTableViewCell
            return cell
        } else {
            if self.predictions.count > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: AutocompleteResultTableViewCell.identifier, for: indexPath) as! AutocompleteResultTableViewCell
                cell.configure(
                    text: self.predictions[indexPath.row].result,
                    type: self.predictions[indexPath.row].type
                )
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: EmptyAutocompleteResultTableViewCell.identifier, for: indexPath) as! EmptyAutocompleteResultTableViewCell
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.textField.text!.count == 0 {
            
            if let userLocation = LocationManager.shared.userLocation {
                let userLocationCoordinate = LocationCoordinate(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude
                )
                AppAccountManager.shared.chosenLocationCoordinate = userLocationCoordinate
                AppAccountManager.shared.chosenLocationName = "Dekat Saya"
                DispatchQueue.main.async {
                    self.mainView?.locationFieldView.thisLabel.text = "Dekat Saya"
                    self.ubahViewController?.locationFieldView.thisLabel.text = "Dekat Saya"
                    self.ubahViewController?.searchControllerDelegate?.locationLabel.text = "Dekat Saya"
                }
                print("DEKAT SAYA: \(AppAccountManager.shared.chosenLocationCoordinate?.latitude ?? 99), \(AppAccountManager.shared.chosenLocationCoordinate?.longitude ?? 99)")
            }
//            self.mainView?.delegate?.dismiss(animated: true)
            self.dismiss(animated: true)
        } else {
            if self.predictions.count > 0 {
                let placeID: String = self.predictions[indexPath.row].placeID
                print(">> ID", placeID)
                
                APICaller.shared.getGooglePlaceIDGeocodingResult(placeID: placeID) { [weak self] result in
                    guard let strongSelf = self else { return }
                    
                    DispatchQueue.main.async {
                        strongSelf.setupLoadingScreen()
                    }
                    
                    switch result {
                    case .success(let response):
                        let coordinate = LocationCoordinate(
                            latitude: response.results.first?.geometry.location.lat ?? 99,
                            longitude: response.results.first?.geometry.location.lng ?? 99
                        )
                        AppAccountManager.shared.chosenLocationCoordinate = coordinate
                        AppAccountManager.shared.chosenLocationName = strongSelf.predictions[indexPath.row].result.string
                        
                        DispatchQueue.main.async {
                            strongSelf.mainView?.locationFieldView.thisLabel.text = strongSelf.predictions[indexPath.row].result.string
                            strongSelf.ubahViewController?.locationFieldView.thisLabel.text = strongSelf.predictions[indexPath.row].result.string
                            strongSelf.ubahViewController?.searchControllerDelegate?.locationLabel.text = strongSelf.predictions[indexPath.row].result.string
                        }
                        
                        print("CHOSEN COORDINATE: \(AppAccountManager.shared.chosenLocationCoordinate?.latitude ?? 99), \(AppAccountManager.shared.chosenLocationCoordinate?.longitude ?? 99)")
                        break
                    case .failure(let error):
                        print("ERROR when Geocoding PlaceID: \(error)")
                        break
                    }
                    
                    DispatchQueue.main.async {
//                        strongSelf.mainView?.delegate?.dismiss(animated: true)
//                        strongSelf.ubahViewController?.dismiss(animated: true)
                        strongSelf.dismiss(animated: true)
                    }
                }
                
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.predictions.count > 0 {
            return self.predictions.count
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.textField.text!.count == 0 {
            return 24 + 24 - 8
        } else {
            return 51
        }
    }
       
}

extension SearchLocationViewController: GMSAutocompleteFetcherDelegate {
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        
        self.predictions = predictions.compactMap({ prediction in
            return PredictionResult(
                result: prediction.attributedFullText,
                type: prediction.types.first ?? "Landmark",
                placeID: prediction.placeID
            )
        })
        self.predictions = self.predictions.sorted(by: { lhs, rhs in
            return lhs.type > rhs.type
        })
        
        self.tableView.reloadData()
    }

    func didFailAutocompleteWithError(_ error: Error) {
        print("\nERROR IN GMS AUTOCOMPLETE FETCHER:", error.localizedDescription)
    }
    
}

extension SearchLocationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

/*
 prediction.description: GMSAutocompletePrediction 0x600001756080: "AEON MALL Sentul City, Jalan MH. Thamrin, Citaringgul, Bogor Regency, West Java, Indonesia", id: ChIJA7Lx3ubGaS4R-Ubo3zfty2g, types: (
     "shopping_mall",
     "point_of_interest",
     establishment
 )

 prediction.attributedFullText: A{
     GMSAutocompleteMatch = "<GMSAutocompleteMatchFragment: 0x60000027d3a0>";
 }EON MALL Sentul City, Jalan MH. Thamrin, Citaringgul, Bogor Regency, West Java, Indonesia{
 }

 prediction.attributedSecondaryText: Optional(Jalan MH. Thamrin, Citaringgul, Bogor Regency, West Java, Indonesia{
 })

 types:
 shopping_mall
 point_of_interest
 establishment
 */

