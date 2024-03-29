//
//  HomeViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import Foundation
import UIKit

enum SectionType {
    case sectionPromo(stringOfAssets: [String]) // 0
    case sectionMakan(viewModels: [HomeCellViewModel]) // 1
    case sectionTempatBermain(viewModels: [HomeCellViewModel]) // 2
}

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    var sections = [SectionType]()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .customOrange
        spinner.backgroundColor = .clear
        return spinner
    }()
    
    let hugeView = UIView()
    
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIdx, environment in // environment ipad? etc..
            // sebanyak 3 section
            return HomeViewController.createSectionLayout(section: sectionIdx)
        }
    )
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            let trailing: CGFloat = 16
            let bottom: CGFloat = 0
            let cardWidth: CGFloat = 320
            let cardHeight: CGFloat = 0
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(cardWidth),
                    heightDimension: .absolute(cardHeight)
                )
            )
            item.contentInsets.trailing = -8
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(cardWidth + trailing),
                    heightDimension: .absolute(cardHeight + bottom)
                ),
                subitem: item,
                count: 1
            )
            group.contentInsets.leading = 24
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.groupPaging
            section.contentInsets.top = 0
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(264)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            ]
            return section
            
        case 1:
            let trailing: CGFloat = 16
//            let bottom: CGFloat = 50
            let cardWidth: CGFloat = 196
            let cardHeight: CGFloat = 280
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(cardWidth),
                    heightDimension: .absolute(cardHeight)
                )
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(cardWidth + trailing),
                    heightDimension: .absolute(cardHeight + 10)
                ),
                subitem: item,
                count: 1
            )
            
            group.contentInsets.trailing = trailing
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 24
            section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(82 - 10)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            ]
            return section
        case 2:
            let trailing: CGFloat = 16
//            let bottom: CGFloat = 50
            let cardWidth: CGFloat = 196
            let cardHeight: CGFloat = 280
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(cardWidth),
                    heightDimension: .absolute(cardHeight)
                )
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(cardWidth + trailing),
                    heightDimension: .absolute(cardHeight + 24 + 30)
                ),
                subitem: item,
                count: 1
            )
            
            group.contentInsets.trailing = trailing
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 24
            section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(82 - 10)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            ]
            return section
        default:
            let trailing: CGFloat = 16
//            let bottom: CGFloat = 50
            let cardWidth: CGFloat = 196
            let cardHeight: CGFloat = 280
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(cardWidth),
                    heightDimension: .absolute(cardHeight)
                )
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(cardWidth + trailing),
                    heightDimension: .absolute(cardHeight + 24 + 30)
                ),
                subitem: item,
                count: 1
            )
            
            group.contentInsets.trailing = trailing
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 24
            section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
            return section
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        
        fetchData()

        configureCollectionView()
        collectionView.backgroundColor = .customGray
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupNavigationBar()
        self.collectionView.reloadData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func fetchData() {
        let group = DispatchGroup()
        group.enter()
        
        var makanBoardings: [SmallBoardingCell]?
        var tempatBermainBoardings: [SmallBoardingCell]?
        
        
        APICaller.shared.getBoardings { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let model):
                makanBoardings = model.data.petHotelsWithFoodFacility
                tempatBermainBoardings = model.data.petHotelsWithPlaygroundFacility
                break
            case .failure(let error):
                print("ERROR IN HOME PAGE", error.localizedDescription)
                break
            }
        }
        
        
        group.notify(queue: .main) {
            guard let makanBoardings = makanBoardings,
                  let tempatBermainBoardings = tempatBermainBoardings
            else { return }
            
            // configure models
            self.configureModels(forSection1: makanBoardings, forSection2: tempatBermainBoardings)
        }
    }
    
    func configureModels(forSection1 resultA: [SmallBoardingCell], forSection2 resultB: [SmallBoardingCell]) {
        
        // SECTION 1
        var stringOfAssets = [String]()
        for _ in 0..<7 {
            stringOfAssets.append("banner\(Int.random(in: 0...4).description)")
        }
                    
        sections.append(.sectionPromo(stringOfAssets: stringOfAssets))
        
        // SECTION 2
        sections.append(.sectionMakan(viewModels: resultA.compactMap({boarding in
            return HomeCellViewModel(
                name: boarding.name,
                slug: boarding.slug,
                subdistrictName: boarding.subdistrict,
                provinceName: boarding.province,
                price: boarding.cheapestLodgingPrice ?? 0,
                imageURLString: !(boarding.images.isEmpty) ? boarding.images[0] : "Boarding/BGTMPRYEXMPL/BGTMPRYEXMPL_3.png"
            )
        })))
        
        // SECTION 3
        sections.append(.sectionTempatBermain(viewModels: resultB.compactMap({ boarding in
            return HomeCellViewModel(
                name: boarding.name,
                slug: boarding.slug,
                subdistrictName: boarding.subdistrict,
                provinceName: boarding.province,
                price: boarding.cheapestLodgingPrice ?? 0,
                imageURLString: !(boarding.images.isEmpty) ? boarding.images[0] : "Boarding/BGTMPRYEXMPL/BGTMPRYEXMPL_3.png"
            )
        })))
        
        collectionView.reloadData()
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
//        view.addSubview(promoCollectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .green
        
        // REGISTER REUSABLEVIEW
        collectionView.register(
            MainHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MainHeaderCollectionReusableView.identifier
        )
        collectionView.register(
            SectionOneHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionOneHeaderCollectionReusableView.identifier
        )
        collectionView.register(
            SectionTwoHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionTwoHeaderCollectionReusableView.identifier
        )
        collectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header"
        )
        
        // REGISTER CELL
        collectionView.register(
            PromoCollectionViewCell.self,
            forCellWithReuseIdentifier: PromoCollectionViewCell.identifier
        )
        collectionView.register(
            SmallBoardingsCollectionViewCell.self,
            forCellWithReuseIdentifier: SmallBoardingsCollectionViewCell.identifier
        )
        collectionView.register(
            LihatLainnyaCollectionViewCell.self,
            forCellWithReuseIdentifier: LihatLainnyaCollectionViewCell.identifier
        )
        
    }
    
    func setupLoadingScreen() {
        view.addSubview(hugeView)
        hugeView.addSubview(spinner)
        
        hugeView.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hugeView.topAnchor.constraint(equalTo: view.topAnchor),
            hugeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hugeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hugeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: hugeView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: hugeView.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        spinner.startAnimating()
    }
    
    func presentCatsAndDogsSheet() {
        let vc  = CatsAndDogsCounterViewController()
        vc.homeViewController = self
        vc.kucingCount = AppAccountManager.shared.kucingCount
        vc.anjingCount = AppAccountManager.shared.anjingCount
        
        let navVc = UINavigationController(rootViewController: vc)
        
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 10
            sheet.detents = [
                .custom(resolver: { context in
                    0.33 * context.maximumDetentValue
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        self.navigationController?.present(navVc, animated: true, completion: nil)
    }
    
    func goToSearchViewController() {
        let vc = SearchResultsViewController()

        let anjingCount = AppAccountManager.shared.anjingCount
        let kucingCount = AppAccountManager.shared.kucingCount
        
        var navbarDetails = String()
        var petCategories = [String]()
        if anjingCount > 0 {
            vc.anjingCount = anjingCount
            petCategories.append("dog")
        }

        if kucingCount > 0 {
            vc.kucingCount = kucingCount
            petCategories.append("cat")
        }
        
        var params: String = ""
        if petCategories.count == 1 {
            if let queryParam = "boardingPetCategories[]=\(petCategories[0])".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                params += queryParam
            }
            
            if petCategories[0] == "dog" {
                navbarDetails += "\(anjingCount) Anjing"
            } else if petCategories[0] == "cat" {
                navbarDetails += "\(kucingCount) Kucing"
            }
        } else if petCategories.count == 2 {
            if let queryParam = "boardingPetCategories[]=\(petCategories[0])".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                params += queryParam
            }
            
            if let queryParam = "&boardingPetCategories[]=\(petCategories[1])".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                params += queryParam
            }
            
            navbarDetails += "\(anjingCount) Anjing, \(kucingCount) Kucing"
        }
        
        if
            let latitude = AppAccountManager.shared.chosenLocationCoordinate?.latitude,
            let longitude = AppAccountManager.shared.chosenLocationCoordinate?.longitude 
        {
            params += "&latitude=\(latitude)&longitude=\(longitude)"
        }
            
        
        navbarDetails = "\(AppAccountManager.shared.calendarTextDetails)\(navbarDetails.isEmpty ? "" : ", \(navbarDetails)")"
        
        vc.detailsLabel.text = navbarDetails
        vc.detailsValue = navbarDetails
        
        vc.locationLabel.text = AppAccountManager.shared.chosenLocationName
        
        let group = DispatchGroup()
        group.enter()
        APICaller.shared.getBoardingsSearch(params: params) { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let response):
                vc.viewModels = response.data.compactMap { boarding in
                    return SearchBoardingViewModel(
                        slug: boarding.slug,
                        name: boarding.name,
                        distance: boarding.distance,
                        subdistrictName: boarding.subdistrict,
                        provinceName: boarding.province,
                        price: boarding.cheapestLodgingPrice,
                        imageURLStrings: boarding.images,
                        facilities: boarding.boardingFacilities
                    )
                }

                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
        group.notify(queue: .main) {
            
            vc.collectionView.reloadData()
            
            vc.spinner.hidesWhenStopped = true
            vc.spinner.stopAnimating()
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType: SectionType = sections[section]
        
        switch sectionType {
        case .sectionPromo(stringOfAssets: let strings):
            return strings.count
        case .sectionMakan(viewModels: let viewModels):
            return viewModels.count + 1
        case .sectionTempatBermain(viewModels: let viewModels):
            return viewModels.count + 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .sectionPromo(stringOfAssets: let strings):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromoCollectionViewCell.identifier, for: indexPath) as? PromoCollectionViewCell else { return UICollectionViewCell() }
            let string = strings[indexPath.row]
            cell.configure(with: string)
            return cell
        case .sectionMakan(viewModels: let viewModels):
            if indexPath.row == viewModels.count {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LihatLainnyaCollectionViewCell.identifier, for: indexPath) as? LihatLainnyaCollectionViewCell else { return UICollectionViewCell() }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallBoardingsCollectionViewCell.identifier, for: indexPath) as? SmallBoardingsCollectionViewCell else { return UICollectionViewCell() }
                let viewModel = viewModels[indexPath.row]
                cell.configure(with: viewModel)
                return cell
            }
        case .sectionTempatBermain(viewModels: let viewModels):
            if indexPath.row == viewModels.count {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LihatLainnyaCollectionViewCell.identifier, for: indexPath) as? LihatLainnyaCollectionViewCell else { return UICollectionViewCell() }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallBoardingsCollectionViewCell.identifier, for: indexPath) as? SmallBoardingsCollectionViewCell else { return UICollectionViewCell() }
                let viewModel = viewModels[indexPath.row]
                cell.configure(with: viewModel)
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let section = sections[indexPath.section]
        switch section {
        case .sectionPromo(stringOfAssets: _ /*let strings*/):
            break
        case .sectionMakan(viewModels: let viewModels):
            if (AppAccountManager.shared.anjingCount == 0) && (AppAccountManager.shared.kucingCount == 0)  {
//                self.presentCatsAndDogsSheet()
                AppAccountManager.shared.kucingCount = 1
            }
//            else {
                if indexPath.row != viewModels.count {
                    let viewModel = viewModels[indexPath.row]
                    let vc = BoardingDetailsViewController(slug: viewModel.slug)
                    vc.hidesBottomBarWhenPushed = true
                    vc.navigationItem.largeTitleDisplayMode = .always
                    vc.navigationController?.navigationBar.prefersLargeTitles = true
                    
                    navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.goToSearchViewController()
                }
//            }
            
            break
        case .sectionTempatBermain(viewModels: let viewModels):
            if (AppAccountManager.shared.anjingCount == 0) && (AppAccountManager.shared.kucingCount == 0)  {
//                self.presentCatsAndDogsSheet()
                AppAccountManager.shared.kucingCount = 1
            }
//            else {
                if indexPath.row != viewModels.count {
                    let viewModel = viewModels[indexPath.row]
                    let vc = BoardingDetailsViewController(slug: viewModel.slug)
                    vc.hidesBottomBarWhenPushed = true
                    vc.navigationItem.largeTitleDisplayMode = .always
                    vc.navigationController?.navigationBar.prefersLargeTitles = true
                    
                    navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.goToSearchViewController()
                }
//            }
            
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = indexPath.section
        
        switch section {
        case 0:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainHeaderCollectionReusableView.identifier, for: indexPath) as? MainHeaderCollectionReusableView else { return UICollectionReusableView() }
            header.tag = 451
            header.delegate = self
            header.numberOfCatsAndDogsButton.catLabel.text = AppAccountManager.shared.kucingCount.description
            header.numberOfCatsAndDogsButton.dogLabel.text = AppAccountManager.shared.anjingCount.description
            header.dateFieldView.thisLabel.text = AppAccountManager.shared.calendarTextDetails
            return header
        case 1:
            guard let header1 = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionOneHeaderCollectionReusableView.identifier, for: indexPath) as? SectionOneHeaderCollectionReusableView else { return UICollectionReusableView() }
            return header1
        case 2:
            guard let header2 = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionTwoHeaderCollectionReusableView.identifier, for: indexPath) as? SectionTwoHeaderCollectionReusableView else { return UICollectionReusableView() }
            return header2
        default:
            let defaultHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            return defaultHeader
        }
    }
}

