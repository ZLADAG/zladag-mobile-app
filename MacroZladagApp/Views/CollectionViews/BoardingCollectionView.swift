//
//  BoardingCollectionView.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 11/10/23.
//

import UIKit

class BoardingCollectionView: UICollectionView {
    
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
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
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
                
                // horizontal scrolling
                // yg harusnya lanjut ke bawah (vertical), jadi ke samping (horizontal)
                section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.groupPaging
                
                section.boundarySupplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(198)),
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
