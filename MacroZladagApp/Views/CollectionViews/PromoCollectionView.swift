//
//  PromoCollectionView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 08/10/23.
//

import UIKit

class PromoCollectionView: UICollectionView {
    
    init() {
        super.init(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout { sectionIdx, environment in // environment iphone, ipad, etc..
                
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 50, trailing: 2)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize( // NSCollectionLayoutSize
                        widthDimension: .fractionalWidth(0.9),
                        heightDimension: .absolute(CGFloat(320 * 1))
                    ),
                    subitem: item,
                    count: 1
                )
                
                // Section - NSCollectionLayoutGroup
                let section = NSCollectionLayoutSection(group: group)
                
                // horizonatl scrolling
                // yg harusnya lanjut ke bawah (vertical), jadi ke samping (horizontal)
                section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.groupPaging // snap
                section.boundarySupplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)),
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top
                    )
                ]
                
                return section
            }
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
