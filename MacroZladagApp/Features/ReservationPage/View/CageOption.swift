//
//  CageOption.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 09/11/23.
//

import UIKit
protocol CageOptionDelegate: AnyObject{
//    func radioButtonTapped(idx: Int)
    func radioButtonTapped(idx: Int, priceWithAmount: PriceWithAmount)
}

class CageOption: UIView {
    weak var delegate: CageOptionDelegate?
    let radioButton = UIButton()
    
    var idx = 0
    var isClicked: Bool = false
    var pricePrefix = ""
    var priceWithAmount : PriceWithAmount = PriceWithAmount(price: 0, amount: 0)

    
    // MARK: Initialize Methods
    init(name: String, price: Int) {
        super.init(frame: .zero)
        setUpComponents(name, price)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpComponents(_ name: String, _ price: Int) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        radioButton.setImage(UIImage(named: "radioButton-icon-unselected"), for: .normal)
        radioButton.setImage(UIImage(named: "radioButton-icon"), for: .selected)
        radioButton.imageView?.contentMode = .scaleAspectFit
        radioButton.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.textColor = .textBlack
        nameLabel.text = name
        nameLabel.textAlignment = .left
        
        priceWithAmount.price = price

        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = .systemFont(ofSize: 14, weight: .medium)
        priceLabel.textColor = .textBlack
        priceLabel.text = "\(pricePrefix)\(price)"
        priceLabel.textAlignment = .right
        
        let textStack = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .horizontal
        textStack.alignment = .fill
        textStack.distribution = .equalSpacing
        
        let iconSize = 20.0
        self.addSubview(radioButton)
        NSLayoutConstraint.activate([
            radioButton.heightAnchor.constraint(equalToConstant: iconSize),
            radioButton.widthAnchor.constraint(equalToConstant: iconSize),
            
            radioButton.topAnchor.constraint(equalTo: self.topAnchor),
            radioButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            radioButton.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        self.addSubview(textStack)
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: self.topAnchor),
            textStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textStack.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 16),
            textStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
    
    // MARK: Selectors
    @objc func radioButtonTapped() {
        self.isClicked = !self.isClicked

        if self.isClicked {
            activateButton()
        }
        
        /// send index data value
        delegate?.radioButtonTapped(idx: self.idx, priceWithAmount: self.priceWithAmount)
    }
    
    func activateButton() {
        radioButton.setImage(UIImage(named: "radioButton-icon"), for: .normal)
        priceWithAmount.amount = 1
    }
    func deactivateButton() {
        radioButton.setImage(UIImage(named: "radioButton-icon-unselected"), for: .normal)
        priceWithAmount.amount = 0
    }

}
