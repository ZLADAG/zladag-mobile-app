//
//  BoardingPhotosCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 11/10/23.
//

import UIKit

class BoardingPhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "boardingPhotoCollectionViewCell"
    
    let boardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banner0")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(boardingImageView)
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
//        contentView.layer.cornerRadius = 8
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() { // dipanggil setiap component  view muncul
        super.layoutSubviews()
        
//        boardingImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 198)
        boardingImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 198)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        boardingImageView.image = nil
    }
    
    func configure(with imageURL: String) {
//        promoImageView.sd_setImage(with: URL(string: APICaller.shared.getRandomImageURL(id: Int.random(in: 0...3))))
        boardingImageView.image = UIImage(named: imageURL)
        
        contentView.addSubview(boardingImageView)
        
        NSLayoutConstraint.activate([
            boardingImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            boardingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            boardingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            boardingImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
        

    }
}
