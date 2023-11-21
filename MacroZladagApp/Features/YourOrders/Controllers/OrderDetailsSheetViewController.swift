//
//  OrderDetailsSheetViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 20/11/23.
//

import UIKit
import SDWebImage

class OrderDetailsSheetViewController: UIViewController {

    let viewModel: OrderDetailsByIdViewModel
    
    init(viewModel: OrderDetailsByIdViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: SCROLL VIEW
    
    let scrollView = UIScrollView()
    let contentView: UIView = {
        let view = UIView()
//        view.layer.borderColor = UIColor.green.cgColor
//        view.layer.borderWidth = 1
        return view
    }()
    var bottomConstraintContentView = NSLayoutConstraint()
    
    let scrollViewRefreshControl = UIRefreshControl()
    
    // MARK: MAIN & SUB LABELS
    var mainLabelString = "Menunggu konfirmasi"
    var subLabelString = "Pet hotel akan segera mengkonfirmasi pesananmu"
    
    let mainLabel = UILabel()
    let subLabel = UILabel()
    
    // MARK: HOTEL BUTTON
    let hotelButton = UIButton()
    let hotelButtonLabel = UILabel()
    let hotelButtonSubLabel = UILabel()
    
    // MARK: JADWAL PENITIPAN LABELS
    var jadwalPenitipanLabel: UILabel!
    var dateLabel: UILabel!
    
    // MARK: ANABUL & LAYANAN CARD VIEW
    let anabulDanLayananCardView = UIView()
    var anabulDanLayananLabel: UILabel!
    var bottomConstraintAnabulDanLayananCardView = NSLayoutConstraint()
    
    
    
    // MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(viewModel.boardingName)
        
        setupNavBar()
        setupUI()
    }
    
    
    private func setupUI() {
        setupScrollView()
        setupMainAndSubLabels()
        setupHotelButton()
        setupJadwalPenitipan()
        setupAnabulDanLayananSection()
        setupPricingSection()
    }
    
    private func setupScrollView() {
//        scrollViewRefreshControl.addTarget(self, action: #selector(onPullToRefreshScrollView), for: .valueChanged)
//        scrollView.refreshControl = self.scrollViewRefreshControl
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.delegate = self
        
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -56 + 24),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalToConstant: view.width - (24 * 2)),
        ])
    }
    
    private func setupMainAndSubLabels() {
        let orderStatus: String = viewModel.orderStatus
        self.mainLabelString = orderStatus
        
        switch orderStatus {
        case "Menunggu Konfirmasi":
            self.subLabelString = "Pet hotel akan segera mengkonfirmasi pesananmu"
            break
        case "Diterima":
            self.subLabelString = "Pet hotel akan segera mengkonfirmasi pesananmu"
            break
        case "Dititipkan":
            self.subLabelString = "Mau tau updatenya? Klik \"Chat pet hotel\""
            break
        case "Selesai":
            self.subLabelString = "Sampai jumpa di perjalanan berikutnya!"
            break
        case "Gagal":
            self.subLabelString = "Sampai jumpa di perjalanan berikutnyag!"
            break
        default:
            self.subLabelString = "Pet hotel akan segera mengkonfirmasi pesananmu"
            print("\nFAILED\nSWITCH-CASE STATUS TO DEFAULT\n(in OrderDetailsSheetViewController): \"\(orderStatus)\"\n")
            break
        }
        
        scrollView.addSubview(mainLabel)
        scrollView.addSubview(subLabel)
        
        mainLabel.backgroundColor = .clear
        mainLabel.text = self.mainLabelString
        mainLabel.textColor = .textBlack
        mainLabel.textAlignment = .center
        mainLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        subLabel.backgroundColor = .clear
        subLabel.text = self.subLabelString
        subLabel.textColor = .grey1
        subLabel.textAlignment = .center
        subLabel.numberOfLines = 2
        subLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 20),

            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 4),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.widthAnchor.constraint(equalToConstant: 332),
            subLabel.heightAnchor.constraint(equalToConstant:  36 + 2),
        ])
    }
    
    private func setupHotelButton() {
        scrollView.addSubview(hotelButton)
        
        hotelButton.addSubview(hotelButtonLabel)
        hotelButton.addSubview(hotelButtonSubLabel)
        
        let rightChevronImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        rightChevronImageView.contentMode = .scaleAspectFill
        rightChevronImageView.tintColor = . textBlack
        rightChevronImageView.frame.size = CGSize(width: 17.25, height: 9.75)
        hotelButton.addSubview(rightChevronImageView)
        
        hotelButton.backgroundColor = .clear
        hotelButtonLabel.backgroundColor = .clear
        hotelButtonSubLabel.backgroundColor = .clear
        
        // BUTTON
        hotelButton.frame.size = CGSize(width: 342, height: 70)
        hotelButton.layer.borderColor = UIColor.grey3.cgColor
        hotelButton.layer.borderWidth = 1
        hotelButton.layer.masksToBounds = true
        hotelButton.layer.cornerRadius = 8
        
        hotelButton.addTarget(self, action: #selector(onClickHotelButton), for: .touchUpInside)
        
        // LABEL
        hotelButtonLabel.text = self.viewModel.boardingName
        hotelButtonLabel.textColor = .textBlack
        hotelButtonLabel.textAlignment = .left
        hotelButtonLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        // SUBLABEL
        hotelButtonSubLabel.text = "\(self.viewModel.subdistrict), \(self.viewModel.province)"
        hotelButtonSubLabel.textColor = .textBlack
        hotelButtonSubLabel.textAlignment = .left
        hotelButtonSubLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        // SUBLABEL
        
        // CONSTRAINTS
        hotelButton.translatesAutoresizingMaskIntoConstraints = false
        rightChevronImageView.translatesAutoresizingMaskIntoConstraints = false
        hotelButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        hotelButtonSubLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hotelButton.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 40),
            hotelButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hotelButton.widthAnchor.constraint(equalToConstant: hotelButton.width),
            hotelButton.heightAnchor.constraint(equalToConstant: hotelButton.height),
            
            rightChevronImageView.trailingAnchor.constraint(equalTo: hotelButton.trailingAnchor, constant: -23),
            rightChevronImageView.centerYAnchor.constraint(equalTo: hotelButton.centerYAnchor),
            rightChevronImageView.widthAnchor.constraint(equalToConstant: rightChevronImageView.width),
            rightChevronImageView.heightAnchor.constraint(equalToConstant: rightChevronImageView.height),
            
            hotelButtonLabel.leadingAnchor.constraint(equalTo: hotelButton.leadingAnchor, constant: 16),
            hotelButtonLabel.topAnchor.constraint(equalTo: hotelButton.topAnchor, constant: 16),
            hotelButtonLabel.trailingAnchor.constraint(equalTo: rightChevronImageView.leadingAnchor),
            hotelButtonLabel.heightAnchor.constraint(equalToConstant: 20),
            
            hotelButtonSubLabel.leadingAnchor.constraint(equalTo: hotelButton.leadingAnchor, constant: 16),
            hotelButtonSubLabel.topAnchor.constraint(equalTo: hotelButtonLabel.bottomAnchor, constant: 0),
            hotelButtonSubLabel.trailingAnchor.constraint(equalTo: rightChevronImageView.leadingAnchor),
            hotelButtonSubLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    private func setupJadwalPenitipan() {
        self.jadwalPenitipanLabel = createLabelBold14(for: "Jadwal Penitipan")
        
        // CONFIGURING DATE LABEL
        var minDate = Date()
        var maxDate = Date()
        
        if let minDateTemp = Utils.getDateFromString(dateString: self.viewModel.checkInDate),
           let maxDateTemp = Utils.getDateFromString(dateString: self.viewModel.checkOutDate)
        {
            minDate = minDateTemp
            maxDate = maxDateTemp
        } else {
            maxDate = Date().addingTimeInterval(3600 * 24 * 10)
        }
        
        self.dateLabel = createLabelMedium14(for: "\(Utils.getFormattedDateShorted(date: minDate)) - \(Utils.getFormattedDateShortedWithYear(date: maxDate))")
        
        // CONSTRAINTS
        scrollView.addSubview(jadwalPenitipanLabel)
        scrollView.addSubview(dateLabel)
        
        jadwalPenitipanLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            jadwalPenitipanLabel.topAnchor.constraint(equalTo: hotelButton.bottomAnchor, constant: 24),
            jadwalPenitipanLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            jadwalPenitipanLabel.widthAnchor.constraint(equalToConstant: jadwalPenitipanLabel.width),
            jadwalPenitipanLabel.heightAnchor.constraint(equalToConstant: jadwalPenitipanLabel.height),
            
            dateLabel.topAnchor.constraint(equalTo: jadwalPenitipanLabel.bottomAnchor, constant: 7),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    // MARK: ANABUL & LAYANAN
    
    private func setupAnabulDanLayananSection() {
        setupAnabulDanLayananLabel()
        
        // loop...
        setupAnabulDanLayananCardView() // masuk view model Pet Details!
    }
    
    private func setupAnabulDanLayananLabel() {
        self.anabulDanLayananLabel = createLabelBold14(for: "Anabul & layanan")
        
        // CONSTRAINTS
        scrollView.addSubview(anabulDanLayananLabel)
        anabulDanLayananLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            anabulDanLayananLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24),
            anabulDanLayananLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            anabulDanLayananLabel.widthAnchor.constraint(equalToConstant: anabulDanLayananLabel.width),
            anabulDanLayananLabel.heightAnchor.constraint(equalToConstant: anabulDanLayananLabel.height),
        ])
    }
    
    private func setupAnabulDanLayananCardView() {
        
        scrollView.addSubview(anabulDanLayananCardView)
        
        anabulDanLayananCardView.backgroundColor = .clear
        anabulDanLayananCardView.layer.borderColor = UIColor.grey3.cgColor
        anabulDanLayananCardView.layer.borderWidth = 1
        anabulDanLayananCardView.layer.cornerRadius = 4
        anabulDanLayananCardView.layer.masksToBounds = true
        
        anabulDanLayananCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            anabulDanLayananCardView.topAnchor.constraint(equalTo: anabulDanLayananLabel.bottomAnchor, constant: 8),
            anabulDanLayananCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            anabulDanLayananCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            anabulDanLayananCardView.heightAnchor.constraint(equalToConstant: 330),
        ])
        
        // TODO: DYNAMIC BOTTOM CONSTRAINT!
//        self.bottomConstraintAnabulDanLayananCardView
        
        
        // MARK: SETUP PET INFO
        let petImageView = UIImageView()
        
        petImageView.frame.size = CGSize(width: 48, height: 48)
        petImageView.layer.cornerRadius = CGFloat(48 / 2)
        petImageView.layer.masksToBounds = true
        
        if let imageString = self.viewModel.petImage {
            petImageView.sd_setImage(with: URL(string: APICaller.shared.getImage(path: imageString)))
        } else {
            if self.viewModel.petBreed.lowercased().starts(with: "cat") {
                petImageView.image = UIImage(named: "default-cat-image")
            } else if self.viewModel.petBreed.lowercased().starts(with: "dog") {
                petImageView.image = UIImage(named: "default-dog-image")
            } else {
                petImageView.image = UIImage(named: "default-dog-image")
            }
        }
        
        let petLabel = UILabel()
        let petSubLabel = UILabel()
        
        petLabel.text = self.viewModel.petName
        petLabel.textColor = .black
        petLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        petSubLabel.text = "\(self.viewModel.petBreed)  ·  \(self.viewModel.petAge) tahun"
        petSubLabel.textColor = .grey1
        petSubLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .grey3
        
        scrollView.addSubview(petImageView)
        scrollView.addSubview(petLabel)
        scrollView.addSubview(petSubLabel)
        scrollView.addSubview(dividerView)
        
        petImageView.translatesAutoresizingMaskIntoConstraints = false
        petLabel.translatesAutoresizingMaskIntoConstraints = false
        petSubLabel.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petImageView.leadingAnchor.constraint(equalTo: anabulDanLayananCardView.leadingAnchor, constant: 16),
            petImageView.topAnchor.constraint(equalTo: anabulDanLayananCardView.topAnchor, constant: 16),
            petImageView.widthAnchor.constraint(equalToConstant: petImageView.width),
            petImageView.heightAnchor.constraint(equalToConstant: petImageView.height),
            
            petLabel.leadingAnchor.constraint(equalTo: petImageView.trailingAnchor, constant: 12),
            petLabel.topAnchor.constraint(equalTo: petImageView.topAnchor),
            petLabel.trailingAnchor.constraint(equalTo: anabulDanLayananCardView.trailingAnchor, constant: -16),
            petLabel.heightAnchor.constraint(equalToConstant: 20),
            
            petSubLabel.leadingAnchor.constraint(equalTo: petImageView.trailingAnchor, constant: 12),
            petSubLabel.topAnchor.constraint(equalTo: petLabel.bottomAnchor, constant: 4),
            petSubLabel.trailingAnchor.constraint(equalTo: anabulDanLayananCardView.trailingAnchor, constant: -16),
            petSubLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dividerView.topAnchor.constraint(equalTo: petImageView.bottomAnchor, constant: 24),
            dividerView.leadingAnchor.constraint(equalTo: anabulDanLayananCardView.leadingAnchor, constant: 16),
            dividerView.trailingAnchor.constraint(equalTo: anabulDanLayananCardView.trailingAnchor, constant: -16),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // MARK: SETUP BOARDING CAGE
        
        let penitipanLabel: UILabel = createLabelBold14(for: "Penitipan")
        var cageTypeLabel: UILabel!
        
        switch self.viewModel.boardingCage.name {
        case "S":
            cageTypeLabel = createLabelMedium14(for: "Kandang Kecil")
            break
        case "M":
            cageTypeLabel = createLabelMedium14(for: "Kandang Normal")
            break
        case "L":
            cageTypeLabel = createLabelMedium14(for: "Kandang Besar")
            break
        case "VIP":
            cageTypeLabel = createLabelMedium14(for: "Kandang VIP")
            break
        default:
            cageTypeLabel = createLabelMedium14(for: "Kandang \(self.viewModel.boardingCage.name)")
            print("\nSWITCH TO DEFAULT: cageTypeLabel, value: \(self.viewModel.boardingCage.name)\n")
            break
        }
        
        let cagePriceLabel: UILabel = createLabelMedium14(for: Utils.getStringRpCurrencyFormatted(self.viewModel.boardingCage.price))
        
        scrollView.addSubview(penitipanLabel)
        scrollView.addSubview(cageTypeLabel)
        scrollView.addSubview(cagePriceLabel)
        
        penitipanLabel.translatesAutoresizingMaskIntoConstraints = false
        cageTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        cagePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            penitipanLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 24),
            penitipanLabel.leadingAnchor.constraint(equalTo: anabulDanLayananCardView.leadingAnchor, constant: 16),
            penitipanLabel.widthAnchor.constraint(equalToConstant: penitipanLabel.width),
            penitipanLabel.heightAnchor.constraint(equalToConstant: penitipanLabel.height),
            
            cageTypeLabel.topAnchor.constraint(equalTo: penitipanLabel.bottomAnchor, constant: 5),
            cageTypeLabel.leadingAnchor.constraint(equalTo: anabulDanLayananCardView.leadingAnchor, constant: 16),
            cageTypeLabel.widthAnchor.constraint(equalToConstant: cageTypeLabel.width),
            cageTypeLabel.heightAnchor.constraint(equalToConstant: cageTypeLabel.height),
            
            cagePriceLabel.topAnchor.constraint(equalTo: cageTypeLabel.topAnchor),
            cagePriceLabel.trailingAnchor.constraint(equalTo: anabulDanLayananCardView.trailingAnchor, constant: -16),
            cagePriceLabel.widthAnchor.constraint(equalToConstant: cagePriceLabel.width),
            cagePriceLabel.heightAnchor.constraint(equalToConstant: cagePriceLabel.height),
        ])
        
        // IF: NO boardingServices && NO Notes
        if (self.viewModel.boardingServices.count == 0) && (self.viewModel.note == nil) {
            self.bottomConstraintAnabulDanLayananCardView = anabulDanLayananCardView.bottomAnchor.constraint(equalTo: cageTypeLabel.bottomAnchor, constant: 16)
            bottomConstraintAnabulDanLayananCardView.isActive = true
        }
        
        // MARK: ADD-ON SERVICE
        
        var boardingServiceLabels = [UILabel]()
        var boardingServicePriceLabels = [UILabel]()
        
        if self.viewModel.boardingServices.count > 0 {
            
            let addOnServiceLabel: UILabel = createLabelBold14(for: "Add-on service")
            
            scrollView.addSubview(addOnServiceLabel)
            
            addOnServiceLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                addOnServiceLabel.topAnchor.constraint(equalTo: cageTypeLabel.bottomAnchor, constant: 24),
                addOnServiceLabel.leadingAnchor.constraint(equalTo: anabulDanLayananCardView.leadingAnchor, constant: 16),
                addOnServiceLabel.widthAnchor.constraint(equalToConstant: addOnServiceLabel.width),
                addOnServiceLabel.heightAnchor.constraint(equalToConstant: addOnServiceLabel.height),
            ])
            
            let boardingServices = self.viewModel.boardingServices
            
            var idx = 0
            for boardingService in boardingServices {
                let serviceLabel: UILabel = createLabelMedium14(for: boardingService.name)
                let servicePriceLabel: UILabel = createLabelMedium14(for: "+" + Utils.getStringRpCurrencyFormatted(boardingService.price))
                
                boardingServiceLabels.append(serviceLabel)
                boardingServicePriceLabels.append(servicePriceLabel)
                
                let tempServiceLabel = boardingServiceLabels.last!
                let tempServicePriceLabel = boardingServicePriceLabels.last!
                
                scrollView.addSubview(tempServiceLabel)
                scrollView.addSubview(tempServicePriceLabel)
                
                tempServiceLabel.translatesAutoresizingMaskIntoConstraints = false
                tempServicePriceLabel.translatesAutoresizingMaskIntoConstraints = false
                
                tempServiceLabel.leadingAnchor.constraint(equalTo: anabulDanLayananCardView.leadingAnchor, constant: 16).isActive = true
                tempServiceLabel.widthAnchor.constraint(equalToConstant: tempServiceLabel.width).isActive = true
                tempServiceLabel.heightAnchor.constraint(equalToConstant: tempServiceLabel.height).isActive = true
                
                tempServicePriceLabel.topAnchor.constraint(equalTo: tempServiceLabel.topAnchor).isActive = true
                tempServicePriceLabel.trailingAnchor.constraint(equalTo: anabulDanLayananCardView.trailingAnchor, constant: -16).isActive = true
                tempServicePriceLabel.widthAnchor.constraint(equalToConstant: tempServicePriceLabel.width).isActive = true
                tempServicePriceLabel.heightAnchor.constraint(equalToConstant: tempServicePriceLabel.height).isActive = true

                if idx == 0 {
                    tempServiceLabel.topAnchor.constraint(equalTo: addOnServiceLabel.bottomAnchor, constant: 5).isActive = true
                } else {
                    tempServiceLabel.topAnchor.constraint(equalTo: boardingServiceLabels[boardingServiceLabels.count - 2].bottomAnchor, constant: 5).isActive = true
                }
                
                idx += 1
            }
            
            // IF: YES boardingServices && NO Notes
            if self.viewModel.note == nil {
                self.bottomConstraintAnabulDanLayananCardView = anabulDanLayananCardView.bottomAnchor.constraint(equalTo: boardingServiceLabels[boardingServiceLabels.count - 1].bottomAnchor, constant: 16)
                bottomConstraintAnabulDanLayananCardView.isActive = true
            }
        }
        
        // MARK: NOTES
        
        if let note = self.viewModel.note {
            let notesLabel = createLabelBold14(for: "Notes")
            let notesValueLabel = createLabelMedium14(for: note)
            
            scrollView.addSubview(notesLabel)
            scrollView.addSubview(notesValueLabel)
            
            notesLabel.translatesAutoresizingMaskIntoConstraints = false
            notesValueLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                notesLabel.leadingAnchor.constraint(equalTo: anabulDanLayananCardView.leadingAnchor, constant: 16),
                notesLabel.widthAnchor.constraint(equalToConstant: notesLabel.width),
                notesLabel.heightAnchor.constraint(equalToConstant: notesLabel.height),
                
                notesValueLabel.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 5),
                notesValueLabel.leadingAnchor.constraint(equalTo: anabulDanLayananCardView.leadingAnchor, constant: 16),
                notesValueLabel.widthAnchor.constraint(equalToConstant: notesValueLabel.width),
                notesValueLabel.heightAnchor.constraint(equalToConstant: notesValueLabel.height),
            ])
            
            // IF: NO boardingServices && YES Notes
            if self.viewModel.boardingServices.count == 0 {
                notesLabel.topAnchor.constraint(equalTo: cageTypeLabel.bottomAnchor, constant: 24).isActive = true
            } else {
                // IF: YES boardingServices && YES Notes
                notesLabel.topAnchor.constraint(equalTo: boardingServiceLabels[boardingServiceLabels.count - 1].bottomAnchor, constant: 24).isActive = true
            }
            
            self.bottomConstraintAnabulDanLayananCardView = anabulDanLayananCardView.bottomAnchor.constraint(equalTo: notesValueLabel.bottomAnchor, constant: 16)
            bottomConstraintAnabulDanLayananCardView.isActive = true
        }
    }
    
    // MARK: PRICING
    
    private func setupPricingSection() {
        let upperDivider = UIView()
        upperDivider.backgroundColor = .grey3
        
        let subTotalLabel = createLabelMedium14(for: "Subtotal Penginapan")
        let subTotalPriceLabel = createLabelMedium14(for: Utils.getStringRpCurrencyFormatted(self.viewModel.totalLodgingPrice))
        
        scrollView.addSubview(upperDivider)
        scrollView.addSubview(subTotalLabel)
        scrollView.addSubview(subTotalPriceLabel)
        
        upperDivider.translatesAutoresizingMaskIntoConstraints = false
        subTotalLabel.translatesAutoresizingMaskIntoConstraints = false
        subTotalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upperDivider.topAnchor.constraint(equalTo: anabulDanLayananCardView.bottomAnchor, constant: 24),
            upperDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            upperDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            upperDivider.heightAnchor.constraint(equalToConstant: 1),
            
            subTotalLabel.topAnchor.constraint(equalTo: upperDivider.bottomAnchor, constant: 10),
            subTotalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subTotalLabel.widthAnchor.constraint(equalToConstant: subTotalLabel.width),
            subTotalLabel.heightAnchor.constraint(equalToConstant: subTotalLabel.height),
            
            subTotalPriceLabel.topAnchor.constraint(equalTo: subTotalLabel.topAnchor),
            subTotalPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subTotalPriceLabel.widthAnchor.constraint(equalToConstant: subTotalPriceLabel.width),
            subTotalPriceLabel.heightAnchor.constraint(equalToConstant: subTotalPriceLabel.height),
        ])
        
        let serviceFeeLabel = createLabelMedium14(for: "Service fee")
        let serviceFeePriceLabel = createLabelMedium14(for: Utils.getStringRpCurrencyFormatted(self.viewModel.serviceFee))
        
        scrollView.addSubview(serviceFeeLabel)
        scrollView.addSubview(serviceFeePriceLabel)
        
        serviceFeeLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceFeePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            serviceFeeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            serviceFeeLabel.widthAnchor.constraint(equalToConstant: serviceFeeLabel.width),
            serviceFeeLabel.heightAnchor.constraint(equalToConstant: serviceFeeLabel.height),
            
            serviceFeePriceLabel.topAnchor.constraint(equalTo: serviceFeeLabel.topAnchor),
            serviceFeePriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            serviceFeePriceLabel.widthAnchor.constraint(equalToConstant: serviceFeePriceLabel.width),
            serviceFeePriceLabel.heightAnchor.constraint(equalToConstant: serviceFeePriceLabel.height),
        ])
        
        if self.viewModel.boardingServices.count > 0 {
            let addOnServiceLabel = createLabelMedium14(for: "Add-on Service")
            let addOnServicePriceLabel = createLabelMedium14(for: Utils.getStringRpCurrencyFormatted(self.viewModel.totalAddOnPrice))
            
            scrollView.addSubview(addOnServiceLabel)
            scrollView.addSubview(addOnServicePriceLabel)
            
            addOnServiceLabel.translatesAutoresizingMaskIntoConstraints = false
            addOnServicePriceLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                addOnServiceLabel.topAnchor.constraint(equalTo: subTotalLabel.bottomAnchor, constant: 24),
                addOnServiceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                addOnServiceLabel.widthAnchor.constraint(equalToConstant: addOnServiceLabel.width),
                addOnServiceLabel.heightAnchor.constraint(equalToConstant: addOnServiceLabel.height),
                
                addOnServicePriceLabel.topAnchor.constraint(equalTo: addOnServiceLabel.topAnchor),
                addOnServicePriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                addOnServicePriceLabel.widthAnchor.constraint(equalToConstant: addOnServicePriceLabel.width),
                addOnServicePriceLabel.heightAnchor.constraint(equalToConstant: addOnServicePriceLabel.height),
            ])
            
            serviceFeeLabel.topAnchor.constraint(equalTo: addOnServiceLabel.bottomAnchor, constant: 24).isActive = true
        } else {
            serviceFeeLabel.topAnchor.constraint(equalTo: subTotalLabel.bottomAnchor, constant: 24).isActive = true
        }
        
        let lowerDivider = UIView()
        lowerDivider.backgroundColor = .grey3
        
        scrollView.addSubview(lowerDivider)
        lowerDivider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lowerDivider.topAnchor.constraint(equalTo: serviceFeeLabel.bottomAnchor, constant: 24),
            lowerDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lowerDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lowerDivider.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        let totalLabel = createLabelMedium14(for: "Total")
        let totalPriceLabel = createLabelMedium14(for: Utils.getStringRpCurrencyFormatted(self.viewModel.totalAllPrice))
        
        scrollView.addSubview(totalLabel)
        scrollView.addSubview(totalPriceLabel)
        
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: lowerDivider.bottomAnchor, constant: 24),
            totalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            totalLabel.widthAnchor.constraint(equalToConstant: totalLabel.width),
            totalLabel.heightAnchor.constraint(equalToConstant: totalLabel.height),
            
            totalPriceLabel.topAnchor.constraint(equalTo: totalLabel.topAnchor),
            totalPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            totalPriceLabel.widthAnchor.constraint(equalToConstant: totalPriceLabel.width),
            totalPriceLabel.heightAnchor.constraint(equalToConstant: totalPriceLabel.height),
        ])
        
        setupMainButton(lastView: totalLabel)
    }
    
    // MARK: MAIN BUTTON
    
    private func setupMainButton(lastView view: UIView) {
        let button = UIButton()
        button.backgroundColor = .customOrange
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(onClickMainButton), for: .touchUpInside)
        
        let label = UILabel()
        label.text = "Chat Pet Hotel"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.sizeToFit()
        
        scrollView.addSubview(button)
        button.addSubview(label)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 24),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 44),
            
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: label.height),
        ])
        
        self.bottomConstraintContentView = contentView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 40)
        bottomConstraintContentView.isActive = true
    }
    
    
    // MARK: NAVBAR
    
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        
        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    // MARK: @objc UIControl Functions
    
    @objc private func onClickHotelButton() {
        print("onClickHotelButton")
        
    }
    
    @objc private func onClickMainButton() {
        print("onClickMainButton")
        
    }
    
    @objc private func onPullToRefreshScrollView(sender: UIRefreshControl) {
        sender.beginRefreshing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            sender.endRefreshing()
        })
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: UTILITY FUNCTIONS FOR UILabel
    
    public func createLabelBold14(for string: String) -> UILabel {
        let label = UILabel()
        label.text = string
        label.textColor = .textBlack
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }
    
    public func createLabelMedium14(for string: String, isItalic: Bool = false) -> UILabel {
        let label = UILabel()
        label.text = string
        label.textColor = .textBlack
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = string.split(separator: "\n").count
        
        if isItalic {
            label.font = label.font.italic()
        }
        
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        
        return label
    }
}

extension OrderDetailsSheetViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navigationController?.navigationBar.transform = .init(
            translationX: 0,
            y: -56 + 24
        )
    }
}
