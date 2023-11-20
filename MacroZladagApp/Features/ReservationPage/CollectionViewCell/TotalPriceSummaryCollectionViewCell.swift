//
//  TotalPriceSummaryCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 16/11/23.
//

import UIKit
protocol TotalPriceSummaryCollectionViewCellDelegate {
    func orderButtonTapped()
    func updatePetAmount(petAmount: Int)
    func updateDefaultPrice(price: Int)
    func updateAddOnServicePrice(price: Int)
    func updateTotalPrice(price: Int)
    
}
class TotalPriceSummaryCollectionViewCell: UICollectionViewCell {
    static let identifier = "TotalPriceSummaryCollectionViewCell"

    var delegate : TotalPriceSummaryCollectionViewCellDelegate?
    
    var orderButton : PrimaryButtonFilled!
    
    var amountPet = 0
    var defaultPrice = 0
    var addOnServicePrice = 0
    var totalPrice = 0
    
    var pricePrefix = "Rp"
    
    
    var totalPriceLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        let defaultPriceContent = createPriceContent("Total Harga Penginapan (\(amountPet) anabul)", defaultPrice)
        let addOnServicePriceContent = createPriceContent("Total Add-on Service", addOnServicePrice)
        
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
    
    func updatePetAmount(petAmount: Int) {
        delegate?.updatePetAmount(petAmount: petAmount)
    }
    func updateDefaultPrice(price: Int) {
        delegate?.updateDefaultPrice(price: price)
    }
    func updateAddOnServicePrice(price: Int) {
        delegate?.updateAddOnServicePrice(price: price)
    }
    func updateTotalPrice(price: Int) {
        delegate?.updateTotalPrice(price: price)
        totalPriceLabel.text = "\(pricePrefix)\(totalPrice)"

    }
    func createPriceContent(_ name: String, _ price: Int) -> UIStackView {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.textColor = .customLightGray
        nameLabel.numberOfLines = 0
        nameLabel.text = name
        nameLabel.textAlignment = .left
        
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
