//
//  BrowseViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import Foundation
import UIKit

enum SectionType {
    case sectionA(viewModels: [BoardingsCellViewModel]) // 0
    case sectionB(viewModels: [BoardingsCellViewModel]) // 1
    case sectionC(viewModels: [BoardingsCellViewModel]) // 2
}

class BrowseViewController: UIViewController {
    
    var viewModels = [BoardingsCellViewModel]()
    
    var sections = [SectionType]()
    
    let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultsViewController())
        vc.searchBar.placeholder = "Carilah, saudara..."
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIdx, _ in
            
            let trailing: CGFloat = 16
            let bottom: CGFloat = 50
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
//                    heightDimension: .absolute(cardHeight + 24 + 80)
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
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
        collectionView.backgroundColor = .customGray
        
        fetchData()
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    func fetchData() {
        let group = DispatchGroup()
        for _ in 0..<3 {
            group.enter()
        }
        
        var boardingsResponseA: BoardingsResponse?
        var boardingsResponseB: BoardingsResponse?
        var boardingsResponseC: BoardingsResponse?
        
        // A
        APICaller.shared.getBoardings { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let model):
                boardingsResponseA = model
                break
            case .failure(let error):
                print("ERROR IN SECTION A", error.localizedDescription)
                break
            }
        }
        
        // B
        APICaller.shared.getBoardings { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let model):
                boardingsResponseB = model
                break
            case .failure(let error):
                print("ERROR IN SECTION B", error.localizedDescription)
                break
            }
        }
        
        // C
        APICaller.shared.getBoardings { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let model):
                boardingsResponseC = model
                break
            case .failure(let error):
                print("ERROR IN SECTION C", error.localizedDescription)
                break
            }
        }
        
        group.notify(queue: .main) {
            guard let boardingsDataA = boardingsResponseA?.data,
                  let boardingsDataB = boardingsResponseB?.data,
                  let boardingsDataC = boardingsResponseC?.data
            else { return }
            
            
            // configure models
            self.configureModels(forSection1: boardingsDataA, forSection2: boardingsDataB, forSection3: boardingsDataC)
        }
    }
    
    func configureModels(forSection1 resultA: [Boarding], forSection2 resultB: [Boarding], forSection3 resultC: [Boarding]) {
        // SECTION 1
        sections.append(.sectionA(viewModels: resultA.compactMap({ boarding in
            return BoardingsCellViewModel(
                name: boarding.name,
                address: boarding.address,
                slug: boarding.slug,
                subdistrictName: boarding.subdistrict.name,
                districtName: boarding.subdistrict.district.name,
                cityName: boarding.subdistrict.district.city.name,
                boardingCategoryName: boarding.boarding_category.name
            )
        })))
        
        // SECTION 2
        sections.append(.sectionB(viewModels: resultB.compactMap({ boarding in
            return BoardingsCellViewModel(
                name: boarding.name,
                address: boarding.address,
                slug: boarding.slug,
                subdistrictName: boarding.subdistrict.name,
                districtName: boarding.subdistrict.district.name,
                cityName: boarding.subdistrict.district.city.name,
                boardingCategoryName: boarding.boarding_category.name
            )
        })))

        // SECTION 3
        sections.append(.sectionC(viewModels: resultC.compactMap({ boarding in
            return BoardingsCellViewModel(
                name: boarding.name,
                address: boarding.address,
                slug: boarding.slug,
                subdistrictName: boarding.subdistrict.name,
                districtName: boarding.subdistrict.district.name,
                cityName: boarding.subdistrict.district.city.name,
                boardingCategoryName: boarding.boarding_category.name
            )
        })))
        
        collectionView.reloadData()
    }
    
    func configureCollectionView() {
        collectionView.register(BoardingsCollectionViewCell.self, forCellWithReuseIdentifier: BoardingsCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .green
        
        view.addSubview(collectionView)
    }
    
}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType: SectionType = sections[section]
        
        switch sectionType {
        case .sectionA(viewModels: let viewModels):
            return viewModels.count
        case .sectionB(viewModels: let viewModels):
            return viewModels.count
        case .sectionC(viewModels: let viewModels):
            return viewModels.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .sectionA(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardingsCollectionViewCell.identifier, for: indexPath) as? BoardingsCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.row]
            
            cell.configure(with: viewModel)
            
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 1, height: 5)
            cell.layer.shadowRadius = 2.0
            cell.layer.shadowOpacity = 0.15
            cell.layer.masksToBounds = false
            
            return cell
        case .sectionB(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardingsCollectionViewCell.identifier, for: indexPath) as? BoardingsCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        case .sectionC(viewModels: let viewModels):
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
        case .sectionA(viewModels: let viewModels):
            let viewModel = viewModels[indexPath.row]
            let vc = BoardingDetailsViewController(viewModel: viewModel)
            vc.title = viewModel.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            break
        case .sectionB(viewModels: let viewModels):
            break
        case .sectionC(viewModels: let viewModels):
            break
        }
    }
}

extension BrowseViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        /*
         NANTI KE SINI
        guard
            let resultsController = searchController.searchResultsController as? SearchResultsViewController,
            let query = searchController.searchBar.text,
            !query.trimmingCharacters(in: .whitespaces).isEmpty
        else { return }
        
        print(query)
        
//        APICaller.shared.search
        
     */
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard
            let resultsController = searchController.searchResultsController as? SearchResultsViewController,
            let query = searchController.searchBar.text,
            !query.trimmingCharacters(in: .whitespaces).isEmpty
        else { return }
        
        APICaller.shared.getBoardingsByName(name: query.lowercased().trimmingCharacters(in: .whitespaces)) { result in
            switch result {
            case .success(let result):
                resultsController.update(with: result.data)
                print(result)
                break
            case .failure(let error):
                print("ERROR:\n\(error)")
            }
        }
    }
    
}
