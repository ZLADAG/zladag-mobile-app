//
//  HeaderPetAmountInputCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 19/11/23.
//

import UIKit
protocol HeaderPetAmountInputCollectionViewCellDelegate {
    func petAmountInputBtnTapped()
}
class HeaderPetAmountInputCollectionViewCell: UICollectionViewCell {
    static let identifier = "HeaderPetAmountInputCollectionViewCell"
    
    var delegate: HeaderPetAmountInputCollectionViewCellDelegate?
    
    private var petAmountButton : HeaderInputButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        petAmountButton = HeaderInputButton("-", .petAmount)
        petAmountButton.delegate = self
        
        addSubview(petAmountButton)
        NSLayoutConstraint.activate([
            petAmountButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            petAmountButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            petAmountButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            petAmountButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
    }
    
    func updateInfoLabel(cats: Int, dogs: Int){
        self.petAmountButton.infoLabel.text = "\(cats) Kucing \(dogs) Anjing"
        ReservationManager.shared.totalPets = cats + dogs
    }
    
}

extension HeaderPetAmountInputCollectionViewCell: HeaderInputButtonDelegate {
    func btnTapped(_ senderButtonType: HeaderInputButton.ButtonType) {
        print("tapped")
        delegate?.petAmountInputBtnTapped()
    }
}
