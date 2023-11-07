//
//  UICollectionViewLayout.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 06/11/23.
//

import UIKit

extension UICollectionViewLayout {
    static func leftAligned() -> UICollectionViewLayout {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 11
        layout.minimumLineSpacing = 11 // Adjust as needed
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Adjust as needed
        return layout
    }
}
