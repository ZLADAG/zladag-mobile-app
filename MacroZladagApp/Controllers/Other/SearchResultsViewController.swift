//
//  SearchResultsViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import UIKit

protocol SearchResultsViewControllerDelegate {
    func showResult(_ controller: UIViewController)
}

class SearchResultsViewController: UIViewController {
    
//    weak var delegate: SearchResultsViewControllerDelegate?

    var viewModels = [BoardingsCellViewModel]()
    
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIdx, _ in
            
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
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(view.frame.width)
        view.backgroundColor = .magenta
        configureCollectionView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    func configureCollectionView() {
        collectionView.register(SearchBoardingsResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchBoardingsResultCollectionViewCell.identifier)
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
                boardingCategoryName: boarding.boarding_category.name
            )
        })
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModels.count
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchBoardingsResultCollectionViewCell.identifier, for: indexPath) as? SearchBoardingsResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: viewModels[indexPath.row])
        
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 1, height: 5)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.15
        cell.layer.masksToBounds = false
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = BoardingDetailsViewController
//        delegate?.showResult(vc)
//    }
    
}
