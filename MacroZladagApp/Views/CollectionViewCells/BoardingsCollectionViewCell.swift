//
//  BoardingsCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import UIKit
import SDWebImage

class BoardingsCollectionViewCell: UICollectionViewCell {
    static let identifier = "BoardingsCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .customOrange
        return imageView
    }()
    
    let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "location-icon-card")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .gray
        
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0 // bantu buat nge wrap text
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19  , weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let perEkorPerMalamLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .gray
        label.text = "per ekor per malam"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        
        contentView.addSubview(imageView)
        contentView.addSubview(starImageView)
        contentView.addSubview(locationImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(perEkorPerMalamLabel)
        contentView.addSubview(addressLabel)
        
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 4
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 5)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.15
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() { // dipanggil setiap component  view muncul
        super.layoutSubviews()
        
        let leading: CGFloat = 8
        
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: 124)
        imageView.backgroundColor = .white
        
        nameLabel.frame = CGRect(x: leading, y: imageView.bottom + 10, width: contentView.width, height: 19)
        
        starImageView.frame = CGRect(x: leading, y: nameLabel.bottom + 5, width: 16, height: 16)
        ratingLabel.frame = CGRect(x: starImageView.right + 5, y: nameLabel.bottom + 5, width: contentView.width, height: 16)
        
        locationImageView.frame = CGRect(x: leading, y: starImageView.bottom + 5, width: 16, height: 16)
        addressLabel.frame = CGRect(x: locationImageView.right + 5, y: ratingLabel.bottom + 5, width: contentView.width, height: 16)
        
        priceLabel.frame = CGRect(x: leading + 1, y: addressLabel.bottom + 36, width: contentView.width, height: 21)
        perEkorPerMalamLabel.frame = CGRect(x: leading + 1, y: priceLabel.bottom, width: contentView.width, height: 12)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        nameLabel.text = nil
        addressLabel.text = nil
    }
    
    func configure(with viewModel: HomeCellViewModel) {
        imageView.sd_setImage(with: URL(string: APICaller.shared.getImage(path: viewModel.imageURLString)))
        nameLabel.text = viewModel.name
        ratingLabel.attributedText = getRatingLabelAttributedString(rating: viewModel.rating, numOfReviews: viewModel.numOfReviews)
        addressLabel.text = "\(viewModel.subdistrictName), \(viewModel.provinceName)"
        
        priceLabel.text = "RM \(viewModel.price)"
    }
    
    func getRatingLabelAttributedString(rating: Double, numOfReviews: Int) -> NSMutableAttributedString {
        let firstAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .bold)
        ]
        
        let secondAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ]
        
        let firstString = NSMutableAttributedString(string: "\(rating) ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "(\(numOfReviews))", attributes: secondAttributes)
        
        firstString.append(secondString)
        
        return firstString
    }
}
