//
//  ReservationCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 17/12/23.
//

import UIKit

class ReservationCollectionViewCell: UICollectionViewCell {
    static let identifier = "ReservationCollectionViewCell"
    
    weak var viewModelCell: ReservationCellViewModel?
    weak var reservationViewController: ReservationViewController?
    
    var buttons = [UIButton]()
    var checkBoxes = [UIButton]()
    
    // MARK: SECTION LABELS
    let titleLabel = UILabel()
    var pilihProfilLabel = UILabel()
    var kandangLabel = UILabel()
    var addOnServiceLabel = UILabel()
    var tulisPesanLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white

    }
    
    // MARK: UI SETUPS
    
    public func configure(title: String, cellViewModel: ReservationCellViewModel) {
        titleLabel.text = title
        
        self.viewModelCell = cellViewModel
        
        guard let viewModelCell else { return }
        
        setupTitleLabel()
        setupPilihProfilLabel()
        setupKandangLabel()
        setupCageButtons(cages: viewModelCell.cages)
        setupAddonServiceLabel()
        setupServiceCheckBoxes(services: viewModelCell.services)
        setupTulisPesanLabel()
    }

    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .textBlack
        titleLabel.sizeToFit()
        
        titleLabel.frame = CGRect(
            x: 24,
            y: 16,
            width: titleLabel.width,
            height: titleLabel.height
        )
    }
    
    private func setupPilihProfilLabel() {
        pilihProfilLabel = self.getNecessaryLabel(string: "Pilih Profil")
        contentView.addSubview(pilihProfilLabel)
        
        pilihProfilLabel.frame = CGRect(x: 24, y: titleLabel.bottom + 16, width: pilihProfilLabel.width, height: pilihProfilLabel.height)
    }
    
    private func setupKandangLabel() {
        let divider = UIView(); divider.backgroundColor = .grey3; contentView.addSubview(divider)
        divider.frame = CGRect(x: 24, y: pilihProfilLabel.bottom + 100, width: contentView.width - (24 * 2), height: 1)
        
        kandangLabel = self.getNecessaryLabel(string: "Kandang")
        contentView.addSubview(kandangLabel)
        
        kandangLabel.frame = CGRect(x: 24, y: divider.bottom + 16, width: kandangLabel.width, height: kandangLabel.height)
    }
    
    private func setupCageButtons(cages: [ReservationCageDetails]) {
        for _ in cages {
            let button = UIButton()
            button.backgroundColor = .white
            
            self.buttons.append(button)
        }
        
        for i in 0..<cages.count {
            // SETUP BUTTON (RADIO)
            contentView.addSubview(buttons[i])
            buttons[i].addTarget(self, action: #selector(onClickCageRadioButton), for: .touchUpInside)
            buttons[i].layer.name = cages[i].id
            
            buttons[i].frame = CGRect(
                x: 24,
                y: (i == 0 ? kandangLabel.bottom + 0 : buttons[i - 1].bottom + 2),
                width: contentView.width - (24 * 2),
                height: 20 + 14
            )
            
            // SETUP RADIO ICON
            
            let radioImageView = UIImageView()
            buttons[i].addSubview(radioImageView)
            
            radioImageView.image = UIImage(named: "reservation-radiobutton-icon")
            radioImageView.contentMode = .scaleAspectFill
            
            radioImageView.tintColor = cages[i].isTapped ? .customOrange : .clear
            radioImageView.layer.cornerRadius = CGFloat(20.0 / 2.0)
            radioImageView.layer.borderColor = UIColor.grey6.cgColor
            radioImageView.layer.borderWidth = cages[i].isTapped ? 0 : 1
            
            radioImageView.frame = CGRect(
                x: 0,
                y: (buttons[i].height / 2) - 10,
                width: 20,
                height: 20
            )
            
            // SETUP CAGE LABEL
            let cageLabel = UILabel()
            buttons[i].addSubview(cageLabel)
            
            cageLabel.text = cages[i].name
            cageLabel.font = .systemFont(ofSize: 14, weight: .medium)
            cageLabel.textColor = .textBlack
            cageLabel.sizeToFit()
            cageLabel.frame = CGRect(
                x: radioImageView.right + 16,
                y: (buttons[i].height / 2) - (cageLabel.height / 2),
                width: cageLabel.width,
                height: cageLabel.height
            )
            
            // SETUP PRICE LABEL
            let cagePriceLabel = UILabel()
            buttons[i].addSubview(cagePriceLabel)
            cagePriceLabel.text = cages[i].priceString
            cagePriceLabel.font = .systemFont(ofSize: 14, weight: .medium)
            cagePriceLabel.textColor = .textBlack
            cagePriceLabel.textAlignment = .left
            cagePriceLabel.sizeToFit()
            cagePriceLabel.frame = CGRect(
                x: buttons[i].width - cagePriceLabel.width,
                y: (buttons[i].height / 2) - (cagePriceLabel.height / 2),
                width: cagePriceLabel.width,
                height: cagePriceLabel.height
            )
        }
    }
    
    private func setupAddonServiceLabel() {
        let divider = UIView(); divider.backgroundColor = .grey3; contentView.addSubview(divider)
        divider.frame = CGRect(x: 24, y: buttons[buttons.count - 1].bottom + 30, width: contentView.width - (24 * 2), height: 1)
        
        addOnServiceLabel = self.getNecessaryLabel(string: "Add-on Service", necessary: false)
        contentView.addSubview(addOnServiceLabel)
        
        addOnServiceLabel.frame = CGRect(x: 24, y: divider.bottom + 16, width: addOnServiceLabel.width, height: addOnServiceLabel.height)
    }
    
    private func setupServiceCheckBoxes(services: [ReservationServiceDetails]) {
        for _ in services {
            let button = UIButton()
            button.backgroundColor = .white
            
            self.checkBoxes.append(button)
        }
        
        for i in 0..<services.count {
            // SETUP BUTTON (CHECKBOX)
            contentView.addSubview(checkBoxes[i])
            checkBoxes[i].addTarget(self, action: #selector(onClickServiceCheckBoxButton), for: .touchUpInside)
            checkBoxes[i].layer.name = services[i].id
            
            checkBoxes[i].frame = CGRect(
                x: 24,
                y: (i == 0 ? addOnServiceLabel.bottom + 0 : checkBoxes[i - 1].bottom + 2),
                width: contentView.width - (24 * 2),
                height: 20 + 14
            )
            
            // SETUP CHECKBOX ICON
            
            let checkboxImageView = UIImageView()
            checkBoxes[i].addSubview(checkboxImageView)
            
            checkboxImageView.image = services[i].isTapped ? UIImage(named: "reservation-checkbox-icon") : UIImage(named: "unselect-checkbox-icon")
            checkboxImageView.contentMode = .scaleAspectFill
            
            checkboxImageView.frame = CGRect(
                x: 0,
                y: (checkBoxes[i].height / 2) - 10,
                width: 20,
                height: 20
            )
            
            // SETUP SERVICE LABEL
            let serviceLabel = UILabel()
            checkBoxes[i].addSubview(serviceLabel)
            
            serviceLabel.text = services[i].name
            serviceLabel.font = .systemFont(ofSize: 14, weight: .medium)
            serviceLabel.textColor = .textBlack
            serviceLabel.sizeToFit()
            serviceLabel.frame = CGRect(
                x: checkboxImageView.right + 16,
                y: (checkBoxes[i].height / 2) - (serviceLabel.height / 2),
                width: serviceLabel.width,
                height: serviceLabel.height
            )
            
            // SETUP PRICE LABEL
            let cagePriceLabel = UILabel()
            checkBoxes[i].addSubview(cagePriceLabel)
            cagePriceLabel.text = services[i].priceString
            cagePriceLabel.font = .systemFont(ofSize: 14, weight: .medium)
            cagePriceLabel.textColor = .textBlack
            cagePriceLabel.textAlignment = .left
            cagePriceLabel.sizeToFit()
            cagePriceLabel.frame = CGRect(
                x: checkBoxes[i].width - cagePriceLabel.width,
                y: (checkBoxes[i].height / 2) - (cagePriceLabel.height / 2),
                width: cagePriceLabel.width,
                height: cagePriceLabel.height
            )
        }
    }
    
    private func setupTulisPesanLabel() {
        let divider = UIView(); divider.backgroundColor = .grey3; contentView.addSubview(divider)
        divider.frame = CGRect(x: 24, y: checkBoxes[checkBoxes.count - 1].bottom + 9, width: contentView.width - (24 * 2), height: 1)
        
        tulisPesanLabel = self.getNecessaryLabel(string: "Tulis Pesan", necessary: false)
        contentView.addSubview(tulisPesanLabel)
        
        tulisPesanLabel.frame = CGRect(x: 24, y: divider.bottom + 16, width: tulisPesanLabel.width, height: tulisPesanLabel.height)
    }
    
    private func setupTextView() {
        
    }
    
    
    // MARK: Misc.
    
    @objc func onClickCageRadioButton(button: UIButton) {
        guard let viewModelCell else { return }
        // print("cageId:", button.layer.name ?? "NO-LAYER-NAME")
        
        for cage in viewModelCell.cages {
            if cage.id == (button.layer.name ?? "NO-LAYER-NAME") {
                cage.isTapped = !cage.isTapped
            } else {
                cage.isTapped = false
            }
        }
        
        reservationViewController?.collectionView.reloadData()
    }
    
    @objc func onClickServiceCheckBoxButton(button: UIButton) {
        guard let viewModelCell else { return }
        // print("serviceId:", button.layer.name ?? "NO-LAYER-NAME")
        
        for service in viewModelCell.services {
            if service.id == (button.layer.name ?? "NO-LAYER-NAME") {
                service.isTapped = !service.isTapped
            }
        }
        
        reservationViewController?.collectionView.reloadData()
    }
    
    private func getNecessaryLabel(string: String, necessary: Bool = true) -> UILabel {
        let label = UILabel()
        
        let firstAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium),
            .foregroundColor: UIColor.textBlack.cgColor
        ]
        var secondAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)
        ]
        
        if necessary {
            secondAttributes[NSAttributedString.Key.foregroundColor] = UIColor.textRed.cgColor
        } else {
            secondAttributes[NSAttributedString.Key.foregroundColor] = UIColor.clear.cgColor
        }
        
        let firstString = NSMutableAttributedString(string: string, attributes: firstAttributes)
        let secondString = NSAttributedString(string: "*", attributes: secondAttributes)
        
        firstString.append(secondString)
        
        label.backgroundColor = .clear
        label.attributedText = firstString
        label.sizeToFit()
        
        return label
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        self.buttons = []
        self.checkBoxes = []
        
        pilihProfilLabel.text = nil
        kandangLabel.text = nil
        addOnServiceLabel.text = nil
        tulisPesanLabel.text = nil

    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
}
