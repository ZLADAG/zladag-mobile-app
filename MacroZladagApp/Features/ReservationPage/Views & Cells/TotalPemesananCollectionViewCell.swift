//
//  TotalPemesananCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 20/12/23.
//

import UIKit
import HorizonCalendar

class TotalPemesananCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TotalPemesananCollectionViewCell"
    
    weak var reservationController: ReservationViewController?
    
    var boardingSlug: String = ""
    var cellsViewModel = [ReservationCellViewModel]()
    var anabulsCount: Int?
    var cagesPrice: Int?
    var addOnServicesPrice: Int?
    
    let pesanButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
    }
    
    public func configure(boardingSlug: String, cellsViewModel: [ReservationCellViewModel]) {
        self.boardingSlug = boardingSlug
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

        pesanButton.backgroundColor = .customOrange
        pesanButton.layer.cornerRadius = 4
        pesanButton.layer.masksToBounds = true
        
        let buttonLabel = UILabel()
        buttonLabel.text = "Pesan Sekarang"
        buttonLabel.font = .systemFont(ofSize: 16, weight: .bold)
        buttonLabel.textColor = .white
        buttonLabel.sizeToFit()
        
        pesanButton.addSubview(buttonLabel)
        
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
        buttonLabel.frame = CGRect(x: (pesanButton.width / 2) - (buttonLabel.width / 2), y: (pesanButton.height / 2) - (buttonLabel.height / 2), width: buttonLabel.width, height: buttonLabel.height)

        
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
        let chosenAnabuls: [ChosenAnabul]  = self.cellsViewModel.compactMap { cell in
            return cell.chosenAnabul
        }
        
        guard (chosenAnabuls.count > 0) else {
            let alert = UIAlertController(title: "Please set your Anabul to minimum of 1 form!", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.reservationController?.present(alert, animated: true)
            
            return
        }
        
        var cagesAreTappedArray = [Bool]()
        for cell in self.cellsViewModel {
            for chosenAnabul in chosenAnabuls {
                if cell.chosenAnabul == chosenAnabul {
                    
                    var cageIsTapped = false
                    for cage in cell.cages {
                        if cage.isTapped {
                            cageIsTapped = true
                            break
                        }
                    }
                    cagesAreTappedArray.append(cageIsTapped)
                }
            }
        }
        
        for isTapped in cagesAreTappedArray {
            if !isTapped {
                let alert = UIAlertController(title: "You haven't chosen all your Anabuls' Cages!", message: "", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.reservationController?.present(alert, animated: true)
                
                return
            }
        }
        print("====================================")
        
        var dateString1 = ""
        var dateString2 = ""
        
        if
            let horizonDay1 = AppAccountManager.shared.selectedDay1,
            let horizonDay2 = AppAccountManager.shared.selectedDay2
        {
            dateString1 = "\(horizonDay1.month.year)-\(horizonDay1.month.month)-\(horizonDay1.day)"
            dateString2 = "\(horizonDay2.month.year)-\(horizonDay2.month.month)-\(horizonDay2.day)"
        } else {
            dateString1 = AppAccountManager.shared.dateString1
            dateString2 = AppAccountManager.shared.dateString2
        }

        print("\nboarding: \(self.boardingSlug)")
        print("checkInDate: \(dateString1)")
        print("checkOutDate: \(dateString2)")
        
        print("orders: ")
        var postProfileOrders = [PostProfileOrder]()
        
        for cell in self.cellsViewModel {
            var boardingCageId = ""
            for cage in cell.cages {
                if cage.isTapped {
                    boardingCageId = cage.id
                    break
                }
            }
            
            
            var boardingServiceIds = [String]()
            for service in cell.services {
                if service.isTapped {
                    boardingServiceIds.append(service.id)
                }
            }
            
            if let chosenAnabul = cell.chosenAnabul {
                let postProfileOrder = PostProfileOrder(
                    petId: chosenAnabul.id,
                    note: cell.pesan,
                    boardingCageId: boardingCageId,
                    boardingServiceIds: boardingServiceIds
                )
                postProfileOrders.append(postProfileOrder)
                print("\tpetId: \(chosenAnabul.id) - \(chosenAnabul.petName)")
                print("\tboardingCageId:", boardingCageId)
                print("\tboardingServiceIds: \(boardingServiceIds.description)")
                print("\tnote: \(cell.pesan)")
                print()
            }
            
        }
        
        // SETUP LOADING SCREEN
        
        let aView = UIView()
        aView.backgroundColor = .white
        aView.layer.opacity = 0.6
        
        let spinner: UIActivityIndicatorView = {
            let spinner = UIActivityIndicatorView()
            spinner.style = .large
            spinner.color = .customOrange
            spinner.backgroundColor = .clear
            return spinner
        }()
        
        aView.addSubview(spinner)
        self.reservationController?.view.addSubview(aView)
        
        let superView: UIView = self.reservationController!.view
        
        aView.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aView.topAnchor.constraint(equalTo: superView.topAnchor),
            aView.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            aView.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            aView.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: aView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: aView.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
            
            
        let postProfileOrdersBody = PostProfileOrdersBody(
            boarding: self.boardingSlug,
            checkInDate: dateString1,
            checkOutDate: dateString2,
            orders: postProfileOrders
        )
        
        APICaller.shared.postPetOrder(postOrdersBody: postProfileOrdersBody) { result in
            switch result {
            case .success(let response):
                print(response.success)
            case .failure(let error):
                print("ERROR WHEN POST postPetOrder: \(error)")
            }
            
            DispatchQueue.main.async {
                spinner.stopAnimating()                
                aView.removeFromSuperview()
                
                self.presentSuccessSheet()
            }
        }
    }
    
    private func presentSuccessSheet() {
        let vc = PesananTersimpanViewController()
        vc.modalPresentationStyle = .fullScreen

        self.reservationController?.present(vc, animated: true)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pesanButton.removeFromSuperview()
        
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










