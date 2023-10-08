//
//  MainHeaderCollectionReusableView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 08/10/23.
//

import UIKit

class MainHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "MainHeaderCollectionReusableView"
    
    var delegate: UIViewController? = nil
    
    let mainHeaderContainerView = MainHeaderContainerView()
    let upperView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .customOrange
        return uiView
    }()
    
    let lowerView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .customGray
        return uiView
    }()
    
    let pawBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "paw-bg")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Cari penginapan yang cocok untuk anabul kamu!"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let searchContainerView = SearchContainerView()
    let locationFieldView = TextFieldView(image: UIImage(named: "location-icon"), hasMapIcon: true)
    let dateFieldView = TextFieldView(image: UIImage(named: "calendar-icon"), hasMapIcon: nil)
    let numberOfCatsAndDogsButton = NumberOfCatsAndDogsButton()
    
    lazy var locationTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .clear
        textField.text = "Dekat saya"
        textField.textColor = .gray
        textField.delegate = self
        
        // Display frame.
//        textField.borderStyle = .roundedRect
        // Add clear button.
        textField.clearButtonMode = .whileEditing
        
        return textField
    }()

    lazy var dateTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .clear
        textField.text = "Tanggal"
        textField.textColor = .gray
        textField.delegate = self
        
        // Display frame.
//        textField.borderStyle = .roundedRect
        
        // Add clear button.
        textField.clearButtonMode = .whileEditing
        
        return textField
    }()
    
    let searchButton = SearchButton()
    
    let promoView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .customGray
        
        let label = UILabel()
        label.text = "Promo Untukmu!"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.frame = CGRect(x: 24, y: 0, width: 145, height: 20)
        
        uiView.addSubview(label)
        
        return uiView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(mainHeaderContainerView)
        addSubview(upperView)
        addSubview(lowerView)
        addSubview(pawBackground)
        addSubview(sectionLabel)
        addSubview(searchContainerView)
        addSubview(locationFieldView)
        addSubview(dateFieldView)
        addSubview(searchButton)
        addSubview(numberOfCatsAndDogsButton)

        //textfields
        addSubview(locationTextField)
        addSubview(dateTextField)
        
        addSubview(promoView)
        
        setupFrames()
        
        searchButton.addTarget(self, action: #selector(goToSearchResultsViewController), for: .touchUpInside)
        numberOfCatsAndDogsButton.addTarget(self, action: #selector(presentCatsAndDogSheet), for: .touchUpInside)
    }
    
    func setupFrames() {
        mainHeaderContainerView.frame = bounds
        upperView.frame = CGRect(x: 0, y: -600, width: frame.width, height: (frame.height / 2) + 600) // SEBELUM: upperView.frame = CGRect(x: 0, y: -200, width: frame.width, height: frame.height / 2)
        lowerView.frame = CGRect(x: upperView.frame.minX, y: upperView.frame.maxY, width: frame.width, height: frame.height / 2)
        
        pawBackground.frame = CGRect(x: frame.maxX - 239, y: -100, width: 247, height: 284)
        
        searchContainerView.frame = CGRect(
            x: frame.midX - searchContainerView.thisWidth / 2,
            y: frame.midY - searchContainerView.thisHeight / 2,
            width: searchContainerView.thisWidth,
            height: searchContainerView.thisHeight
        )
        
        sectionLabel.frame = CGRect(x: 24, y: searchContainerView.frame.minY - 12 - 50, width: 326, height: 50)

        
        locationFieldView.frame = CGRect(
            x: frame.midX - locationFieldView.thisWidth / 2,
            y: searchContainerView.frame.minY + 22,
            width: locationFieldView.thisWidth,
            height: locationFieldView.thisHeight
        )
        
        dateFieldView.frame = CGRect(
            x: frame.midX - dateFieldView.thisWidth / 2,
            y: locationFieldView.frame.maxY + 8,
            width: locationFieldView.thisWidth,
            height: dateFieldView.thisHeight
        )
        
        searchButton.frame = CGRect(
            x: frame.midX - dateFieldView.thisWidth / 2,
            y: dateFieldView.frame.maxY + 16,
            width: 294,
            height: 44
        )
        
        locationTextField.frame = CGRect(
            x: locationFieldView.frame.minX + 32,
            y: locationFieldView.frame.minY,
            width: 230,
            height: 44
        )
        
        dateTextField.frame = CGRect(
            x: dateFieldView.frame.minX + 32,
            y: dateFieldView.frame.minY,
            width: 250 - 90,
            height: 44
        )
        
        numberOfCatsAndDogsButton.frame = CGRect(
            x: dateFieldView.frame.maxX - 100,
            y: dateFieldView.frame.minY,
            width: 85, // 93?
            height: 44
        )
        
        promoView.frame = CGRect(x: 0, y: lowerView.frame.maxY, width: frame.width, height: 36)
        
    }
    
}

extension MainHeaderCollectionReusableView: UITextFieldDelegate {
    @objc func goToSearchResultsViewController() {
        let vc = SearchResultsViewController()
        
        APICaller.shared.getBoardings { result in
            switch result {
            case .success(let response):
                vc.viewModels = response.data.compactMap({ boarding in
                    return BoardingsCellViewModel(
                        name: boarding.name,
                        address: boarding.address,
                        slug: boarding.slug,
                        subdistrictName: boarding.subdistrict.name,
                        districtName: boarding.subdistrict.district.name,
                        cityName: boarding.subdistrict.district.city.name,
                        boardingCategoryName: boarding.boarding_category.name
                    )
                })
                
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
        delegate?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func presentCatsAndDogSheet() {
        let vc  = CatsAndDogsCounterViewController()
        vc.delegate = self
        let navVc = UINavigationController(rootViewController: vc)
        
        vc.modalPresentationStyle = .pageSheet
//        navVc.isModalInPresentation = true
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 10
            sheet.detents = [
                .custom(resolver: { context in
                    0.35 * context.maximumDetentValue
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        delegate?.navigationController?.present(navVc, animated: true, completion: nil)
    }
}


