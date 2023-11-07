//
//  PetHabitsCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 06/11/23.
//

import UIKit

class PetHabitsCollectionViewCell: UICollectionViewCell {
    static let identifier = "PetHabitsCollectionViewCell"
    
    var habitsTag : UIView!
    var cellWidth = 0.0
    var cellHeight = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(habitText: String) {
        self.habitsTag = createFreeText(habitText)
        self.addSubview(self.habitsTag)
        
        cellWidth = habitsTag.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).width
        cellHeight = habitsTag.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
        
        setUpConstraint()
    }
    
    private func setUpConstraint() {
        NSLayoutConstraint.activate([
            habitsTag.topAnchor.constraint(equalTo: self.topAnchor),
            habitsTag.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            habitsTag.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            habitsTag.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

/// UI Creation
extension PetHabitsCollectionViewCell {
    private func createFreeText (_ text: String) -> UIView {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        /// wrap label fit text length
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = text
        label.textColor = .black
        label.numberOfLines = 1
        
        /// label wrapper
        let labelWrapper = UIView()
        labelWrapper.translatesAutoresizingMaskIntoConstraints = false
        
        labelWrapper.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: labelWrapper.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: labelWrapper.bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: labelWrapper.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: labelWrapper.trailingAnchor, constant: -8),
        ])
        labelWrapper.layer.cornerRadius = 4
        labelWrapper.backgroundColor = .customLightGray3
        
        return labelWrapper
    }
}


