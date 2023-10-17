//
//  MainHeaderCollectionReusableView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 08/10/23.
//

import UIKit

class MainHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "MainHeaderCollectionReusableView"
    
    var delegate: HomeViewController?
    
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
    let locationFieldView = TextFieldView(fieldTitle: "Dekat Saya", image: UIImage(named: "location-icon"), hasMapIcon: true)
    let dateFieldView = TextFieldView(fieldTitle: "", image: UIImage(named: "calendar-icon"), hasMapIcon: nil)
    public var kucingCount = 0
    public var anjingCount = 0
    let numberOfCatsAndDogsButton = NumberOfCatsAndDogsButton()
    
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
    
    var startDate: Date?
    var endDate: Date?
    
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
        addSubview(numberOfCatsAndDogsButton)
        addSubview(searchButton)
        
        addSubview(promoView)
        
        setupFrames()
        
        searchButton.addTarget(self, action: #selector(goToSearchResultsViewController), for: .touchUpInside)
        
        dateFieldView.addTarget(self, action: #selector(presentDatePickerSheet), for: .touchUpInside)
        
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
        
        numberOfCatsAndDogsButton.frame = CGRect(
            x: dateFieldView.frame.maxX - 100,
            y: dateFieldView.frame.minY,
            width: 85, // 93?
            height: 44
        )
        
        promoView.frame = CGRect(x: 0, y: lowerView.frame.maxY, width: frame.width, height: 36)
        
    }
    
}

extension MainHeaderCollectionReusableView {
    @objc func goToSearchResultsViewController() {
        let vc = SearchResultsViewController()
//        let vc = MencobaSheetViewController()

        var petCategories = [String]()
        if self.anjingCount > 0 {
            petCategories.append("Anjing")
        }
        
        if self.kucingCount > 0 {
            petCategories.append("Kucing")
        }
        
        var params: String = ""
        if petCategories.count == 1 {
            if let queryParam = "petCategories[]=\(petCategories[0])".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                params += queryParam
            }
        } else if petCategories.count == 2 {
            if let queryParam = "petCategories[]=\(petCategories[0])".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                params += queryParam
            }
            
            if let queryParam = "&petCategories[]=\(petCategories[1])".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                params += queryParam
            }
        }
        
        let group = DispatchGroup()
        group.enter()
        APICaller.shared.getBoardingsSearch(params: params) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let response):
                vc.viewModels = response.data.compactMap({ boarding in
                    return BoardingsCellViewModel(
                        name: boarding.name,
                        address: boarding.address,
                        slug: boarding.slug,
                        description: boarding.description,
                        subdistrictName: boarding.subdistrict.name,
                        districtName: boarding.subdistrict.district.name,
                        cityName: boarding.subdistrict.district.city.name,
                        provinceName: boarding.subdistrict.district.city.province.name,
                        boardingCategoryName: boarding.boarding_category.name,
                        imageURLString: boarding.boarding_images[0].path,
                        facilities: boarding.facilities,
                        services: boarding.services,
                        boarding_policy: boarding.boarding_policy,
                        created_at: boarding.boarding_policy.created_at,
                        updated_at: boarding.boarding_policy.updated_at
                    )
                })

                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
        
        self.delegate?.navigationController?.pushViewController(vc, animated: true)
        group.notify(queue: .main) {
            vc.collectionView.reloadData()

        }
    }
    
    @objc func presentCatsAndDogSheet() {
        let vc  = CatsAndDogsCounterViewController()
        vc.mainHeaderDelegate = self
        vc.kucingCount = self.kucingCount
        vc.anjingCount = self.anjingCount
        
        let navVc = UINavigationController(rootViewController: vc)
        
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 10
            sheet.detents = [
                .custom(resolver: { context in
                    0.4 * context.maximumDetentValue
                })
//                .medium()
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        delegate?.navigationController?.present(navVc, animated: true, completion: nil)
    }
    
    @objc func presentDatePickerSheet() {
        let vc  = DatePickerViewController()
        vc.delegate = self
        
        let navVc = UINavigationController(rootViewController: vc)
        
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 10
            sheet.detents = [
                .custom(resolver: { context in
                    0.83 * context.maximumDetentValue
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        if (startDate != nil) {
            vc.startDateLabel.text = String(vc.getDate(self.startDate!))
//            print(startDate)
        } else {
            vc.startDate = nil
        }
        
        if (endDate != nil) {
            vc.endDateLabel.text = String(vc.getDate(self.endDate!))
//            print(endDate)
        } else {
            vc.endDate = nil
        }
        
        delegate?.navigationController?.present(navVc, animated: true, completion: nil)
    }
}


