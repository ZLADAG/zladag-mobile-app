//
//  AddOnServiceOption.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 09/11/23.
//

import UIKit
protocol AddOnServiceOptionDelegate: AnyObject{
    func checkboxTapped()
    func getAddOnServiceOptionIdx(idx: Int, priceWithAmount: PriceWithAmount)
    
}

class AddOnServiceOption: UIView {

    weak var delegate : AddOnServiceOptionDelegate?
    let checkbox = UIButton(configuration: .plain())
    
    var idx = 0
    var isClicked: Bool = false
    var pricePrefix = "+"
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
        
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.setImage(UIImage(named: "checkbox-icon-unselected"), for: .normal)
//        checkbox.setImage(UIImage(named: "checkbox-icon"), for: .selected)
        checkbox.imageView?.contentMode = .scaleAspectFit
        checkbox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        
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
        if price != 0 {
            priceLabel.text = "\(pricePrefix)\(price)"
        } else {
            priceLabel.text = ""
        }
        priceLabel.textAlignment = .right

        let textStack = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .horizontal
        textStack.alignment = .fill
        textStack.distribution = .equalSpacing
        
        let iconSize = 20.0
        self.addSubview(checkbox)
        NSLayoutConstraint.activate([
            checkbox.heightAnchor.constraint(equalToConstant: iconSize),
            checkbox.widthAnchor.constraint(equalToConstant: iconSize),
            
            checkbox.topAnchor.constraint(equalTo: self.topAnchor),
            checkbox.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            checkbox.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        self.addSubview(textStack)
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: self.topAnchor),
            textStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textStack.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 16),
            textStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    // MARK: Selectors
    @objc func checkboxTapped() {
        self.isClicked = !self.isClicked

        if self.isClicked {
            checkbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            checkbox.tintColor = .customOrange
            priceWithAmount.amount = 1
        } else {
            checkbox.setImage(UIImage(named: "checkbox-icon-unselected"), for: .normal)
            priceWithAmount.amount = 0
        }
        delegate?.checkboxTapped()
        
        /// send index data value
        delegate?.getAddOnServiceOptionIdx(idx: self.idx, priceWithAmount: self.priceWithAmount)
    }

}
