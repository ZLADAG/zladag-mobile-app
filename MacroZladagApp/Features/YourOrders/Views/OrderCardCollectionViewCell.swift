//
//  OrderCardCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 16/11/23.
//

import UIKit

class OrderCardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OrderCardCollectionViewCell"
    
    weak var mainViewController: OrdersViewController?
    
    let hotelNameLabel = UILabel()
    let dateLabel = UILabel()
    let pawIconImageView = UIImageView()
    let petNameLabel = UILabel()
    let dividerView = UIView()
    var orderLabelView: OrderLabelView?
    
    var rightChevronButton: UIButton? = UIButton()
    let rightChevronImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        hotelNameLabel.text = nil
        dateLabel.text = nil
        pawIconImageView.image = nil
        petNameLabel.text = nil
        dividerView.frame = .zero
        orderLabelView = nil
        rightChevronImageView.image = nil
    }
    
    public func configure(viewModel: OrdersViewModel) {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.masksToBounds = true

//        setupHotelNameLabel(hotelName: viewModel.id) //  FOR DEBUGGING!
        
        setupHotelNameLabel(hotelName: viewModel.hotelName)
        setupDateLabel(startDate: viewModel.startDate, endDate: viewModel.endDate)
        setupPetNameLabel(petName: viewModel.petName)
        setupDividerView()
        setupOrderLabelView(ordeLabel: viewModel.orderLabel)
        setupChevronView()
    }
    
    private func setupChevronView() {
        guard let rightChevronButton else { return }
        
        rightChevronImageView.image = UIImage(named: "right-chevron")
        rightChevronImageView.contentMode = .scaleAspectFill
        rightChevronImageView.tintColor = .grey1
        rightChevronImageView.frame.size = CGSize(width: 24, height: 24)
        
        rightChevronButton.addSubview(rightChevronImageView)
        
        rightChevronButton.backgroundColor = .clear
        rightChevronButton.frame.size = CGSize(width: 24, height: 24)
        
        contentView.addSubview(rightChevronButton)
        
        rightChevronButton.frame = CGRect(
            x: contentView.right - rightChevronButton.width - 16,
            y: contentView.top + 16,
            width: rightChevronButton.width,
            height: rightChevronButton.height
        )
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
    
    private func setupDateLabel(startDate: Date, endDate: Date) {
        contentView.addSubview(dateLabel)
        
        dateLabel.text =
            Utils.getFormattedDateShorted(date: startDate) +
            " - " +
            Utils.getFormattedDateShortedWithYear(date: endDate)
        
        dateLabel.textColor = .grey1
        dateLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.sizeToFit()
        
        dateLabel.frame = CGRect(x: hotelNameLabel.left, y: hotelNameLabel.bottom + 8, width: dateLabel.width, height: dateLabel.height)
    }
    
    private func setupPetNameLabel(petName: String) {
        contentView.addSubview(petNameLabel)
        
        pawIconImageView.image = UIImage(named: "paw-icon")
        pawIconImageView.backgroundColor = .clear
        pawIconImageView.contentMode = .scaleAspectFill
        pawIconImageView.tintColor = .grey1
        
        contentView.addSubview(pawIconImageView)
        pawIconImageView.frame = CGRect(x: 16, y: hotelNameLabel.bottom + 35, width: 16, height: 16)
        
        petNameLabel.text = petName
        petNameLabel.backgroundColor = .clear
        petNameLabel.adjustsFontSizeToFitWidth = true
        petNameLabel.sizeToFit()
        petNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        petNameLabel.textColor = .grey1
        
        
        petNameLabel.frame = CGRect(x: pawIconImageView.right + 4, y: pawIconImageView.top - 2, width: petNameLabel.width, height: petNameLabel.height)
    }
    
    private func setupOrderLabelView(ordeLabel: OrderLabel) {
        orderLabelView = OrderLabelView(orderLabel: ordeLabel)
        guard let orderLabelView else { return }
        
        contentView.addSubview(orderLabelView)
        
        orderLabelView.frame = CGRect(x: 16, y: dividerView.bottom + 8, width: orderLabelView.width, height: orderLabelView.height)
    }
    
    private func setupDividerView() {
        contentView.addSubview(dividerView)
        
        dividerView.backgroundColor = .customLightGray242
        dividerView.frame = CGRect(x: hotelNameLabel.left, y: petNameLabel.bottom + 8, width: 342, height: 1)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
}
