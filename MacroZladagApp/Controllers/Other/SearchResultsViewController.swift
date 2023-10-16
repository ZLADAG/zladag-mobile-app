//
//  SearchResultsViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import UIKit

protocol SearchResultsViewControllerDelegate { // harga tertinggi, cctv, makan, kucing
    func showResult(_ controller: UIViewController)
}

class SearchResultsViewController: UIViewController {

    var viewModels = [BoardingsCellViewModel]()
    
    public var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIdx, _ in
            switch sectionIdx {
            case 0:
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(66),
                        heightDimension: .absolute(33 + 16 + 16)
                    )
                )
                
                item.contentInsets.leading = 24
                item.contentInsets.bottom = 16
                item.contentInsets.top = 16
                
//                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leading, bottom: bottom, trailing: 0)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(66 + 24),
                        heightDimension: .absolute(33 + 16 + 16)
                      ),
                    subitem: item,
                    count: 1
                )
                
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(92)),
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top
                    )
                ]
            
                
                return section
            case 1:
                let bottom: CGFloat = 24
                let cardWidth: CGFloat = 342
                let cardHeight: CGFloat = 268
                let leading: CGFloat = (390 - cardWidth) / 2
                
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(cardWidth),
                        heightDimension: .absolute(cardHeight + bottom)
                    )
                )
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leading, bottom: bottom, trailing: 0)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(cardWidth + leading),
                        heightDimension: .absolute(cardHeight + bottom)
                      ),
                    subitem: item,
                    count: 1
                )

                
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            default:
                let bottom: CGFloat = 24
                let cardWidth: CGFloat = 342
                let cardHeight: CGFloat = 268
                let leading: CGFloat = (390 - cardWidth) / 2
                
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(cardWidth),
                        heightDimension: .absolute(cardHeight + bottom)
                    )
                )
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leading, bottom: bottom, trailing: 0)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(cardWidth + leading),
                        heightDimension: .absolute(cardHeight + bottom)
                      ),
                    subitem: item,
                    count: 1
                )

                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .magenta
        configureCollectionView()
        setupNavigationBar3()
    }
    
    
    func setupNavigationBar() {
        let imageView = UIImageView(image: UIImage(systemName: "star"))
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 113).isActive = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.titleView = imageView
    }
    
    func setupNavigationBar2() {
        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = .customLightOrange
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance

    }
    
    func setupNavigationBar3() {
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect(x: view.bounds.minX, y: view.bounds.minY - 94, width: view.bounds.width, height: view.bounds.height + 94)
    }
    
    func configureCollectionView() {
        collectionView.register(SearchBoardingsResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchBoardingsResultCollectionViewCell.identifier)
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        collectionView.register(SearchResultHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultHeaderCollectionReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .customGray
        
        view.addSubview(collectionView)
    }

    func update(with results: [Boarding]) {
        self.viewModels = results.compactMap({ boarding in
            return BoardingsCellViewModel(
                name: boarding.name,
                address: boarding.address,
                slug: boarding.slug,
                subdistrictName: boarding.subdistrict.name,
                districtName: boarding.subdistrict.district.name,
                cityName: boarding.subdistrict.district.city.name,
                boardingCategoryName: boarding.boarding_category.name,
                imageURLString: boarding.boarding_images[0].path
            )
        })
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.viewModels.count
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        
        if section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
            cell.viewControllerDelegate = self // utk button filter!
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchBoardingsResultCollectionViewCell.identifier, for: indexPath) as? SearchBoardingsResultCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configure(with: viewModels[indexPath.row])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultHeaderCollectionReusableView.identifier, for: indexPath) as? SearchResultHeaderCollectionReusableView else { return UICollectionReusableView() }
        return header
    }
    
}
