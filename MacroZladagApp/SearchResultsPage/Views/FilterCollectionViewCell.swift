//
//  FilterCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 10/10/23.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FilterCollectionViewCell"
    
    var viewControllerDelegate: SearchResultsViewController?
    
    var urutkanValue: String = "Paling Sesuai"
    var kategoriValues: [String] = []
    var fasilitasValues: [String] = []
    var kekhususanValues: [String] = []
    var minimumPriceValue: Int = 0
    var maximumPriceValue: Int = 9999999
    
    let filterButton: UIButton = {
        let button = UIButton()
        
        let icon = UIImageView(image: UIImage(named: "filter-icon"))
        icon.contentMode = .scaleAspectFit
        
        let label = UILabel()
        label.text = "Filter"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        
        
        button.addSubview(icon)
        button.addSubview(label)
        
        icon.frame = CGRect(x: 10, y: 8.5, width: 16, height: 16)
        label.frame = CGRect(x: icon.frame.maxX + 3, y: 4, width: 50, height: 25)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .customGray
        
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
        contentView.layer.borderColor = UIColor.customGray2.cgColor
        contentView.layer.borderWidth = 1
        addSubview(filterButton)
        
        filterButton.addTarget(self, action: #selector(showFilterSheet), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func showFilterSheet() {
        
        let vc  = FilterSheetViewController()
        vc.cellDelegate = self
        
        let navVc = UINavigationController(rootViewController: vc)
        
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 16
            sheet.detents = [
//                .custom(resolver: { context in
//                    0.35 * context.maximumDetentValue
//                })
                .large()
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        viewControllerDelegate?.navigationController?.present(navVc, animated: true, completion: nil)
        
//        delegate?.collectionView.re
        
        
    }
    
    override func layoutSubviews() { // dipanggil setiap component  view muncul
        super.layoutSubviews()
        
//        promoImageView.frame = CGRect(x: 0, y: 0, width: 320, height: 160)
        filterButton.frame = CGRect(x: 0, y: 0, width: 66, height: 33)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
}
