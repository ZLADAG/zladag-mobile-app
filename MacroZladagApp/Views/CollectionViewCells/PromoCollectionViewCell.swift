//
//  PromoCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 08/10/23.
//

import UIKit

class PromoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PromoCollectionViewCell"
    
    let promoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banner0")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        
        contentView.addSubview(promoImageView)
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() { // dipanggil setiap component  view muncul
        super.layoutSubviews()
        
        promoImageView.frame = CGRect(x: 0, y: 0, width: 320, height: 160)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        promoImageView.image = nil
    }
    
    func configure(with imageURL: String) {
//        promoImageView.sd_setImage(with: URL(string: APICaller.shared.getRandomImageURL(id: Int.random(in: 0...3))))
        promoImageView.image = UIImage(named: imageURL)
    }
    
}
