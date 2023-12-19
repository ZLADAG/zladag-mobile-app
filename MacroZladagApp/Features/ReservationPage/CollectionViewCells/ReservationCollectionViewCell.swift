//
//  ReservationCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 17/12/23.
//

import UIKit

class ReservationCollectionViewCell: UICollectionViewCell {
    static let identifier = "ReservationCollectionViewCell"
    
    let titleLabel = UILabel()
    var buttons = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .cyan
    }
    
    public func configure(title: String, viewModelCell: ReservationCellViewModel) {
        titleLabel.text = title
        
        setupTitleLabel()
        
        setupKandangButtons(cages: viewModelCell.cages)
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .textBlack
        titleLabel.sizeToFit()
        
        titleLabel.frame = CGRect(
            x: 24,
            y: 16,
            width: titleLabel.width,
            height: titleLabel.height
        )
    }
    
    private func setupKandangButtons(cages: [ReservationCageDetails]) {
        for _ in cages {
            let button = UIButton()
            button.backgroundColor = [UIColor.red, UIColor.blue, UIColor.green].randomElement()
            
            self.buttons.append(button)
        }
        
        for i in 0..<buttons.count {
            contentView.addSubview(buttons[i])
            
            if i == 0 {
                buttons[i].frame = CGRect(
                    x: 5,
                    y: titleLabel.bottom + 10,
                    width: 300,
                    height: 50
                )
            } else {
                buttons[i].frame = CGRect(
                    x: 5,
                    y: buttons[i - 1].bottom + 25,
                    width: 300,
                    height: 50
                )
            }
            
            
            
        }
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        self.buttons = []
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
}
