//
//  SegmentedReviewView.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 12/10/23.
//

import UIKit

class SegmentedReviewView: UIView {
    
    lazy var cobaTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        
        label.text = "YEAY ini hal review"
        label.textColor = .textBlack
        label.textAlignment = .left
        
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("segmented review")

//        setUpConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setUpConstraint()
    }
    
    private func setUpConstraint() {
//        addSubview(fasilitasTitleLabel)
//        
//        NSLayoutConstraint.activate([
//            fasilitasTitleLabel.topAnchor.constraint(equalTo: topAnchor),
//            fasilitasTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            fasilitasTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
//            fasilitasTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
