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
    case sectionTempatBermain(viewModels: [HomeCellViewModel]) // 1
}

class HomeViewController: UIViewController {
    
    var viewModels = [BoardingsCellViewModel]()
    
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
        setupNavigationBar2()
//        navigationController?.navigationBar.backgroundColor = .red
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .customLightOrange
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupNavigationBar2() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .customLightOrange
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .white
        
//        navigationController?.navigationBar.standardAppearance = appearance2
//        navigationController?.navigationBar.compactAppearance = appearance2
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance2
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
            BoardingsCollectionViewCell.self,
            forCellWithReuseIdentifier: BoardingsCollectionViewCell.identifier
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardingsCollectionViewCell.identifier, for: indexPath) as? BoardingsCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.row]
            
            cell.configure(with: viewModel)
            
            return cell
        case .sectionTempatBermain(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardingsCollectionViewCell.identifier, for: indexPath) as? BoardingsCollectionViewCell else { return UICollectionViewCell() }
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
//            let viewModel = viewModels[indexPath.row]
//            let vc = BoardingDetailsViewController(viewModel: viewModel)
//            vc.title = viewModel.name
//            vc.hidesBottomBarWhenPushed = true
//
//            vc.navigationItem.largeTitleDisplayMode = .always
//            vc.navigationController?.navigationBar.prefersLargeTitles = true
//
//            navigationController?.pushViewController(vc, animated: true)
            
            break
        case .sectionTempatBermain(viewModels: let viewModels):
//            let viewModel = viewModels[indexPath.row]
//            let vc = BoardingDetailsViewController(viewModel: viewModel)
//            vc.title = viewModel.name
//            vc.hidesBottomBarWhenPushed = true
//
//            vc.navigationItem.largeTitleDisplayMode = .always
//            vc.navigationController?.navigationBar.prefersLargeTitles = true
//            
//            navigationController?.pushViewController(vc, animated: true)
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

