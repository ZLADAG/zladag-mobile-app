//
//  TotalPriceSummaryCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 16/11/23.
//

import UIKit

protocol TotalPriceSummaryCollectionViewCellDelegate {
    func orderButtonTapped()
}
class TotalPriceSummaryCollectionViewCell: UICollectionViewCell {
    static let identifier = "TotalPriceSummaryCollectionViewCell"
    
    var delegate : TotalPriceSummaryCollectionViewCellDelegate?
    var pricePrefix = "Rp"

    var amountPet = 0
    var defaultPrice = 0
    var addOnServicePrice = 0
    var totalPrice = 0
    
    var defaultPriceNameLabel: UILabel!
    var defaultPriceLabel: UILabel!
    var addOnServicePriceLabel: UILabel!
    var totalPriceLabel: UILabel!
    
    var orderButton : PrimaryButtonFilled!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCell() {
        /// Default service
        defaultPriceNameLabel = UILabel()
        defaultPriceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        defaultPriceNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        defaultPriceNameLabel.textColor = .customLightGray
        defaultPriceNameLabel.numberOfLines = 0
        defaultPriceNameLabel.text = "Total Harga Penginapan (\(amountPet) anabul)"
        defaultPriceNameLabel.textAlignment = .left
        
        defaultPriceLabel = UILabel()
        defaultPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        defaultPriceLabel.font = .systemFont(ofSize: 14, weight: .medium)
        defaultPriceLabel.textColor = .textBlack
        defaultPriceLabel.text = "\(pricePrefix)\(defaultPrice)"
        defaultPriceLabel.textAlignment = .right
        
        let defaultPriceContent = createPriceContent(content: [defaultPriceNameLabel, defaultPriceLabel])
        
        /// add on service
        let addOnServicePriceNameLabel = UILabel()
        addOnServicePriceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addOnServicePriceNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        addOnServicePriceNameLabel.textColor = .customLightGray
        addOnServicePriceNameLabel.numberOfLines = 0
        addOnServicePriceNameLabel.text = "Total Add-on Service"
        addOnServicePriceNameLabel.textAlignment = .left
        
        addOnServicePriceLabel = UILabel()
        addOnServicePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        addOnServicePriceLabel.font = .systemFont(ofSize: 14, weight: .medium)
        addOnServicePriceLabel.textColor = .textBlack
        addOnServicePriceLabel.text = "\(pricePrefix)\(addOnServicePrice)"
        addOnServicePriceLabel.textAlignment = .right
        
        let addOnServicePriceContent = createPriceContent(content: [addOnServicePriceNameLabel, addOnServicePriceLabel])
        
        /// Default + add on service wrapper
        let subTotalPriceStack = UIStackView(arrangedSubviews: [defaultPriceContent, addOnServicePriceContent])
        subTotalPriceStack.translatesAutoresizingMaskIntoConstraints = false
        subTotalPriceStack.axis = .vertical
        subTotalPriceStack.alignment = .fill
        subTotalPriceStack.distribution = .fill
        subTotalPriceStack.spacing = 8
        
        /// Total label
        let totalNameLabel = UILabel()
        totalNameLabel.translatesAutoresizingMaskIntoConstraints = false
        totalNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        totalNameLabel.textColor = .textBlack
        totalNameLabel.numberOfLines = 0
        totalNameLabel.text = "Total Pemesanan"
        totalNameLabel.textAlignment = .left
        
        totalPriceLabel = UILabel()
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPriceLabel.font = .systemFont(ofSize: 16, weight: .bold)
        totalPriceLabel.textColor = .textBlack
        totalPriceLabel.text = "\(pricePrefix)\(totalPrice)"
        totalPriceLabel.textAlignment = .right
        
        let totalTextStack = UIStackView(arrangedSubviews: [totalNameLabel, totalPriceLabel])
        totalTextStack.translatesAutoresizingMaskIntoConstraints = false
        totalTextStack.axis = .horizontal
        totalTextStack.alignment = .fill
        totalTextStack.distribution = .fill
        
        orderButton = PrimaryButtonFilled(btnTitle: "Pesan Sekarang")
        orderButton.delegate = self
        
        ///All content
        let content = UIStackView(arrangedSubviews: [subTotalPriceStack, addSeparator(), totalTextStack, addSeparator()])
        content.translatesAutoresizingMaskIntoConstraints = false
        content.axis = .vertical
        content.alignment = .fill
        content.distribution = .equalSpacing
        content.spacing = 12
        
        addSubview(content)
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            //            content.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
        
        addSubview(orderButton)
        NSLayoutConstraint.activate([
            orderButton.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 12),
            orderButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            orderButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            orderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
    }
    
    func updatePetAmountLabel(amount: Int) {
        self.amountPet = amount
        self.defaultPriceNameLabel.text = "Total Harga Penginapan (\(amount) anabul)"
    }
    func updateDefaultPriceLabel(price: Int) {
        self.defaultPrice = price
        self.defaultPriceLabel.text = "\(pricePrefix)\(price)"
    }
    func updateAddOnServicePriceLabel(price: Int) {
        self.addOnServicePrice = price
        self.addOnServicePriceLabel.text = "\(pricePrefix)\(price)"
    }
    func updateTotalPriceLabel(price: Int) {
        self.totalPrice = price
        self.totalPriceLabel.text = "\(pricePrefix)\(price)"
    }
    
    private func createPriceContent(content:[UIView]) -> UIStackView {
        let textStack = UIStackView(arrangedSubviews: content)
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .horizontal
        textStack.alignment = .fill
        textStack.distribution = .fill
        return textStack
    }
    
    private func addSeparator() -> UIImageView{
        let image = UIImageView(image: UIImage(named: "separator")?.withTintColor(.customLightGray3))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode =  .scaleAspectFill
        return image
    }
}



extension TotalPriceSummaryCollectionViewCell: PrimaryButtonFilledDelegate {
    func btnTapped() {
        print("-Order Button tapped")
        delegate?.orderButtonTapped()
    }
}
