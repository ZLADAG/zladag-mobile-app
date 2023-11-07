//
//  PetFacilityPrefCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 06/11/23.
//

import UIKit

class PetFacilityPrefCollectionViewCell: UICollectionViewCell {
    static let identifier = "PetFacilityPrefCollectionViewCell"
    
    var facilityTag : ProfileIconLabel!
    var cellWidth = 0.0
    var cellHeight = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(content: ProfileIconLabel) {
        self.facilityTag = content
        self.facilityTag.title.numberOfLines = 1
        self.addSubview(self.facilityTag)
        
        cellWidth = facilityTag.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).width
        cellHeight = facilityTag.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
        
        setUpConstraint()
    }
    
    private func setUpConstraint() {
        NSLayoutConstraint.activate([
            facilityTag.topAnchor.constraint(equalTo: self.topAnchor),
            facilityTag.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            facilityTag.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            facilityTag.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
                layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
                return layoutAttributes
    }
}
