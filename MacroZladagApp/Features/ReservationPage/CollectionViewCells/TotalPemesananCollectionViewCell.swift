//
//  TotalPemesananCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 20/12/23.
//

import UIKit

class TotalPemesananCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TotalPemesananCollectionViewCell"
    
    var cellsViewModel = [ReservationCellViewModel]()
    var anabulsCount: Int?
    var cagesPrice: Int?
    var addOnServicesPrice: Int?
    
    var pesanButton: UIButton? = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
    }
    
    public func configure(cellsViewModel: [ReservationCellViewModel]) {
        self.cellsViewModel = cellsViewModel
        self.anabulsCount = cellsViewModel.count
        
        var cagesPriceTemp: Int = 0
        var addOnServicesPriceTemp: Int = 0
        
        for cell in cellsViewModel {
            for cage in cell.cages {
                if cage.isTapped {
                    cagesPriceTemp += cage.price
                }
            }
            
            for service in cell.services {
                if service.isTapped {
                    addOnServicesPriceTemp += service.price                    
                }
            }
        }
        
        self.cagesPrice = cagesPriceTemp
        self.addOnServicesPrice = addOnServicesPriceTemp
        
//        print(">>", self.anabulsCount)
//        print(">>", cagesPrice)
//        print(">>", addOnServicesPrice)
        
        self.setupViews()
//        setupButton(cellsViewModel: cellsViewModel)
    }
    
    public func setupViews() {
        pesanButton = UIButton()
        
        guard let pesanButton else { return }
        
        let totalCagesLabel = self.getCustomUILabel(text: "Total Harga Penginapan (\(self.anabulsCount ?? 123) anabul)", size: 14, weight: .medium, color: .grey1)
        let totalCagesPriceLabel = self.getCustomUILabel(text: Utils.getStringRpCurrencyFormatted(self.cagesPrice ?? 123), size: 14, weight: .medium, color: .textBlack)
        
        let totalServicesLabel = self.getCustomUILabel(text: "Total Add-on Service", size: 14, weight: .medium, color: .grey1)
        let totalServicesPriceLabel = self.getCustomUILabel(text: Utils.getStringRpCurrencyFormatted(self.addOnServicesPrice ?? 123), size: 14, weight: .medium, color: .textBlack)
        
        let totalReservationLabel = self.getCustomUILabel(text: "Total Pemesanan", size: 14, weight: .medium, color: .textBlack)
        let totalReservationPriceLabel = self.getCustomUILabel(text: Utils.getStringRpCurrencyFormatted(((self.cagesPrice ?? 123) + (self.addOnServicesPrice ?? 123))), size: 16, weight: .bold, color: .grey1)
        
        contentView.addSubview(totalCagesLabel)
        contentView.addSubview(totalCagesPriceLabel)
        contentView.addSubview(totalServicesLabel)
        contentView.addSubview(totalServicesPriceLabel)
        contentView.addSubview(totalReservationLabel)
        contentView.addSubview(totalReservationPriceLabel)
        contentView.addSubview(pesanButton)

        pesanButton.backgroundColor = .red
        pesanButton.layer.cornerRadius = 4
        pesanButton.layer.masksToBounds = true
        
        let divider1 = UIView(); contentView.addSubview(divider1); divider1.backgroundColor = .grey3
        let divider2 = UIView(); contentView.addSubview(divider2); divider2.backgroundColor = .grey3
        
        totalCagesLabel.frame = CGRect(x: 24, y: 26, width: totalCagesLabel.width, height: totalCagesLabel.height)

        totalCagesPriceLabel.frame = CGRect(x: contentView.width - totalCagesPriceLabel.width - 24, y: 26, width: totalCagesPriceLabel.width, height: totalCagesPriceLabel.height)

        totalServicesLabel.frame = CGRect(x: 24, y: totalCagesLabel.bottom + 8, width: totalServicesLabel.width, height: totalServicesLabel.height)

        totalServicesPriceLabel.frame = CGRect(x: contentView.width - totalServicesPriceLabel.width - 24, y: totalCagesLabel.bottom + 8, width: totalServicesPriceLabel.width, height: totalServicesPriceLabel.height)

        divider1.frame = CGRect(x: 24, y: totalServicesLabel.bottom + 12, width: contentView.width - (24 * 2), height: 1)

        totalReservationLabel.frame = CGRect(x: 24, y: divider1.bottom + 12, width: totalReservationLabel.width, height: totalReservationLabel.height)

        totalReservationPriceLabel.frame = CGRect(x: contentView.width - totalReservationPriceLabel.width - 24, y: divider1.bottom + 12, width: totalReservationPriceLabel.width, height: totalReservationPriceLabel.height)

        divider2.frame = CGRect(x: 24, y: totalReservationLabel.bottom + 12, width: contentView.width - (24 * 2), height: 1)

        pesanButton.frame = CGRect(x: 24, y: divider2.bottom + 12, width: contentView.width - (24 * 2), height: 44)

        
        pesanButton.addTarget(self, action: #selector(onClickPesanSekarangButton), for: .touchUpInside)
    }
    
    private func getCustomUILabel(
        text: String,
        size: CGFloat,
        weight: UIFont.Weight,
        color: UIColor
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: size, weight: weight)
        label.textColor = color
        label.sizeToFit()
        
        return label
    }
    
    
    
    @objc func onClickPesanSekarangButton() {
        var z = 0
        for cell in self.cellsViewModel {
            print("\n==================================")
            print(cell.anabul) // Anjing 0
            
            print("\nCage:")
            for cage in cell.cages {
                if cage.isTapped {
                    print("\(cage.name) - \(cage.id)")
                }
            }
            
            print("\nService:")
            for service in cell.services {
                if service.isTapped {
                    print("\(service.name) - \(service.id)")
                }
            }
            
            print("\nPesan:")
            print(cell.pesan)
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pesanButton = nil
        
        // reset all UILabel's text
        for view in contentView.subviews {
            if let uiLabel = view as? UILabel {
                uiLabel.text = nil
            }
        }
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
}










