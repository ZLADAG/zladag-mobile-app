//
//  OrderCardCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 16/11/23.
//

import UIKit

class OrderCardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OrderCardCollectionViewCell"
    
    let hotelNameLabel = UILabel()
    let petNameLabel = UILabel()
    let dividerView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func configure(viewModel: DummyOrder) {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        
//        if viewModel.section == "active" {
//            setupHotelNameLabel(hotelName: "atv" + viewModel.hotelName)
//        } else if viewModel.section == "history" {
//            setupHotelNameLabel(hotelName: "hty " + viewModel.hotelName)
//        }
        
        setupHotelNameLabel(hotelName: viewModel.hotelName)
        setupPetNameLabel(petName: viewModel.petName)
        setupOrderLabelView(ordeLabel: viewModel.orderLabel)
        setupDividerView()
    }
    
    private func setupHotelNameLabel(hotelName: String) {
        contentView.addSubview(hotelNameLabel)
        
        hotelNameLabel.text = hotelName
        hotelNameLabel.backgroundColor = .clear
        hotelNameLabel.adjustsFontSizeToFitWidth = true
        hotelNameLabel.sizeToFit()
        hotelNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        hotelNameLabel.textColor = .textBlack
        
        hotelNameLabel.frame = CGRect(x: 16, y: 16, width: hotelNameLabel.width, height: hotelNameLabel.height)
    }
    
    private func setupPetNameLabel(petName: String) {
        contentView.addSubview(petNameLabel)
        
        let pawIcon = UIImageView(image: UIImage(named: "paw-icon"))
        pawIcon.backgroundColor = .clear
        pawIcon.contentMode = .scaleAspectFill
        pawIcon.tintColor = .customLightGray161
        
        contentView.addSubview(pawIcon)
        pawIcon.frame = CGRect(x: 16, y: hotelNameLabel.bottom + 35, width: 16, height: 16)
        
        petNameLabel.text = petName
        petNameLabel.backgroundColor = .clear
        petNameLabel.adjustsFontSizeToFitWidth = true
        petNameLabel.sizeToFit()
        petNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        petNameLabel.textColor = .customLightGray161
        
        petNameLabel.frame = CGRect(x: pawIcon.right + 4, y: pawIcon.top + 1, width: petNameLabel.width, height: petNameLabel.height)
    }
    
    private func setupOrderLabelView(ordeLabel: OrderLabel) {
        let orderLabelView = OrderLabelView(orderLabel: ordeLabel)
        contentView.addSubview(orderLabelView)
        
        orderLabelView.frame = CGRect(x: 16, y: petNameLabel.bottom + 17, width: orderLabelView.width, height: orderLabelView.height)
    }
    
    private func setupDividerView() {
        
        contentView.addSubview(dividerView)
        
        dividerView.backgroundColor = .customLightGray242
        
        dividerView.frame = CGRect(x: hotelNameLabel.left, y: petNameLabel.bottom + 8, width: 342, height: 1)
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
        
//        dividerView.frame = .zero
        
//    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
}
