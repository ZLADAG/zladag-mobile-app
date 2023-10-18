//
//  CoretanViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 05/10/23.
//

import UIKit

class CoretanViewController: UIViewController {

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
                    heightDimension: .absolute(cardHeight + 24 + 80)
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

        view.backgroundColor = .systemMint
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.register(BoardingsCollectionViewCell.self, forCellWithReuseIdentifier: BoardingsCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.backgroundColor = .green
        
        view.addSubview(collectionView)
    }

}

extension CoretanViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardingsCollectionViewCell.identifier, for: indexPath) as? BoardingsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .red
        return cell
    }
    
    
}
