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
            let bottom: CGFloat = 24
            let cardWidth: CGFloat = 320
            let cardHeight: CGFloat = 160
            
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
            section.contentInsets.top = 36
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
        
        fetchData()

        configureCollectionView()
        
        collectionView.backgroundColor = .customGray
        setupNavigationBar()
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
                guard let homeResponse = Utils.getHome() else { print("ERROR WHEN READING JSON FILE"); return }
                makanBoardings = homeResponse.data.petHotelsWithFoodFacility
                tempatBermainBoardings = homeResponse.data.petHotelsWithFoodFacility
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
                price: boarding.cheapestLodgingPrice,
                imageURLString: boarding.images[0]
            )
        })))
        
        // SECTION 3
        sections.append(.sectionTempatBermain(viewModels: resultB.compactMap({ boarding in
            return HomeCellViewModel(
                name: boarding.name,
                slug: boarding.slug,
                subdistrictName: boarding.subdistrict,
                provinceName: boarding.province,
                price: boarding.cheapestLodgingPrice,
                imageURLString: boarding.images[0]
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
        
        collectionView.register(
            MainHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MainHeaderCollectionReusableView.identifier
        )
        collectionView.register(
            PromoCollectionViewCell.self,
            forCellWithReuseIdentifier: PromoCollectionViewCell.identifier
        )
        collectionView.register(
            SectionOneHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionOneHeaderCollectionReusableView.identifier
        )
        collectionView.register(
            SmallBoardingsCollectionViewCell.self,
            forCellWithReuseIdentifier: SmallBoardingsCollectionViewCell.identifier
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
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType: SectionType = sections[section]
        
        switch sectionType {
        case .sectionPromo(stringOfAssets: let strings):
            return strings.count
        case .sectionMakan(viewModels: let viewModels):
            return viewModels.count
        case .sectionTempatBermain(viewModels: let viewModels):
            return viewModels.count
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallBoardingsCollectionViewCell.identifier, for: indexPath) as? SmallBoardingsCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.row]
            
            cell.configure(with: viewModel)
            
            return cell
        case .sectionTempatBermain(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallBoardingsCollectionViewCell.identifier, for: indexPath) as? SmallBoardingsCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let section = sections[indexPath.section]
        switch section {
        case .sectionPromo(stringOfAssets: _ /*let strings*/):
            break
        case .sectionMakan(viewModels: let viewModels):
            
            let group = DispatchGroup()
            group.enter()
            

            let viewModel = viewModels[indexPath.row]
            let vc = BoardingDetailsViewController(group: group)
            vc.hidesBottomBarWhenPushed = true
            vc.navigationItem.largeTitleDisplayMode = .always
            vc.navigationController?.navigationBar.prefersLargeTitles = true
            
            APICaller.shared.getBoardingBySlug(slug: viewModel.slug) { result in
                defer {
                    group.leave()
                }
                // slf.isfetching = true
                switch result {
                case .success(let response):
                    vc.viewModel = BoardingDetailsViewModel(
                        name: response.data.name,
                        distance: response.data.distance,
                        address: response.data.address,
                        slug: response.data.slug,
                        description: response.data.description,
                        boardingCategory: response.data.boardingCategory,
                        subdistrictName: response.data.subdistrict,
                        provinceName: response.data.province,
                        boardingCages: response.data.boardingCages,
                        price: response.data.cheapestLodgingPrice,
                        images: response.data.images,
                        facilities: response.data.boardingFacilities,
                        shouldHaveBeenVaccinated: response.data.shouldHaveBeenVaccinated,
                        shouldHaveToBeFleaFree: response.data.shouldHaveToBeFleaFree,
                        minimumAge: response.data.minimumAge,
                        maximumAge: response.data.maximumAge,
                        rating: viewModel.rating,
                        numOfReviews: viewModel.numOfReviews
                    )
                    break
                case .failure(let error):
                    let localResult = Utils.getOneBoardingDetails()!.data
                    vc.viewModel = BoardingDetailsViewModel(
                        name: localResult.name,
                        distance: localResult.distance,
                        address: localResult.address,
                        slug: localResult.slug,
                        description: localResult.description,
                        boardingCategory: localResult.boardingCategory,
                        subdistrictName: localResult.subdistrict,
                        provinceName: localResult.province,
                        boardingCages: localResult.boardingCages,
                        price: localResult.cheapestLodgingPrice,
                        images: localResult.images,
                        facilities: localResult.boardingFacilities,
                        shouldHaveBeenVaccinated: localResult.shouldHaveBeenVaccinated,
                        shouldHaveToBeFleaFree: localResult.shouldHaveToBeFleaFree,
                        minimumAge: localResult.minimumAge,
                        maximumAge: localResult.maximumAge,
                        rating: viewModel.rating,
                        numOfReviews: viewModel.numOfReviews
                    )
                    print(error.localizedDescription)
                    break
                }
            }
            
            vc.group = group
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case .sectionTempatBermain(viewModels: let viewModels):
            let group = DispatchGroup()
            group.enter()
            
            let viewModel = viewModels[indexPath.row]
            let vc = BoardingDetailsViewController(group: group)
            vc.hidesBottomBarWhenPushed = true
            vc.navigationItem.largeTitleDisplayMode = .always
            vc.navigationController?.navigationBar.prefersLargeTitles = true

            
            
            APICaller.shared.getBoardingBySlug(slug: viewModel.slug) { result in
                defer {
                    group.leave()
                }

                switch result {
                case .success(let response):
                    vc.viewModel = BoardingDetailsViewModel(
                        name: response.data.name,
                        distance: response.data.distance,
                        address: response.data.address,
                        slug: response.data.slug,
                        description: response.data.description,
                        boardingCategory: response.data.boardingCategory,
                        subdistrictName: response.data.subdistrict,
                        provinceName: response.data.province,
                        boardingCages: response.data.boardingCages,
                        price: response.data.cheapestLodgingPrice,
                        images: response.data.images,
                        facilities: response.data.boardingFacilities,
                        shouldHaveBeenVaccinated: response.data.shouldHaveBeenVaccinated,
                        shouldHaveToBeFleaFree: response.data.shouldHaveToBeFleaFree,
                        minimumAge: response.data.minimumAge,
                        maximumAge: response.data.maximumAge,
                        rating: viewModel.rating,
                        numOfReviews: viewModel.numOfReviews
                    )
                    break
                case .failure(let error):
                    let localResult = Utils.getOneBoardingDetails()!.data
                    vc.viewModel = BoardingDetailsViewModel(
                        name: localResult.name,
                        distance: localResult.distance,
                        address: localResult.address,
                        slug: localResult.slug,
                        description: localResult.description,
                        boardingCategory: localResult.boardingCategory,
                        subdistrictName: localResult.subdistrict,
                        provinceName: localResult.province,
                        boardingCages: localResult.boardingCages,
                        price: localResult.cheapestLodgingPrice,
                        images: localResult.images,
                        facilities: localResult.boardingFacilities,
                        shouldHaveBeenVaccinated: localResult.shouldHaveBeenVaccinated,
                        shouldHaveToBeFleaFree: localResult.shouldHaveToBeFleaFree,
                        minimumAge: localResult.minimumAge,
                        maximumAge: localResult.maximumAge,
                        rating: viewModel.rating,
                        numOfReviews: viewModel.numOfReviews
                    )
                    print(error.localizedDescription)
                    break
                }
            }
            
            
            self.navigationController?.pushViewController(vc, animated: true)
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = indexPath.section
        
        switch section {
        case 0:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainHeaderCollectionReusableView.identifier, for: indexPath) as? MainHeaderCollectionReusableView else { return UICollectionReusableView() }
            header.delegate = self
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

