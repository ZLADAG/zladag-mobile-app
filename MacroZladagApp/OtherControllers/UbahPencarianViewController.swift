//
//  UbahPencarianViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 24/10/23.
//

import UIKit

class UbahPencarianViewController: UIViewController {

    weak var searchControllerDelegate: SearchResultsViewController?
    
    let locationFieldView = TextFieldView(fieldTitle: "Dekat Saya", image: UIImage(named: "location-icon"), hasMapIcon: true)
    let dateFieldView = TextFieldView(fieldTitle: "", image: UIImage(named: "calendar-icon"), hasMapIcon: nil)
    lazy var kucingCount = searchControllerDelegate?.kucingCount
    lazy var anjingCount = searchControllerDelegate?.anjingCount
    let numberOfCatsAndDogsButton = NumberOfCatsAndDogsButton()
    let searchButton = SearchButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavBar()
        setupViews()
        
        numberOfCatsAndDogsButton.catLabel.text = self.kucingCount?.description
        numberOfCatsAndDogsButton.dogLabel.text = self.anjingCount?.description
        
//        dateFieldView.addTarget(self, action: #selector(presentDatePickerSheet), for: .touchUpInside)
        numberOfCatsAndDogsButton.addTarget(self, action: #selector(presentCatsAndDogSheet), for: .touchUpInside)
//        searchButton.addTarget(self, action: #selector(updateSearch), for: .touchUpInside)
    }
    
    func setupViews() {
        view.addSubview(locationFieldView)
        view.addSubview(dateFieldView)
        view.addSubview(numberOfCatsAndDogsButton)
        view.addSubview(searchButton)
        
        locationFieldView.frame = CGRect(x: 0, y: 0, width: 342, height: 44)
        locationFieldView.frame = CGRect(
            x: view.frame.midX - locationFieldView.frame.width / 2,
            y: view.frame.minY + 60,
            width: locationFieldView.frame.width,
            height: locationFieldView.frame.height
        )
        
        dateFieldView.frame = CGRect(x: 0, y: 0, width: 342, height: 44)
        dateFieldView.frame = CGRect(
            x: view.frame.midX - dateFieldView.frame.width / 2,
            y: locationFieldView.frame.maxY + 8,
            width: dateFieldView.frame.width,
            height: dateFieldView.frame.height
        )
        
        searchButton.frame = CGRect(
            x: view.frame.midX - dateFieldView.frame.width / 2,
            y: dateFieldView.frame.maxY + 16,
            width: 342,
            height: 44
        )
        
        numberOfCatsAndDogsButton.frame = CGRect(
            x: dateFieldView.frame.maxX - 100,
            y: dateFieldView.frame.minY,
            width: 85, // 93?
            height: 44
        )
    }
    
    func setupNavBar() {
        let navView = UIView()
        navView.frame = CGRect(x: 0, y: 0, width: 354, height: 32)
        
        
        let navLabel = UILabel()
        navLabel.text = "Ubah Pencarian"
        navLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        navLabel.frame = CGRect(x: 0, y: (32 - 23) / 2, width: 290, height: 23)
        
        navView.addSubview(navLabel)
        
        let closeButton = UIButton()
        let closeButtonImageView = UIImageView(image: UIImage(named: "sheet-close-button"))
        closeButtonImageView.contentMode = .scaleAspectFit
        closeButtonImageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        closeButtonImageView.layer.opacity = 0.8
        closeButton.addSubview(closeButtonImageView)
        closeButton.frame = CGRect(x: navView.frame.maxX - 32, y: 0, width: 32, height: 32)
        navView.addSubview(closeButton)
        
        closeButton.addTarget(self, action: #selector(closeSheet), for: .touchUpInside)
        navigationItem.titleView = navView
    }
    
    @objc func closeSheet() {
        dismiss(animated: true)
    }
    
    @objc func presentCatsAndDogSheet() {
        let vc  = CatsAndDogsCounterViewController()
        let navVc = UINavigationController(rootViewController: vc)
        vc.controllerDelegate = self.searchControllerDelegate
        vc.ubahControllerDelegate = self
        vc.anjingCount = self.anjingCount ?? 99
        vc.kucingCount = self.kucingCount ?? 99
        
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 10
            sheet.detents = [
                .custom(resolver: { context in
                    0.4 * context.maximumDetentValue
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        self.navigationController?.present(navVc, animated: true, completion: nil)
    }
    
    
    

}
