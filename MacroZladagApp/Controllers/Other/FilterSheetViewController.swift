//
//  FilterSheetViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 10/10/23.
//

import UIKit

class FilterSheetViewController: UIViewController {
    
//    var ururtkan
    
//    var upperController: MencobaSheetViewController?
    var searchResultsViewControllerDelegate: SearchResultsViewController?
    var cellDelegate: FilterCollectionViewCell?
    
    public var counterForSimpanButton: Int = 0 // cara "listen" perubahan ini gimana ya??
    public var checkIfUrutkanIsClicked: Bool = false // cara "listen" perubahan ini gimana ya??
    public var textFieldIsEdited: Bool = false // cara "listen" perubahan ini gimana ya??

//    public var urutkanValue = "Paling Sesuai"
//    public var urutkanValue = "Harga Terendah"
//    public var kategoriValue = "kategori"
//    public var fasilitasValue = "fasilitas"
//    public var kekhususanValue = "kekhususan"
    
//    public var arrayOfKategoriValues = [String]()
//    public var arrayOfFasilitasValues = [String]()
//    public var arrayOfKekhususanValues = [String]()
    
    // MARK: Sections
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let urutkanSection = FilterSectionLabel(sectionText: "Urutkan")
    let rentangHargaSection = FilterSectionLabel(sectionText: "Rentang Harga")
    let kategoriSection = FilterSectionLabel(sectionText: "Kategori")
    let fasilitasSection = FilterSectionLabel(sectionText: "Fasilitas")
    
    let divider1 = FilterSectionDivider(isSmall: false)
    let divider2 = FilterSectionDivider(isSmall: false)
    let divider3 = FilterSectionDivider(isSmall: false)
    let divider4 = FilterSectionDivider(isSmall: false)
    let dividerSmall = FilterSectionDivider(isSmall: true)
    
    // MARK: Urutkan
    
    var palingSesuaiButton = UrutkanFilterButton(text: "Paling Sesuai", isClicked: true)
    var hargaTertinggiButton = UrutkanFilterButton(text: "Harga Tertinggi", isClicked: false)
    var hargaTerendahButton = UrutkanFilterButton(text: "Harga Terendah", isClicked: false)
    var ratingTertinggiButton = UrutkanFilterButton(text: "Rating Tertinggi", isClicked: false)
    var lokasiTerdekatButton = UrutkanFilterButton(text: "Lokasi Terdekat", isClicked: false)
    
    // MARK: Price (!!!)
    public var minimumPriceTextField = MinimumPriceTextField()
    public var maximumPriceTextField = MaximumPriceTextField()
    
    // not to be used!
    public var minimumPrice: Int = 0
    public var maximumPrice: Int = 99999
    
    lazy var minimumPriceContainer: UITextField = {
        var textField = UITextField(frame: .zero)
//        textField.delegate = self
        textField.text = "Dekat saya"
        
        textField.backgroundColor = .red
        textField.textColor = .gray
        
        // Display frame.
//        textField.borderStyle = .
//        textField.layer.masksToBounds
        // Add clear button.
        textField.clearButtonMode = .whileEditing
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 22, weight: .bold)
        textField.keyboardType = .numberPad
//        textField.key
        
        return textField
    }()
    
    lazy var maximumPriceContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        
        let label = UILabel()
        label.text = "IDR \(maximumPrice)"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        
        container.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 150),
            label.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        container.layer.cornerRadius = 4
        container.layer.borderColor = UIColor.customGray2.cgColor
        container.layer.borderWidth = 1
        container.layer.masksToBounds = true
        
        return container
    }()
    
    // MARK: Kategori
    
    let kategoriPetHotelButton = KategoriButton(kategoriText: "Pet Hotel")
    let kategoriPetShopButton = KategoriButton(kategoriText: "Pet Shop")
    let kategoriRumahSakitHewanButton = KategoriButton(kategoriText: "Rumah Sakit Hewan")
    
    // MARK: Fasilitas
    
    // facilities
    let tempatBermainContainer = FasilitasContainerButton(textParam: "Tempat Bermain", facilityName: "Tempat Bermain", iconName: "tempat-bermain-icon")
    let ruanganBerACContainer = FasilitasContainerButton(textParam: "AC", facilityName: "Ruangan Ber-AC", iconName: "ruangan-ber-ac-icon")
    let cctvContainer = FasilitasContainerButton(textParam: "CCTV", facilityName: "CCTV", iconName: "cctv-icon")
    
    // services
    let termasukMakananContainer = FasilitasContainerButton(textParam: "Makan", facilityName: "Termasuk Makanan", iconName: "termasuk-makanan-icon")
    let tersediaAntarJemputContainer = FasilitasContainerButton(textParam: "Antar Jemput", facilityName: "Tersedia Antar Jemput", iconName: "tersedia-antar-jemput-icon")
    let tersediaGroomingContainer = FasilitasContainerButton(textParam: "Grooming", facilityName: "Tersedia Grooming", iconName: "tersedia-grooming-icon")
    let tersediaDokterHewanContainer = FasilitasContainerButton(textParam: "Dokter Hewan", facilityName: "Tersedia Dokter Hewan", iconName: "tersedia-dokter-hewan-icon")
    
    // MARK: Kekhususan
    
    let khususKucingSwitch = KekhususanSwitch(khususText: "Khusus Kucing")
    let khususAnjingSwitch = KekhususanSwitch(khususText: "Khusus Anjing")
    
    let simpanButtonView = SimpanButtonView()
    
    // MARK: SETUPS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        simpanButtonView.sheetDelegate = self
        
        setupNavBar()
        persistInputs()


        setupConstraints()
        
        // HAPUS KEMBALI UTK DI-APPEND LAGI WAKTU SAVE DATA
//        cellDelegate?.kategoriValues = []
//        cellDelegate?.fasilitasValues = []
//        cellDelegate?.kekhususanValues = []
        
                
        palingSesuaiButton.addTarget(self, action: #selector(clickPalingSesuaiButton), for: .touchUpInside)
        hargaTerendahButton.addTarget(self, action: #selector(clickHargaTerendahButton), for: .touchUpInside)
        hargaTertinggiButton.addTarget(self, action: #selector(clickHargaTertinggiButton), for: .touchUpInside)
        lokasiTerdekatButton.addTarget(self, action: #selector(clickLokasiTerdekatButton), for: .touchUpInside)
        ratingTertinggiButton.addTarget(self, action: #selector(clickRatingTertinggiButton), for: .touchUpInside)
        
        setupDelegates()

    }
    
    func setupNavBar() {
        let navView = UIView()
        navView.frame = CGRect(x: 0, y: 0, width: 365 - 24 + 13, height: 23)
        
        let navLabel = UILabel()
        navLabel.text = "Filter"
        navLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        navLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 23)
        navView.addSubview(navLabel)
        
        let closeButton = UIButton()
        let closeButtonImageView = UIImageView(image: UIImage(named: "sheet-close-button"))
        closeButtonImageView.contentMode = .scaleAspectFit
        closeButtonImageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        closeButton.addSubview(closeButtonImageView)
        closeButton.frame = CGRect(x: navView.frame.maxX - 32, y: 0, width: 32, height: 32)
        navView.addSubview(closeButton)
        
        closeButton.addTarget(self, action: #selector(closeSheet), for: .touchUpInside)
        navigationItem.titleView = navView
    }
    
    func setupDelegates() {
        palingSesuaiButton.delegate = self
        hargaTertinggiButton.delegate = self
        hargaTerendahButton.delegate = self
        ratingTertinggiButton.delegate = self
        lokasiTerdekatButton.delegate = self
        kategoriPetHotelButton.delegate = self
        kategoriPetShopButton.delegate = self
        kategoriRumahSakitHewanButton.delegate = self
        tempatBermainContainer.delegate = self
        ruanganBerACContainer.delegate = self
        cctvContainer.delegate = self
        termasukMakananContainer.delegate = self
        tersediaAntarJemputContainer.delegate = self
        tersediaGroomingContainer.delegate = self
        tersediaDokterHewanContainer.delegate = self
        khususKucingSwitch.delegate = self
        khususAnjingSwitch.delegate = self
        
        minimumPriceTextField.vcDelegate = self
        maximumPriceTextField.vcDelegate = self
    }
    
    func persistInputs() {
        guard let cellDelegate else { return }
        
        // URUTKAN
        let buttons = [palingSesuaiButton, hargaTertinggiButton, hargaTerendahButton, ratingTertinggiButton, lokasiTerdekatButton]
        
        var urutkanValue = cellDelegate.urutkanValue
        for button in buttons {
            if button.textParam == urutkanValue {
                print(button.textParam)
                button.isClicked = true
                button.backgroundColor = .orangeWithOpacity
                button.layer.borderColor = UIColor.customOrange.cgColor
            } else {
                button.isClicked = false
                button.backgroundColor = .clear
                button.layer.borderColor = UIColor.customGrayForIcons.cgColor
            }
        }
        
        self.checkIfUrutkanIsClicked = true
        
        // KATEGORI
        let kategoriButtons = [kategoriPetHotelButton, kategoriPetShopButton, kategoriRumahSakitHewanButton]
        
        for kategori in cellDelegate.kategoriValues {
            for button in kategoriButtons {
                if button.textParam == kategori {
                    button.isClicked = true
                    button.checkBox.subviews[0].layer.opacity = 1.0
                    button.checkBox.layer.borderColor = UIColor.customOrange.cgColor
                }
            }
        }
        
        // FASILITAS
        let fasilitasButtons = [tempatBermainContainer, ruanganBerACContainer, cctvContainer, termasukMakananContainer, tersediaAntarJemputContainer, tersediaGroomingContainer, tersediaDokterHewanContainer]
        
        for fasilitas in cellDelegate.fasilitasValues {
            for button in fasilitasButtons {
                if button.textParam == fasilitas {
                    button.isClicked = true
                    button.layer.cornerRadius = 8
                    button.layer.borderColor = UIColor.orange.cgColor
                    button.layer.borderWidth = 2
                    button.layer.masksToBounds = true
                    button.layer.backgroundColor = UIColor.orangeWithOpacity.cgColor
                }
            }
        }
        
        // KEKHUSUSAN
        for kekhususan in cellDelegate.kekhususanValues {
            if khususAnjingSwitch.paramText == kekhususan {
                khususAnjingSwitch.isClicked = true
                khususAnjingSwitch.uiSwitch.isOn = true
            } else if khususKucingSwitch.paramText == kekhususan {
                khususKucingSwitch.isClicked = true
                khususKucingSwitch.uiSwitch.isOn = true
            }
        }
        
        minimumPriceTextField.minimumPriceValue = cellDelegate.minimumPriceValue
        minimumPriceTextField.text = "IDR \(cellDelegate.minimumPriceValue)"
        maximumPriceTextField.maximumPriceValue = cellDelegate.maximumPriceValue
        maximumPriceTextField.text = "IDR \(cellDelegate.maximumPriceValue)"
        
        
    }
    
    // MARK: Simpan Button
    
    func presentOrHideSimpanButton() {
        // tunggu textfield!
        if !self.checkIfUrutkanIsClicked {
            if self.counterForSimpanButton > 0 {
                addSimpanButtonView()
            } else {
                if self.textFieldIsEdited {
                    addSimpanButtonView()
                } else {
                    simpanButtonView.removeFromSuperview()
                    
                }

            }
        } else {
            addSimpanButtonView()
        }
    }
    
    func addSimpanButtonView() {
        view.addSubview(simpanButtonView)

        simpanButtonView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            simpanButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            simpanButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            simpanButtonView.widthAnchor.constraint(equalToConstant: 390),
            simpanButtonView.heightAnchor.constraint(equalToConstant: 103),
        ])
    }

    // MARK: objc
    
    @objc func closeSheet() {
        dismiss(animated: true)
    }
    
    // MARK: objc for Urutkan Button
    
    @objc func clickPalingSesuaiButton() {
        let buttons = [hargaTertinggiButton, hargaTerendahButton, ratingTertinggiButton, lokasiTerdekatButton]
        
        palingSesuaiButton.isClicked = true
        palingSesuaiButton.backgroundColor = .orangeWithOpacity
        palingSesuaiButton.layer.borderColor = UIColor.customOrange.cgColor
        
        for button in buttons {
            if button.isClicked {
                button.isClicked = false
            }
            button.backgroundColor = .clear
            button.layer.borderColor = UIColor.customGrayForIcons.cgColor
        }
        
        self.checkIfUrutkanIsClicked = true
        self.presentOrHideSimpanButton()
        cellDelegate?.urutkanValue = palingSesuaiButton.label.text ?? "NO URUTKAN VALUE"
    }
    
    @objc func clickHargaTertinggiButton() {
        let buttons = [palingSesuaiButton, hargaTerendahButton, ratingTertinggiButton, lokasiTerdekatButton]
        
        hargaTertinggiButton.isClicked = true
        hargaTertinggiButton.backgroundColor = .orangeWithOpacity
        hargaTertinggiButton.layer.borderColor = UIColor.customOrange.cgColor
        
        for button in buttons {
            if button.isClicked {
                button.isClicked = false
            }

            button.backgroundColor = .clear
            button.layer.borderColor = UIColor.customGrayForIcons.cgColor
        }
        
        cellDelegate?.urutkanValue = hargaTertinggiButton.label.text ?? "NO URUTKAN VALUE"
        
        self.checkIfUrutkanIsClicked = true
        self.presentOrHideSimpanButton()
    }
    
    
    @objc func clickHargaTerendahButton() {
        let buttons = [palingSesuaiButton, hargaTertinggiButton, ratingTertinggiButton, lokasiTerdekatButton]
        
        hargaTerendahButton.isClicked = true
        hargaTerendahButton.backgroundColor = .orangeWithOpacity
        hargaTerendahButton.layer.borderColor = UIColor.customOrange.cgColor
        
        for button in buttons {
            if button.isClicked {
                button.isClicked = false
            }

            button.backgroundColor = .clear
            button.layer.borderColor = UIColor.customGrayForIcons.cgColor
        }
        
        cellDelegate?.urutkanValue = hargaTerendahButton.label.text ?? "NO URUTKAN VALUE"
        
        self.checkIfUrutkanIsClicked = true
        self.presentOrHideSimpanButton()
    }
    
    
    @objc func clickRatingTertinggiButton() {
        let buttons = [palingSesuaiButton, hargaTertinggiButton, hargaTerendahButton, lokasiTerdekatButton]

        ratingTertinggiButton.isClicked = true
        ratingTertinggiButton.backgroundColor = .orangeWithOpacity
        ratingTertinggiButton.layer.borderColor = UIColor.customOrange.cgColor
        
        for button in buttons {
            if button.isClicked {
                button.isClicked = false
            }
            button.backgroundColor = .clear
            button.layer.borderColor = UIColor.customGrayForIcons.cgColor
        }
        
        cellDelegate?.urutkanValue = ratingTertinggiButton.label.text ?? "NO URUTKAN VALUE"
        
        self.checkIfUrutkanIsClicked = true
        self.presentOrHideSimpanButton()
    }
    
    
    @objc func clickLokasiTerdekatButton() {
        let buttons = [palingSesuaiButton, hargaTertinggiButton, hargaTerendahButton, ratingTertinggiButton]
        
        lokasiTerdekatButton.isClicked = true
        lokasiTerdekatButton.backgroundColor = .orangeWithOpacity
        lokasiTerdekatButton.layer.borderColor = UIColor.customOrange.cgColor
        
        for button in buttons {
            if button.isClicked {
                button.isClicked = false
            }

            button.backgroundColor = .clear
            button.layer.borderColor = UIColor.customGrayForIcons.cgColor
        }
        
        cellDelegate?.urutkanValue = lokasiTerdekatButton.label.text ?? "NO URUTKAN VALUE"

        self.checkIfUrutkanIsClicked = true
        self.presentOrHideSimpanButton()
    }
    
    // MARK: Constraints
    
    func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.addSubview(urutkanSection) //
        scrollView.addSubview(palingSesuaiButton)
        scrollView.addSubview(hargaTertinggiButton)
        scrollView.addSubview(hargaTerendahButton)
        scrollView.addSubview(ratingTertinggiButton)
        scrollView.addSubview(lokasiTerdekatButton)
        
        scrollView.addSubview(divider1)
        
        scrollView.addSubview(rentangHargaSection) //
//        scrollView.addSubview(minimumPriceContainer)
        scrollView.addSubview(minimumPriceTextField)
        scrollView.addSubview(dividerSmall)
        scrollView.addSubview(maximumPriceTextField)
//        scrollView.addSubview(maximumPriceContainer)
        
        scrollView.addSubview(divider2)
        
        scrollView.addSubview(kategoriSection) //
        scrollView.addSubview(kategoriPetHotelButton) //
        scrollView.addSubview(kategoriPetShopButton) //
        scrollView.addSubview(kategoriRumahSakitHewanButton) //
        
        scrollView.addSubview(divider3)
        
        scrollView.addSubview(fasilitasSection) //
        scrollView.addSubview(tempatBermainContainer)
        scrollView.addSubview(ruanganBerACContainer)
        scrollView.addSubview(cctvContainer)
        scrollView.addSubview(termasukMakananContainer)
        scrollView.addSubview(tersediaAntarJemputContainer)
        scrollView.addSubview(tersediaGroomingContainer)
        scrollView.addSubview(tersediaDokterHewanContainer)
        
        scrollView.addSubview(divider4)
        
        scrollView.addSubview(khususKucingSwitch)
        scrollView.addSubview(khususAnjingSwitch)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        urutkanSection.translatesAutoresizingMaskIntoConstraints = false
        palingSesuaiButton.translatesAutoresizingMaskIntoConstraints = false
        hargaTertinggiButton.translatesAutoresizingMaskIntoConstraints = false
        hargaTerendahButton.translatesAutoresizingMaskIntoConstraints = false
        ratingTertinggiButton.translatesAutoresizingMaskIntoConstraints = false
        lokasiTerdekatButton.translatesAutoresizingMaskIntoConstraints = false
        
        divider1.translatesAutoresizingMaskIntoConstraints = false
        
        rentangHargaSection.translatesAutoresizingMaskIntoConstraints = false
//        minimumPriceContainer.translatesAutoresizingMaskIntoConstraints = false
        dividerSmall.translatesAutoresizingMaskIntoConstraints = false
//        maximumPriceContainer.translatesAutoresizingMaskIntoConstraints = false
        minimumPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        maximumPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        
        divider2.translatesAutoresizingMaskIntoConstraints = false
        
        kategoriSection.translatesAutoresizingMaskIntoConstraints = false
        kategoriPetHotelButton.translatesAutoresizingMaskIntoConstraints = false
        kategoriPetShopButton.translatesAutoresizingMaskIntoConstraints = false
        kategoriRumahSakitHewanButton.translatesAutoresizingMaskIntoConstraints = false
        
        divider3.translatesAutoresizingMaskIntoConstraints = false
        
        fasilitasSection.translatesAutoresizingMaskIntoConstraints = false
        tempatBermainContainer.translatesAutoresizingMaskIntoConstraints = false
        ruanganBerACContainer.translatesAutoresizingMaskIntoConstraints = false
        cctvContainer.translatesAutoresizingMaskIntoConstraints = false
        termasukMakananContainer.translatesAutoresizingMaskIntoConstraints = false
        tersediaAntarJemputContainer.translatesAutoresizingMaskIntoConstraints = false
        tersediaGroomingContainer.translatesAutoresizingMaskIntoConstraints = false
        tersediaDokterHewanContainer.translatesAutoresizingMaskIntoConstraints = false
        
        divider4.translatesAutoresizingMaskIntoConstraints = false
        
        khususKucingSwitch.translatesAutoresizingMaskIntoConstraints = false
        khususAnjingSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1150),
            
            urutkanSection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            urutkanSection.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            urutkanSection.widthAnchor.constraint(equalToConstant: 120),
            urutkanSection.heightAnchor.constraint(equalToConstant: 25),
            
            palingSesuaiButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            palingSesuaiButton.topAnchor.constraint(equalTo: urutkanSection.bottomAnchor, constant: 16),
            palingSesuaiButton.widthAnchor.constraint(equalToConstant: 167),
            palingSesuaiButton.heightAnchor.constraint(equalToConstant: 33),

            lokasiTerdekatButton.leadingAnchor.constraint(equalTo: palingSesuaiButton.trailingAnchor, constant: 8),
            lokasiTerdekatButton.topAnchor.constraint(equalTo: urutkanSection.bottomAnchor, constant: 16),
            lokasiTerdekatButton.widthAnchor.constraint(equalToConstant: 167),
            lokasiTerdekatButton.heightAnchor.constraint(equalToConstant: 33),

            hargaTertinggiButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            hargaTertinggiButton.topAnchor.constraint(equalTo: palingSesuaiButton.bottomAnchor, constant: 8),
            hargaTertinggiButton.widthAnchor.constraint(equalToConstant: 167),
            hargaTertinggiButton.heightAnchor.constraint(equalToConstant: 33),

            hargaTerendahButton.leadingAnchor.constraint(equalTo: hargaTertinggiButton.trailingAnchor, constant: 8),
            hargaTerendahButton.topAnchor.constraint(equalTo: lokasiTerdekatButton.bottomAnchor, constant: 8),
            hargaTerendahButton.widthAnchor.constraint(equalToConstant: 167),
            hargaTerendahButton.heightAnchor.constraint(equalToConstant: 33),

            ratingTertinggiButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            ratingTertinggiButton.topAnchor.constraint(equalTo: hargaTertinggiButton.bottomAnchor, constant: 8),
            ratingTertinggiButton.widthAnchor.constraint(equalToConstant: 167),
            ratingTertinggiButton.heightAnchor.constraint(equalToConstant: 33),

            divider1.topAnchor.constraint(equalTo: ratingTertinggiButton.bottomAnchor, constant: 24),
            divider1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            rentangHargaSection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            rentangHargaSection.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 24),
            rentangHargaSection.widthAnchor.constraint(equalToConstant: 120),
            rentangHargaSection.heightAnchor.constraint(equalToConstant: 25),

            minimumPriceTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            minimumPriceTextField.topAnchor.constraint(equalTo: rentangHargaSection.bottomAnchor, constant: 16),
            minimumPriceTextField.widthAnchor.constraint(equalToConstant: 163),
            minimumPriceTextField.heightAnchor.constraint(equalToConstant: 45),

            dividerSmall.leadingAnchor.constraint(equalTo: minimumPriceTextField.trailingAnchor),
            dividerSmall.topAnchor.constraint(equalTo: minimumPriceTextField.topAnchor, constant: 22),

            maximumPriceTextField.leadingAnchor.constraint(equalTo: minimumPriceTextField.trailingAnchor, constant: 16),
            maximumPriceTextField.topAnchor.constraint(equalTo: rentangHargaSection.bottomAnchor, constant: 16),
            maximumPriceTextField.widthAnchor.constraint(equalToConstant: 163),
            maximumPriceTextField.heightAnchor.constraint(equalToConstant: 45),

            divider2.topAnchor.constraint(equalTo: maximumPriceTextField.bottomAnchor, constant: 24),
            divider2.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            kategoriSection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            kategoriSection.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 24),
            kategoriSection.widthAnchor.constraint(equalToConstant: 120),
            kategoriSection.heightAnchor.constraint(equalToConstant: 25),

            kategoriPetHotelButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            kategoriPetHotelButton.topAnchor.constraint(equalTo: kategoriSection.bottomAnchor, constant: 16),
            kategoriPetHotelButton.widthAnchor.constraint(equalToConstant: 342),
            kategoriPetHotelButton.heightAnchor.constraint(equalToConstant: 25),

            kategoriPetShopButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            kategoriPetShopButton.topAnchor.constraint(equalTo: kategoriPetHotelButton.bottomAnchor, constant: 16),
            kategoriPetShopButton.widthAnchor.constraint(equalToConstant: 342),
            kategoriPetShopButton.heightAnchor.constraint(equalToConstant: 25),

            kategoriRumahSakitHewanButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            kategoriRumahSakitHewanButton.topAnchor.constraint(equalTo: kategoriPetShopButton.bottomAnchor, constant: 16),
            kategoriRumahSakitHewanButton.widthAnchor.constraint(equalToConstant: 342),
            kategoriRumahSakitHewanButton.heightAnchor.constraint(equalToConstant: 25),

            divider3.topAnchor.constraint(equalTo: kategoriRumahSakitHewanButton.bottomAnchor, constant: 24),
            divider3.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            // =================
            fasilitasSection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            fasilitasSection.topAnchor.constraint(equalTo: divider3.bottomAnchor, constant: 24),
            fasilitasSection.widthAnchor.constraint(equalToConstant: 120),
            fasilitasSection.heightAnchor.constraint(equalToConstant: 25),

            ruanganBerACContainer.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            ruanganBerACContainer.topAnchor.constraint(equalTo: fasilitasSection.bottomAnchor, constant: 16),
            ruanganBerACContainer.widthAnchor.constraint(equalToConstant: 108),
            ruanganBerACContainer.heightAnchor.constraint(equalToConstant: 109),

            tersediaAntarJemputContainer.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tersediaAntarJemputContainer.topAnchor.constraint(equalTo: ruanganBerACContainer.bottomAnchor, constant: 8),
            tersediaAntarJemputContainer.widthAnchor.constraint(equalToConstant: 108),
            tersediaAntarJemputContainer.heightAnchor.constraint(equalToConstant: 109),

            tempatBermainContainer.trailingAnchor.constraint(equalTo: ruanganBerACContainer.leadingAnchor, constant: -9),
            tempatBermainContainer.topAnchor.constraint(equalTo: ruanganBerACContainer.topAnchor),
            tempatBermainContainer.widthAnchor.constraint(equalToConstant: 108),
            tempatBermainContainer.heightAnchor.constraint(equalToConstant: 109),

            termasukMakananContainer.trailingAnchor.constraint(equalTo: tersediaAntarJemputContainer.leadingAnchor, constant: -9),
            termasukMakananContainer.topAnchor.constraint(equalTo: tersediaAntarJemputContainer.topAnchor),
            termasukMakananContainer.widthAnchor.constraint(equalToConstant: 108),
            termasukMakananContainer.heightAnchor.constraint(equalToConstant: 109),

            cctvContainer.leadingAnchor.constraint(equalTo: ruanganBerACContainer.trailingAnchor, constant: 9),
            cctvContainer.topAnchor.constraint(equalTo: ruanganBerACContainer.topAnchor),
            cctvContainer.widthAnchor.constraint(equalToConstant: 108),
            cctvContainer.heightAnchor.constraint(equalToConstant: 109),

            tersediaGroomingContainer.leadingAnchor.constraint(equalTo: tersediaAntarJemputContainer.trailingAnchor, constant: 9),
            tersediaGroomingContainer.topAnchor.constraint(equalTo: tersediaAntarJemputContainer.topAnchor),
            tersediaGroomingContainer.widthAnchor.constraint(equalToConstant: 108),
            tersediaGroomingContainer.heightAnchor.constraint(equalToConstant: 109),

            tersediaDokterHewanContainer.leadingAnchor.constraint(equalTo: termasukMakananContainer.leadingAnchor),
            tersediaDokterHewanContainer.topAnchor.constraint(equalTo: termasukMakananContainer.bottomAnchor, constant: 8),
            tersediaDokterHewanContainer.widthAnchor.constraint(equalToConstant: 108),
            tersediaDokterHewanContainer.heightAnchor.constraint(equalToConstant: 109),
            
            divider4.topAnchor.constraint(equalTo: tersediaDokterHewanContainer.bottomAnchor, constant: 12),
            divider4.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
  
            khususKucingSwitch.topAnchor.constraint(equalTo: divider4.bottomAnchor, constant: 24),
            khususKucingSwitch.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            khususKucingSwitch.widthAnchor.constraint(equalToConstant: 342),
            khususKucingSwitch.heightAnchor.constraint(equalToConstant: 31),
            
            khususAnjingSwitch.topAnchor.constraint(equalTo: khususKucingSwitch.bottomAnchor, constant: 24),
            khususAnjingSwitch.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            khususAnjingSwitch.widthAnchor.constraint(equalToConstant: 342),
            khususAnjingSwitch.heightAnchor.constraint(equalToConstant: 31),

        ])
    }
}


class MinimumPriceTextField: UITextField {
    public var minimumPriceValue: Int = 0
    var vcDelegate: FilterSheetViewController?
    
    init() {
        super.init(frame: .zero)
        
        text = "IDR \(self.minimumPriceValue.description)"
        delegate = self
        
        backgroundColor = .white
        textColor = .black
        layer.borderColor = UIColor.customGrayForBorder.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.cornerRadius = 4
        
        textAlignment = .center
        font = .systemFont(ofSize: 14, weight: .semibold)
        
        keyboardType = .numberPad
        returnKeyType = .done
        
        addDoneButtonOnKeyboard()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
        
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}

class MaximumPriceTextField: UITextField {
    public var maximumPriceValue: Int = 9999999
    var vcDelegate: FilterSheetViewController?
    
    init() {
        super.init(frame: .zero)
        
        text = "IDR \(self.maximumPriceValue.description)"
        delegate = self
        
        backgroundColor = .white
        textColor = .black
        layer.borderColor = UIColor.customGrayForBorder.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.cornerRadius = 4
        
        textAlignment = .center
        font = .systemFont(ofSize: 14, weight: .semibold)
        
        keyboardType = .numberPad
        returnKeyType = .done
        
        addDoneButtonOnKeyboard()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
        
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}

extension MinimumPriceTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return false }
        
        if !text.hasPrefix("IDR ") {
            textField.text = "IDR "
        } else {
            let split = text.split(separator: "IDR ")
            if split.count == 1 {
                let value = String(split[0])
                if Int(value) == nil {
                    textField.text = "IDR "
                }
                
                if string.isEmpty {
                    if textField.text == "IDR 0" {
                        textField.text = "IDR 0 "
                    } else if textField.text?.count == 5 {
                        textField.text = "IDR 0 "
                    }
                } else {
                    if textField.text == "IDR 0" {
                        textField.text = "IDR "
                    }
                }
            } else {
                textField.text = "IDR 0 "
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let value = String(text.split(separator: " ")[1])
        if let intValue = Int(value) {
            self.minimumPriceValue = intValue
        }
        
        vcDelegate?.cellDelegate?.minimumPriceValue = self.minimumPriceValue
        guard let delegate = vcDelegate?.cellDelegate else { return }
//        if delegate.minimumPriceValue > delegate.maximumPriceValue {
//            let temp = delegate.minimumPriceValue
//            delegate.minimumPriceValue = delegate.maximumPriceValue
//            delegate.maximumPriceValue = temp
//            textField.text = delegate.minimumPriceValue.description
//        }
        self.vcDelegate?.textFieldIsEdited = true
        self.vcDelegate?.presentOrHideSimpanButton()
    }
}

extension MaximumPriceTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return false }
        
        if !text.hasPrefix("IDR ") {
            textField.text = "IDR "
        } else {
            let split = text.split(separator: "IDR ")
            if split.count == 1 {
                let value = String(split[0])
                if Int(value) == nil {
                    textField.text = "IDR "
                }
                
                if string.isEmpty {
                    if textField.text == "IDR 0" {
                        textField.text = "IDR 0 "
                    } else if textField.text?.count == 5 {
                        textField.text = "IDR 0 "
                    }
                } else {
                    if textField.text == "IDR 0" {
                        textField.text = "IDR "
                    }
                }
            } else {
                textField.text = "IDR 0 "
            }
        }
        
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let value = String(text.split(separator: " ")[1])
        if let intValue = Int(value) {
            self.maximumPriceValue = intValue
        }
        vcDelegate?.cellDelegate?.maximumPriceValue = self.maximumPriceValue
        
        guard let delegate = vcDelegate?.cellDelegate else { return }
//        if delegate.minimumPriceValue > delegate.maximumPriceValue {
//            let temp = delegate.minimumPriceValue
//            delegate.minimumPriceValue = delegate.maximumPriceValue
//            delegate.maximumPriceValue = temp
//            textField.text = delegate.maximumPriceValue.description
//        }
        self.vcDelegate?.textFieldIsEdited = true
        self.vcDelegate?.presentOrHideSimpanButton()
    }
}

