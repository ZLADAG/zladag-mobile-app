//
//  TambahProfilAnabulViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 26/10/23.
//

import UIKit

enum RequiredFields: String {
    case namaAnabulIsEmpty = "Nama anabul kosong"
    case speciesIsNotSelected = "Spesies belum dipilih"
    case petBreedIsNotSelected = "Ras belum dipilih"
    case genderIsNotSelected = "Jenis kelamin belum dipilih"
    case beratIsEmpty = "Berat kosong"
    case usiaIsEmpty = "Usia kosong"
}

class TambahProfilAnabulViewController: UIViewController {
    
    var viewModel = PetCreationViewModel()
    var requiredFieldsAlert = [RequiredFields]()
    
    // MARK: BREEDS & HABITS DATA
    var petHabits = [PetHabitCheckBox]()
    var petBreeds = [PetBreedRadioButton]()
    
    // MARK: VIEWS COMPONENTS
    let scrollView = UIScrollView()
    let contentView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        return view
    }()
    var contentViewBottomAnchor = NSLayoutConstraint()
    
    let profileImageViewButton = ProfileImageViewButton()
    let locationIconView = IconView(iconName: "location-icon-white")
    var profileImageViewButtonTopAnchor = NSLayoutConstraint()
    
    let informasiPetSectionLabel = SectionLabel(for: "Informasi Pet")
    let preferensiPetSectionLabel = SectionLabel(for: "Preferensi Pet")
    let kebiasaanPetSectionLabel = SectionLabel(for: "Kebiasaan Pet")
    let riwayatPenyakitSectionLabel = SectionLabel(for: "Riwayat Penyakit")
    
    let fasilitasLabel: UILabel = {
        let label = UILabel()
        label.text = "Fasilitas"
        label.textColor = .textBlack
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.sizeToFit()
        return label
    }()

    
    // MARK: Necessary* Field Labels
    let namaLabel = NecessarryFieldLabel(textValue: "Nama")
    let spesiesLabel = NecessarryFieldLabel(textValue: "Spesies")
    let rasLabel = NecessarryFieldLabel(textValue: "Ras")
    let jenisKelaminLabel = NecessarryFieldLabel(textValue: "Jenis Kelamin")
    let beratLabel = NecessarryFieldLabel(textValue: "Berat")
    let usiaLabel = NecessarryFieldLabel(textValue: "Usia")
    
    // MARK: INPUTS
    let namaAnabulTextField = NamaAnabulTextView()
    
    let anjingSpesiesButton = SpesiesButton(for: "anjing")
    let kucingSpesiesButton = SpesiesButton(for: "kucing")

    let betinaJenisKelaminButton = JenisKelaminButton(for: "betina")
    let jantanJenisKelaminButton = JenisKelaminButton(for: "jantan")
    
    let beratTextView = BeratUsiaTextView(for: "berat")
    let usiaTextView = BeratUsiaTextView(for: "usia")
    
    // TODO: berat & usia TextView di set keyboard numpad, dan decimal formatting, dan keyboard frame?
    
    // TODO: TANYA KENAPA VIEW DI BUTTON GABISA DICLICK
    let sudahSterilCheckboxButton = RequirementCheckboxButton(name: "Sudah steril", apiParam: "hasBeenSterilized")
    let rutinMenggunakanObatKutuCheckboxButton = RequirementCheckboxButton(name: "Rutin menggunakan obat kutu", apiParam: "hasBeenFleaFreeRegularly")
    let rutinVaksinasiCheckboxButton = RequirementCheckboxButton(name: "Rutin vaksinasi", apiParam: "hasBeenVaccinatedRoutinely")
    
    let tempatBermainFasilitasButton = FasilitasButton(for: "Tempat Bermain", apiParam: "playground")
    let ruanganBerACFasilitasButton = FasilitasButton(for: "Ruangan Ber-AC", apiParam: "ac")
    let cctvFasilitasButton = FasilitasButton(for: "CCTV", apiParam: "cctv")
    let termasukMakananFasilitasButton = FasilitasButton(for: "Termasuk Makanan", apiParam: "food")
    let tersediaAntarJemputFasilitasButton = FasilitasButton(for: "Tersedia Antar Jemput", apiParam: "delivery")
    let tersediaGroomingFasilitasButton = FasilitasButton(for: "Tersedia Grooming", apiParam: "grooming")
    let tersediaDokterHewanFasilitasButton = FasilitasButton(for: "Tersedia Dokter Hewan", apiParam: "veterinary")
    
     // MARK: RAS DROP DOWN COMPONENTS
     let rasDropDownButton = UIButton()
     let rasChevronImageView = UIImageView()
     var rasDropDownButtonIsClicked: Bool = false
     var rasDropDownTableView = UITableView()
     var rasTableViewHeightAnchor = NSLayoutConstraint()
    
    // MARK: KEBIASAAN DROP DOWN COMPONENTS
    let kebiasaanDropDownButton = UIButton()
    let chevronImageView = UIImageView()
    var kebiasaanDropDownButtonIsClicked: Bool = false
    var kebiasaanDropDownTableView = UITableView()
    var kebiasaanTableViewHeightAnchor = NSLayoutConstraint()
    
    // MARK: RIWAYAT PENYAKIT
    let riwayatPenyakitTextView = UITextView()
    var riwayatPenyakitTextViewHeightAnchor = NSLayoutConstraint()
    
    let riwayatPenyakitContainerView = UIView()
    var riwayatPenyakitContainerViewHeightAnchor = NSLayoutConstraint()
    
    let simpanButton = UIButton()
    
    // MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tambah Profil Anabul"
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupScrollView()
        setupContentView()
        
        // MARK: PROFILE IMAGE
        setupProfileImageViewButton()
        profileImageViewButton.addTarget(self, action: #selector(onClickProfileImageButton), for: .touchUpInside)
        setupLocationIconView()
        
        setupInformasiPetSectionLabel()
        
        // MARK: NAMA
        setupNamaLabel()
        setupNamaAnabulTextField()
        
        // MARK: SPESIES
        setupSpesiesLabel()
        setupAnjingSpesiesButton()
        setupKucingSpesiesButton()
        anjingSpesiesButton.addTarget(self, action: #selector(onClickAnjingSpesiesButton), for: .touchUpInside)
        kucingSpesiesButton.addTarget(self, action: #selector(onClickKucingSpesiesButton), for: .touchUpInside)
        
        // MARK: >> RAS DROP DOWN
        setupRasLabel()
        setupRasDropDownButton()
        rasDropDownButton.addTarget(self, action: #selector(onClickRasDropDownButton), for: .touchUpInside)
        setupRasDropDownTableView()
        
        // MARK: JENIS KELAMIN
        setupJenisKelaminLabel()
        setupBetinaJenisKelaminButton()
        setupJantanJenisKelaminButton()
        betinaJenisKelaminButton.addTarget(self, action: #selector(onClickBetinaJenisKelaminButton), for: .touchUpInside)
        jantanJenisKelaminButton.addTarget(self, action: #selector(onClickJantanJenisKelaminButton), for: .touchUpInside)

        
        // MARK: BERAT & USIA
        setupBeratLabel()
        setupUsiaLabel()
        setupBeratTextView()
        setupUsiaTextView()
        
        // MARK: REQUIREMENT CHECKBOX
        setupSudahSterilCheckboxButton()
        setupRutinMenggunakanObatKutuCheckboxButton()
        setupRutinVaksinasiCheckboxButton()
        
        // MARK: FASILITAS BUTTONS
        setupPreferensiPetSectionLabel()
        setupFasilitasLabel()
        setupFasilitasButtons()
        
        // MARK: >> KEBIASAAN DROP DOWN
        setupKebiasaanPetSectionLabel()
        setupKebiasaanDropDownButton()
        kebiasaanDropDownButton.addTarget(self, action: #selector(onClickKebiasaanDropDownButton), for: .touchUpInside)
        setupKebiasaanDropDownTableView()
        
        // MARK: RIWAYAT PENYAKIT TEXT VIEW
        setupRiwayatPenyakitSectionLabel()
        setupRiwayatPenyakitTextView()

        // MARK: SIMPAN BUTTON
        setupSimpanButton()
        simpanButton.addTarget(self, action: #selector(onClickSimpanButton), for: .touchUpInside)
    }
    
    // MARK: UI Setups
    
    func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupContentView() {
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        contentView.widthAnchor.constraint(equalToConstant: view.width - (24 * 2)).isActive = true

        // ACTIVATE BOTTOM ANCHOR TERAKHIR
        // contentViewBottomAnchor
    }
    
    func setupProfileImageViewButton() {
        scrollView.addSubview(profileImageViewButton)
        
        profileImageViewButton.layer.cornerRadius = profileImageViewButton.width / 2
        profileImageViewButton.layer.masksToBounds = true
        
        profileImageViewButton.translatesAutoresizingMaskIntoConstraints = false
        self.profileImageViewButtonTopAnchor = profileImageViewButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        profileImageViewButtonTopAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            profileImageViewButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageViewButton.widthAnchor.constraint(equalToConstant: 96),
            profileImageViewButton.heightAnchor.constraint(equalToConstant: 96),
        ])
    }
    
    func setupLocationIconView() {
        scrollView.addSubview(locationIconView)
        
        locationIconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationIconView.trailingAnchor.constraint(equalTo: profileImageViewButton.trailingAnchor),
            locationIconView.bottomAnchor.constraint(equalTo: profileImageViewButton.bottomAnchor),
            locationIconView.widthAnchor.constraint(equalToConstant: locationIconView.width),
            locationIconView.heightAnchor.constraint(equalToConstant: locationIconView.height),
        ])
    }
    
    func setupInformasiPetSectionLabel() {
        scrollView.addSubview(informasiPetSectionLabel)
        informasiPetSectionLabel.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            informasiPetSectionLabel.topAnchor.constraint(equalTo: profileImageViewButton.bottomAnchor, constant: 32),
            informasiPetSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            informasiPetSectionLabel.widthAnchor.constraint(equalToConstant: informasiPetSectionLabel.width),
            informasiPetSectionLabel.heightAnchor.constraint(equalToConstant: informasiPetSectionLabel.height),
        ])
            
    }
    
    func setupNamaLabel() {
        scrollView.addSubview(namaLabel)
        
        namaLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            namaLabel.topAnchor.constraint(equalTo: informasiPetSectionLabel.bottomAnchor, constant: 24),
            namaLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            namaLabel.widthAnchor.constraint(equalToConstant: namaLabel.width),
            namaLabel.heightAnchor.constraint(equalToConstant: namaLabel.height),
        ])
                    
    }
    
    func setupNamaAnabulTextField() {
        scrollView.addSubview(namaAnabulTextField)
        namaAnabulTextField.tambahProfilAnabulViewController = self
        
        namaAnabulTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            namaAnabulTextField.topAnchor.constraint(equalTo: namaLabel.bottomAnchor, constant: 8),
            namaAnabulTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            namaAnabulTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            namaAnabulTextField.heightAnchor.constraint(equalToConstant: 49),
        ])
    }
    
    func setupSpesiesLabel() {
        scrollView.addSubview(spesiesLabel)
        
        spesiesLabel.translatesAutoresizingMaskIntoConstraints = false
           
        NSLayoutConstraint.activate([
            spesiesLabel.topAnchor.constraint(equalTo: namaAnabulTextField.bottomAnchor, constant: 24),
            spesiesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spesiesLabel.widthAnchor.constraint(equalToConstant: spesiesLabel.width),
            spesiesLabel.heightAnchor.constraint(equalToConstant: spesiesLabel.height),
        ])
    }
    
    func setupAnjingSpesiesButton() {
        scrollView.addSubview(anjingSpesiesButton)
        anjingSpesiesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            anjingSpesiesButton.topAnchor.constraint(equalTo: spesiesLabel.bottomAnchor, constant: 8),
            anjingSpesiesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            anjingSpesiesButton.widthAnchor.constraint(equalToConstant: anjingSpesiesButton.width),
            anjingSpesiesButton.heightAnchor.constraint(equalToConstant: anjingSpesiesButton.height),
        ])
    }
    
    func setupKucingSpesiesButton() {
        scrollView.addSubview(kucingSpesiesButton)

        kucingSpesiesButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            kucingSpesiesButton.topAnchor.constraint(equalTo: spesiesLabel.bottomAnchor, constant: 8),
            kucingSpesiesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            kucingSpesiesButton.widthAnchor.constraint(equalToConstant: kucingSpesiesButton.width),
            kucingSpesiesButton.heightAnchor.constraint(equalToConstant: kucingSpesiesButton.height),
        ])
    }
    
    func setupRasLabel() {
        scrollView.addSubview(rasLabel)
        
        rasLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rasLabel.topAnchor.constraint(equalTo: anjingSpesiesButton.bottomAnchor, constant: 24),
            rasLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rasLabel.widthAnchor.constraint(equalToConstant: rasLabel.width),
            rasLabel.heightAnchor.constraint(equalToConstant: rasLabel.height),
        ])
    }
    
//    func setupRasDropDownButton(for species: String) {
    func setupRasDropDownButton() {
        scrollView.addSubview(rasDropDownButton)
        
        // SETUP LABEL
        let label = UILabel()
        label.text = "Pilih ras anabul kamu"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .customGrayForCheckboxBorder
        label.sizeToFit()
        
        rasDropDownButton.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: rasDropDownButton.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: rasDropDownButton.leadingAnchor, constant: 16),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: label.height),
        ])
        
        // SETUP CHEVRON ICON
        rasChevronImageView.image = UIImage(systemName: "chevron.down")
        rasChevronImageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 14, weight: .semibold))
        
        rasChevronImageView.tintColor = .customGrayForCheckboxBorder
        rasChevronImageView.contentMode = .scaleAspectFit
        rasChevronImageView.frame.size  = CGSize(width: 24, height: 24)
        
        rasDropDownButton.addSubview(rasChevronImageView)
        rasChevronImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rasChevronImageView.centerYAnchor.constraint(equalTo: rasDropDownButton.centerYAnchor),
            rasChevronImageView.trailingAnchor.constraint(equalTo: rasDropDownButton.trailingAnchor, constant: -16),
            rasChevronImageView.widthAnchor.constraint(equalToConstant: rasChevronImageView.width),
            rasChevronImageView.heightAnchor.constraint(equalToConstant: rasChevronImageView.height),
        ])
        
        
        // DROPDOWN BUTTON STYLING
        
        rasDropDownButton.backgroundColor = .customGrayForInputFields
        rasDropDownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        rasDropDownButton.layer.cornerRadius = 8
        rasDropDownButton.layer.masksToBounds = true
        
        rasDropDownButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            kebiasaanDropDownButton.topAnchor.constraint(equalTo: kebiasaanPetSectionLabel.bottomAnchor, constant: 58),
            rasDropDownButton.topAnchor.constraint(equalTo: rasLabel.bottomAnchor, constant: 8),
            rasDropDownButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            rasDropDownButton.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            rasDropDownButton.heightAnchor.constraint(equalToConstant: 44 + 10), // 10 adalah bottom lebih
        ])
    }
    
    func setupRasDropDownTableView() {
        scrollView.addSubview(rasDropDownTableView)
        
        rasDropDownTableView.delegate = self
        rasDropDownTableView.dataSource = self
        rasDropDownTableView.register(RasDropDownTableViewCell.self, forCellReuseIdentifier: RasDropDownTableViewCell.identifier)
        
        rasDropDownTableView.backgroundColor = .customGrayForInputFields // ga ngaruh, krn fit
        rasDropDownTableView.separatorStyle = .none
        rasDropDownTableView.isScrollEnabled = false
        rasDropDownTableView.isHidden = true
        rasDropDownTableView.sizeToFit()
        
        rasDropDownTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rasDropDownTableView.topAnchor.constraint(equalTo: rasDropDownButton.bottomAnchor),
            rasDropDownTableView.centerXAnchor.constraint(equalTo: rasDropDownButton.centerXAnchor),
            rasDropDownTableView.widthAnchor.constraint(equalTo: rasDropDownButton.widthAnchor),
        ])
        
        self.rasTableViewHeightAnchor = rasDropDownTableView.heightAnchor.constraint(equalToConstant: 0)
        rasTableViewHeightAnchor.isActive = true
    }
    
    func setupJenisKelaminLabel() {
        scrollView.addSubview(jenisKelaminLabel)

        jenisKelaminLabel.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            jenisKelaminLabel.topAnchor.constraint(equalTo: rasDropDownTableView.bottomAnchor, constant: 24),
            jenisKelaminLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            jenisKelaminLabel.widthAnchor.constraint(equalToConstant: jenisKelaminLabel.width),
            jenisKelaminLabel.heightAnchor.constraint(equalToConstant: jenisKelaminLabel.height),
        ])

    }
    
    func setupBetinaJenisKelaminButton() {
        scrollView.addSubview(betinaJenisKelaminButton)
        
        betinaJenisKelaminButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            betinaJenisKelaminButton.topAnchor.constraint(equalTo: jenisKelaminLabel.bottomAnchor, constant: 8),
            betinaJenisKelaminButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            betinaJenisKelaminButton.widthAnchor.constraint(equalToConstant: betinaJenisKelaminButton.width),
            betinaJenisKelaminButton.heightAnchor.constraint(equalToConstant: betinaJenisKelaminButton.height),
        ])
    }
    
    func setupJantanJenisKelaminButton() {
        scrollView.addSubview(jantanJenisKelaminButton)

        jantanJenisKelaminButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            jantanJenisKelaminButton.topAnchor.constraint(equalTo: jenisKelaminLabel.bottomAnchor, constant: 8),
            jantanJenisKelaminButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            jantanJenisKelaminButton.widthAnchor.constraint(equalToConstant: jantanJenisKelaminButton.width),
            jantanJenisKelaminButton.heightAnchor.constraint(equalToConstant: jantanJenisKelaminButton.height),
        ])
    }
    
    func setupBeratLabel() {
        scrollView.addSubview(beratLabel)

        beratLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            beratLabel.topAnchor.constraint(equalTo: betinaJenisKelaminButton.bottomAnchor, constant: 24),
            beratLabel.leadingAnchor.constraint(equalTo: betinaJenisKelaminButton.leadingAnchor),
            beratLabel.widthAnchor.constraint(equalToConstant: beratLabel.width),
            beratLabel.heightAnchor.constraint(equalToConstant: beratLabel.height),
        ])
    }
    
    func setupUsiaLabel() {
        scrollView.addSubview(usiaLabel)

        usiaLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usiaLabel.topAnchor.constraint(equalTo: jantanJenisKelaminButton.bottomAnchor, constant: 24),
            usiaLabel.leadingAnchor.constraint(equalTo: jantanJenisKelaminButton.leadingAnchor),
            usiaLabel.widthAnchor.constraint(equalToConstant: usiaLabel.width),
            usiaLabel.heightAnchor.constraint(equalToConstant: usiaLabel.height),
        ])
    }
    
    @objc func doneButtonActionUsia() {
        self.usiaTextView.textField.resignFirstResponder()
    }
    
    @objc func doneButtonActionBerat() {
        self.beratTextView.textField.resignFirstResponder()
    }
    
    func setupBeratTextView() {
        scrollView.addSubview(beratTextView)
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.backgroundColor = .white
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonActionBerat))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        beratTextView.textField.inputAccessoryView = doneToolbar
        
        beratTextView.tambahProfilAnabulViewController = self

        beratTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            beratTextView.topAnchor.constraint(equalTo: beratLabel.bottomAnchor, constant: 8),
            beratTextView.leadingAnchor.constraint(equalTo: beratLabel.leadingAnchor),
            beratTextView.widthAnchor.constraint(equalToConstant: beratTextView.width),
            beratTextView.heightAnchor.constraint(equalToConstant: beratTextView.height),
        ])
    }
    
    func setupUsiaTextView() {
        scrollView.addSubview(usiaTextView)
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.backgroundColor = .white
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonActionUsia))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        usiaTextView.textField.inputAccessoryView = doneToolbar
        
        usiaTextView.tambahProfilAnabulViewController = self

        usiaTextView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usiaTextView.topAnchor.constraint(equalTo: usiaLabel.bottomAnchor, constant: 8),
            usiaTextView.leadingAnchor.constraint(equalTo: usiaLabel.leadingAnchor),
            usiaTextView.widthAnchor.constraint(equalToConstant: usiaTextView.width),
            usiaTextView.heightAnchor.constraint(equalToConstant: usiaTextView.height),
        ])
    }
    
    func setupSudahSterilCheckboxButton() {
        scrollView.addSubview(sudahSterilCheckboxButton)

        sudahSterilCheckboxButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            sudahSterilCheckboxButton.topAnchor.constraint(equalTo: beratTextView.bottomAnchor, constant: 24),
            sudahSterilCheckboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sudahSterilCheckboxButton.widthAnchor.constraint(equalToConstant: sudahSterilCheckboxButton.width),
            sudahSterilCheckboxButton.heightAnchor.constraint(equalToConstant: sudahSterilCheckboxButton.height),
        ])
    }
    
    func setupRutinMenggunakanObatKutuCheckboxButton() {
        scrollView.addSubview(rutinMenggunakanObatKutuCheckboxButton)

        rutinMenggunakanObatKutuCheckboxButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rutinMenggunakanObatKutuCheckboxButton.topAnchor.constraint(equalTo: sudahSterilCheckboxButton.bottomAnchor, constant: 24),
            rutinMenggunakanObatKutuCheckboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rutinMenggunakanObatKutuCheckboxButton.widthAnchor.constraint(equalToConstant: rutinMenggunakanObatKutuCheckboxButton.width),
            rutinMenggunakanObatKutuCheckboxButton.heightAnchor.constraint(equalToConstant: rutinMenggunakanObatKutuCheckboxButton.height),
        ])
    }
    
    func setupRutinVaksinasiCheckboxButton() {
        scrollView.addSubview(rutinVaksinasiCheckboxButton)

        rutinVaksinasiCheckboxButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rutinVaksinasiCheckboxButton.topAnchor.constraint(equalTo: rutinMenggunakanObatKutuCheckboxButton.bottomAnchor, constant: 24),
            rutinVaksinasiCheckboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rutinVaksinasiCheckboxButton.widthAnchor.constraint(equalToConstant: rutinVaksinasiCheckboxButton.width),
            rutinVaksinasiCheckboxButton.heightAnchor.constraint(equalToConstant: rutinVaksinasiCheckboxButton.height),
        ])
    }
    
    func setupPreferensiPetSectionLabel() {
        scrollView.addSubview(preferensiPetSectionLabel)

        preferensiPetSectionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            preferensiPetSectionLabel.topAnchor.constraint(equalTo: rutinVaksinasiCheckboxButton.bottomAnchor, constant: 40),
            preferensiPetSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            preferensiPetSectionLabel.widthAnchor.constraint(equalToConstant: preferensiPetSectionLabel.width),
            preferensiPetSectionLabel.heightAnchor.constraint(equalToConstant: preferensiPetSectionLabel.height),
        ])
    }
    
    func setupFasilitasLabel() {
        scrollView.addSubview(fasilitasLabel)

        fasilitasLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            fasilitasLabel.topAnchor.constraint(equalTo: preferensiPetSectionLabel.bottomAnchor, constant: 24),
            fasilitasLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fasilitasLabel.widthAnchor.constraint(equalToConstant: fasilitasLabel.width),
            fasilitasLabel.heightAnchor.constraint(equalToConstant: fasilitasLabel.height),
        ])
    }
    
    func setupFasilitasButtons() {
        let fasilitasButtons = [tempatBermainFasilitasButton, ruanganBerACFasilitasButton, cctvFasilitasButton, termasukMakananFasilitasButton, tersediaAntarJemputFasilitasButton, tersediaGroomingFasilitasButton, tersediaDokterHewanFasilitasButton]
        
        var z = 0
        for i in 0..<3 {
            for j in 0..<3 {
                scrollView.addSubview(fasilitasButtons[z])
                fasilitasButtons[z].translatesAutoresizingMaskIntoConstraints = false
                
                if j == 0 {
                    fasilitasButtons[z].leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
                } else if j == 1 {
                    fasilitasButtons[z].centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                } else if j == 2 {
                    fasilitasButtons[z].trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
                }
                
                if i == 0 {
                    fasilitasButtons[z].topAnchor.constraint(equalTo: fasilitasLabel.bottomAnchor, constant: 8).isActive = true
                } else if i == 1 {
                    fasilitasButtons[z].topAnchor.constraint(equalTo: tempatBermainFasilitasButton.bottomAnchor, constant: 8).isActive = true
                } else if i == 2 {
                    fasilitasButtons[z].topAnchor.constraint(equalTo: termasukMakananFasilitasButton.bottomAnchor, constant: 8).isActive = true
                }
                
                fasilitasButtons[z].widthAnchor.constraint(equalToConstant: 108).isActive = true
                fasilitasButtons[z].heightAnchor.constraint(equalToConstant: 109).isActive = true
                
                if z == 6 {
                    break
                }
                z += 1
            }
        }
    }
    
    func setupKebiasaanPetSectionLabel() {
        scrollView.addSubview(kebiasaanPetSectionLabel)
        
        kebiasaanPetSectionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            kebiasaanPetSectionLabel.topAnchor.constraint(equalTo: tersediaDokterHewanFasilitasButton.bottomAnchor, constant: 40),
            kebiasaanPetSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            kebiasaanPetSectionLabel.widthAnchor.constraint(equalToConstant: kebiasaanPetSectionLabel.width),
            kebiasaanPetSectionLabel.heightAnchor.constraint(equalToConstant: kebiasaanPetSectionLabel.height),
        ])
    }
    
    func setupKebiasaanDropDownButton() {
        scrollView.addSubview(kebiasaanDropDownButton)
        
        // SETUP LABEL
        let label = UILabel()
        label.text = "Pilih kebiasaan"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .customGrayForCheckboxBorder
        label.sizeToFit()
        
        kebiasaanDropDownButton.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: kebiasaanDropDownButton.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: kebiasaanDropDownButton.leadingAnchor, constant: 16),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: label.height),
        ])
        
        // SETUP CHEVRON ICON
        chevronImageView.image = UIImage(systemName: "chevron.down")
        chevronImageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 14, weight: .semibold))
        
        chevronImageView.tintColor = .customGrayForCheckboxBorder
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.frame.size  = CGSize(width: 24, height: 24)
        
        kebiasaanDropDownButton.addSubview(chevronImageView)
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chevronImageView.centerYAnchor.constraint(equalTo: kebiasaanDropDownButton.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: kebiasaanDropDownButton.trailingAnchor, constant: -16),
            chevronImageView.widthAnchor.constraint(equalToConstant: chevronImageView.width),
            chevronImageView.heightAnchor.constraint(equalToConstant: chevronImageView.height),
        ])
        
        
        // DROPDOWN BUTTON STYLING
        
        kebiasaanDropDownButton.backgroundColor = .customGrayForInputFields
        kebiasaanDropDownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        kebiasaanDropDownButton.layer.cornerRadius = 8
        kebiasaanDropDownButton.layer.masksToBounds = true
        
        kebiasaanDropDownButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            kebiasaanDropDownButton.topAnchor.constraint(equalTo: kebiasaanPetSectionLabel.bottomAnchor, constant: 58),
            kebiasaanDropDownButton.topAnchor.constraint(equalTo: kebiasaanPetSectionLabel.bottomAnchor, constant: 8),
            kebiasaanDropDownButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            kebiasaanDropDownButton.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            kebiasaanDropDownButton.heightAnchor.constraint(equalToConstant: 44 + 10), // 10 adalah bottom lebih
        ])
    }
    
    func setupKebiasaanDropDownTableView() {
        // TODO: KAK, TERNYATA INI BISA VIEW.ADDSUBVIEW ATAU SCROLLVIEW.ADDSUBVIEW SAMA AJA YAA???? :/
        scrollView.addSubview(kebiasaanDropDownTableView)
        
        kebiasaanDropDownTableView.separatorStyle = .none
        kebiasaanDropDownTableView.backgroundColor = .customGrayForInputFields
        
        kebiasaanDropDownTableView.delegate = self
        kebiasaanDropDownTableView.dataSource = self
        kebiasaanDropDownTableView.register(KebiasaanDropDownTableViewCell.self, forCellReuseIdentifier: KebiasaanDropDownTableViewCell.identifier)
        kebiasaanDropDownTableView.isScrollEnabled = false
        kebiasaanDropDownTableView.isHidden = true
        kebiasaanDropDownTableView.sizeToFit()
        
        kebiasaanDropDownTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            kebiasaanDropDownTableView.topAnchor.constraint(equalTo: kebiasaanDropDownButton.bottomAnchor),
            kebiasaanDropDownTableView.centerXAnchor.constraint(equalTo: kebiasaanDropDownButton.centerXAnchor),
            kebiasaanDropDownTableView.widthAnchor.constraint(equalTo: kebiasaanDropDownButton.widthAnchor),
        ])
        
        self.kebiasaanTableViewHeightAnchor = kebiasaanDropDownTableView.heightAnchor.constraint(equalToConstant: 0)
        kebiasaanTableViewHeightAnchor.isActive = true
    }
    
    func setupRiwayatPenyakitSectionLabel() {
        scrollView.addSubview(riwayatPenyakitSectionLabel)

        riwayatPenyakitSectionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            riwayatPenyakitSectionLabel.topAnchor.constraint(equalTo: kebiasaanDropDownTableView.bottomAnchor, constant: 40),
            riwayatPenyakitSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            riwayatPenyakitSectionLabel.widthAnchor.constraint(equalToConstant: riwayatPenyakitSectionLabel.width),
            riwayatPenyakitSectionLabel.heightAnchor.constraint(equalToConstant: riwayatPenyakitSectionLabel.height),
        ])
    }
    
    @objc func doneButtonActionRiwayatPenyakit() {
        self.riwayatPenyakitTextView.resignFirstResponder()
    }
    
    func setupRiwayatPenyakitTextView() {
        scrollView.addSubview(riwayatPenyakitContainerView)
        scrollView.addSubview(riwayatPenyakitTextView)
        
        riwayatPenyakitTextView.delegate = self
        riwayatPenyakitContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickRiwayatPenyakitContainerView)))
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.backgroundColor = .white
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonActionRiwayatPenyakit))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        riwayatPenyakitTextView.inputAccessoryView = doneToolbar
        
        riwayatPenyakitContainerView.backgroundColor = .customGrayForInputFields
        riwayatPenyakitContainerView.layer.cornerRadius = 8
        riwayatPenyakitContainerView.layer.masksToBounds = true
        
        riwayatPenyakitTextView.delegate = self
        riwayatPenyakitTextView.textContainerInset = .zero
        riwayatPenyakitTextView.backgroundColor = .clear
        riwayatPenyakitTextView.font = .systemFont(ofSize: 14, weight: .regular)
        
        riwayatPenyakitContainerView.translatesAutoresizingMaskIntoConstraints = false
        riwayatPenyakitTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            riwayatPenyakitContainerView.topAnchor.constraint(equalTo: riwayatPenyakitSectionLabel.bottomAnchor, constant: 7),
            riwayatPenyakitContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            riwayatPenyakitContainerView.widthAnchor.constraint(equalToConstant: 342),
            
            riwayatPenyakitTextView.topAnchor.constraint(equalTo: riwayatPenyakitContainerView.topAnchor, constant: 22),
            riwayatPenyakitTextView.centerXAnchor.constraint(equalTo: riwayatPenyakitContainerView.centerXAnchor),
            riwayatPenyakitTextView.widthAnchor.constraint(equalToConstant: 342 - (16 * 2))
        ])
        
        self.riwayatPenyakitTextViewHeightAnchor = riwayatPenyakitTextView.heightAnchor.constraint(equalToConstant: 17)
        riwayatPenyakitTextViewHeightAnchor.isActive = true
        
        riwayatPenyakitContainerView.bottomAnchor.constraint(equalTo: riwayatPenyakitTextView.bottomAnchor, constant: 22).isActive = true
//        riwayatPenyakitContainerViewHeightAnchor.isActive = true
    }
    
    // MARK: SIMPAN BUTTON CONFIGURATIONS
    
    func setupSimpanButton() {
        scrollView.addSubview(simpanButton)
        
        let label = UILabel()
        label.text = "Simpan"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.sizeToFit()
        
        scrollView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: simpanButton.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: simpanButton.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: label.height),
        ])
        
        simpanButton.backgroundColor = .customOrange
        simpanButton.layer.cornerRadius = 4
        simpanButton.frame.size = CGSize(width: 342, height: 44)
        
        simpanButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            simpanButton.topAnchor.constraint(equalTo: riwayatPenyakitContainerView.bottomAnchor, constant: 16),
            simpanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            simpanButton.widthAnchor.constraint(equalToConstant: simpanButton.width),
            simpanButton.heightAnchor.constraint(equalToConstant: simpanButton.height),
        ])
        
        self.contentViewBottomAnchor = contentView.bottomAnchor.constraint(equalTo: simpanButton.bottomAnchor, constant: 6)
        contentViewBottomAnchor.isActive = true
        
        shouldDisableSimpanButton()
    }
    
    func shouldDisableSimpanButton() {
        
        // CHECK NAMA
        if let text = self.namaAnabulTextField.textField.text {
            if text.count == 0 {
                self.requiredFieldsAlert.append(.namaAnabulIsEmpty)
            } else {
                self.requiredFieldsAlert.removeAll(where: { v in
                    return v == .namaAnabulIsEmpty
                })
            }
        }
        
        
        // CHECK RAS
        if self.petBreeds.count == 0 {
            self.requiredFieldsAlert.append(.petBreedIsNotSelected)
            self.requiredFieldsAlert.append(.speciesIsNotSelected)
        } else {
            
            let countSelectedPetBreed = self.petBreeds.compactMap { petBreed in
                if petBreed.isSelected {
                    return petBreed
                } else {
                    return nil
                }
            }
            
            if countSelectedPetBreed.count == 0 {
                self.requiredFieldsAlert.append(.petBreedIsNotSelected)
            } else {
                self.requiredFieldsAlert.removeAll(where: { v in
                    return v == .petBreedIsNotSelected
                })
            }
            
            self.requiredFieldsAlert.removeAll(where: { v in
                return v == .petBreedIsNotSelected
            })
        }
        
        
        // CHECK SPESIES
        if !(self.anjingSpesiesButton.isClicked || self.kucingSpesiesButton.isClicked) {
            self.requiredFieldsAlert.append(.speciesIsNotSelected)
        } else {
            if self.petBreeds.count == 0 {
                print("x")
            } else {
                self.requiredFieldsAlert.removeAll(where: { v in
                    return v == .speciesIsNotSelected
                })
            }
        }
        
        
        // CHECK JENIS KELAMIN
        if !(self.jantanJenisKelaminButton.isClicked || self.betinaJenisKelaminButton.isClicked) {
            self.requiredFieldsAlert.append(.genderIsNotSelected)
        } else {
            self.requiredFieldsAlert.removeAll(where: { v in
                return v == .genderIsNotSelected
            })
        }
        
        // CHECK BERAT
        if let text = self.beratTextView.textField.text {
            if text.count == 0 {
                self.requiredFieldsAlert.append(.beratIsEmpty)
            } else {
                self.requiredFieldsAlert.removeAll(where: { v in
                    return v == .beratIsEmpty
                })
            }
        }
        
        // CHECK USIA
        if let text = self.usiaTextView.textField.text {
            if text.count == 0 {
                self.requiredFieldsAlert.append(.usiaIsEmpty)
            } else {
                self.requiredFieldsAlert.removeAll(where: { v in
                    return v == .usiaIsEmpty
                })
            }
        }
        
        
        // ???
        
        
        
        // FINAL CHECK
        let temp = Set(self.requiredFieldsAlert)
//        print("x>>", temp.count)
//        for i in temp {
//            print(">>", i.rawValue)
//        }
        
        if temp.count > 0 {
            simpanButton.isEnabled = false
            simpanButton.layer.opacity = 0.4
        } else {
            simpanButton.isEnabled = true
            simpanButton.layer.opacity = 1.0
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // print("viewDidLayoutSubviews \(Int.random(in: 1...10))")
    }
    
    // MARK: @OBJC BUTTONS
    
    @objc func onClickAnjingSpesiesButton() {
        anjingSpesiesButton.isClicked = !anjingSpesiesButton.isClicked
        
        if anjingSpesiesButton.isClicked {
            SpesiesButton.click(anjingSpesiesButton)
            if kucingSpesiesButton.isClicked {
                SpesiesButton.unclick(kucingSpesiesButton)
            }
            
            rasDropDownButtonIsClicked = true
            kebiasaanDropDownButtonIsClicked = true
            
            // HIT!
            fetchBreedsAndHabits(with: "dog")
            self.requiredFieldsAlert.append(.speciesIsNotSelected)
            
            rasChevronImageView.image = UIImage(systemName: "chevron.down")
            chevronImageView.image = UIImage(systemName: "chevron.down")
            
            rasDropDownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            kebiasaanDropDownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            
            rasDropDownButtonIsClicked = false
            kebiasaanDropDownButtonIsClicked = false
            
            SpesiesButton.unclick(anjingSpesiesButton)
            
            // CLEAR!
            self.petBreeds = []
            self.requiredFieldsAlert.append(.petBreedIsNotSelected)
            
            self.petHabits = []
            
            self.rasDropDownTableView.reloadData()
            self.kebiasaanDropDownTableView.reloadData()
            
            self.rasTableViewHeightAnchor.constant = 0
            self.kebiasaanTableViewHeightAnchor.constant = 0
        }
        
        // TODO: KAK INI BEST PRACTICE NYA GIMANA YA 🙏
        shouldDisableSimpanButton()
    }
    
    @objc func onClickKucingSpesiesButton() {
        kucingSpesiesButton.isClicked = !kucingSpesiesButton.isClicked
        
        if kucingSpesiesButton.isClicked {
            SpesiesButton.click(kucingSpesiesButton)
            if anjingSpesiesButton.isClicked {
                SpesiesButton.unclick(anjingSpesiesButton)
            }
            
            rasDropDownButtonIsClicked = true
            kebiasaanDropDownButtonIsClicked = true
            
            // HIT!
            self.fetchBreedsAndHabits(with: "cat")
            self.requiredFieldsAlert.append(.speciesIsNotSelected)
            
            rasChevronImageView.image = UIImage(systemName: "chevron.down")
            chevronImageView.image = UIImage(systemName: "chevron.down")
            
            rasDropDownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            kebiasaanDropDownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            
            rasDropDownButtonIsClicked = false
            kebiasaanDropDownButtonIsClicked = false
            
            SpesiesButton.unclick(kucingSpesiesButton)
            
            // CLEAR!
            self.petBreeds = []
            self.requiredFieldsAlert.append(.petBreedIsNotSelected)
            
            self.petHabits = []
            
            self.rasDropDownTableView.reloadData()
            self.kebiasaanDropDownTableView.reloadData()
            
            self.rasTableViewHeightAnchor.constant = 0
            self.kebiasaanTableViewHeightAnchor.constant = 0
        }
        
        shouldDisableSimpanButton()
    }
    
    @objc func onClickRasDropDownButton() {
        self.rasDropDownButtonIsClicked = !self.rasDropDownButtonIsClicked
        
        if self.rasDropDownButtonIsClicked {
            rasChevronImageView.image = UIImage(systemName: "chevron.up")
            rasDropDownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            rasChevronImageView.image = UIImage(systemName: "chevron.down")
        }
        
        UIView.animate(withDuration: 0.3) {
            if self.rasDropDownButtonIsClicked {
                self.rasDropDownTableView.isHidden = false
                
                //                self.kebiasaanTableViewHeightAnchor.constant = (11 * 34)
                self.rasTableViewHeightAnchor.constant = CGFloat(self.petBreeds.count * 34)
            } else {
                self.rasTableViewHeightAnchor.constant = 0
            }
            
            self.view.layoutIfNeeded()
        } completion: { isDone in
            if isDone {
                if !self.rasDropDownButtonIsClicked { // IF NOT CLICKED
                    self.rasDropDownTableView.isHidden = true
                    self.rasDropDownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                }
            }
        }
        
        shouldDisableSimpanButton()
    }
    
    @objc func onClickBetinaJenisKelaminButton() {
        betinaJenisKelaminButton.isClicked = !betinaJenisKelaminButton.isClicked
        
        if betinaJenisKelaminButton.isClicked {
            JenisKelaminButton.click(betinaJenisKelaminButton)
            if jantanJenisKelaminButton.isClicked {
                JenisKelaminButton.unclick(jantanJenisKelaminButton)
            }
        } else {
            JenisKelaminButton.unclick(betinaJenisKelaminButton)
        }
        
        shouldDisableSimpanButton()
    }
    
    @objc func onClickJantanJenisKelaminButton() {
        jantanJenisKelaminButton.isClicked = !jantanJenisKelaminButton.isClicked
        
        if jantanJenisKelaminButton.isClicked {
            JenisKelaminButton.click(jantanJenisKelaminButton)
            if betinaJenisKelaminButton.isClicked {
                JenisKelaminButton.unclick(betinaJenisKelaminButton)
            }
        } else {
            JenisKelaminButton.unclick(jantanJenisKelaminButton)
        }
        
        shouldDisableSimpanButton()
    }
    
    @objc func onClickKebiasaanDropDownButton() {
        self.kebiasaanDropDownButtonIsClicked = !self.kebiasaanDropDownButtonIsClicked
        
        if self.kebiasaanDropDownButtonIsClicked {
            chevronImageView.image = UIImage(systemName: "chevron.up")
            kebiasaanDropDownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            chevronImageView.image = UIImage(systemName: "chevron.down")
        }
        
        UIView.animate(withDuration: 0.3) {
            if self.kebiasaanDropDownButtonIsClicked {
                self.kebiasaanDropDownTableView.isHidden = false
                
                //                self.kebiasaanTableViewHeightAnchor.constant = (11 * 34)
                self.kebiasaanTableViewHeightAnchor.constant = CGFloat(self.petHabits.count * 34)
            } else {
                self.kebiasaanTableViewHeightAnchor.constant = 0
            }
            
            self.view.layoutIfNeeded()
        } completion: { isDone in
            if isDone {
                if !self.kebiasaanDropDownButtonIsClicked { // IF NOT CLICKED
                    self.kebiasaanDropDownTableView.isHidden = true
                    self.kebiasaanDropDownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                }
            }
        }
    }
    
    @objc func onClickRiwayatPenyakitContainerView() {
        self.riwayatPenyakitTextView.becomeFirstResponder()
    }
    
    @objc func onClickSimpanButton() {
        riwayatPenyakitTextView.resignFirstResponder()
        
        // NAMA
        // >extension
        
        // BERAT
        // >extension
        
        // USIA
        // >extension
        
        
        // SPESIES
        if kucingSpesiesButton.isClicked {
            viewModel.species = "cat"
        } else if anjingSpesiesButton.isClicked {
            viewModel.species = "dog"
        }
        
        // GENDER
        if betinaJenisKelaminButton.isClicked {
            viewModel.petGender = "female"
        } else if jantanJenisKelaminButton.isClicked {
            viewModel.petGender = "male"
        }
        
        // SUDAH STERIL
        if sudahSterilCheckboxButton.isClicked {
            viewModel.hasBeenSterilized = true
        } else {
            viewModel.hasBeenSterilized = false
        }
        
        // SUDAH VAKSIN
        if rutinVaksinasiCheckboxButton.isClicked {
            viewModel.hasBeenVaccinatedRoutinely = true
        } else {
            viewModel.hasBeenVaccinatedRoutinely = false
        }

        // SUDAH BEBAS KUTU
        if rutinMenggunakanObatKutuCheckboxButton.isClicked {
            viewModel.hasBeenFleaFreeRegularly = true
        } else {
            viewModel.hasBeenFleaFreeRegularly = false
        }
        
        // FASILITAS
        var fasilitas = [String]()
        if tempatBermainFasilitasButton.isClicked {
            fasilitas.append("playground")
        }
        if ruanganBerACFasilitasButton.isClicked {
            fasilitas.append("ac")
        }
        if cctvFasilitasButton.isClicked {
            fasilitas.append("cctv")
        }
        if termasukMakananFasilitasButton.isClicked {
            fasilitas.append("food")
        }
        if tersediaAntarJemputFasilitasButton.isClicked {
            fasilitas.append("delivery")
        }
        if tersediaGroomingFasilitasButton.isClicked {
            fasilitas.append("grooming")
        }
        if tersediaDokterHewanFasilitasButton.isClicked {
            fasilitas.append("veterinary")
        }
        viewModel.boardingFacilities = fasilitas
        
        // RIWAYAT PENYAKIT
        // >extension
        
        // RAS - PET BREEDS
        for petBreed in petBreeds {
            if petBreed.isSelected {
                viewModel.petBreedId = petBreed.id
                break
            }
        }
        
        // KEBIASAAN - PET HABITS
        viewModel.petHabitIds = self.petHabits.compactMap({ petHabit in
            if petHabit.isSelected {
                return petHabit.id
            } else {
                return nil
            }
        })
        
        viewModel.image = profileImageViewButton.profileImageView.image
        
        self.usiaTextView.textField.resignFirstResponder()
        self.beratTextView.textField.resignFirstResponder()
        
        let vc = AnabulTersimpanViewController()
        vc.viewModel = self.viewModel
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    // MARK: Keyboard Notification Center
    
    @objc func keyboardWillShow(notification: NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += keyboardFrame.height
        }
    }

    
    // MARK: CAMERA & GALLERY IMAGE PICKER
    
    @objc func onClickProfileImageButton() {
        if profileImageViewButton.profileImageView.image == nil {
            let alert = UIAlertController(title: "Profile Picture", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { _ in
                self.presentCameraImagePickerVC()
            }))
            alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { _ in
                self.presentPhotoLibraryImagePickerVC()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Profile Picture", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { _ in
                self.presentCameraImagePickerVC()
            }))
            alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { _ in
                self.presentPhotoLibraryImagePickerVC()
            }))
            alert.addAction(UIAlertAction(title: "Remove Photo", style: .destructive, handler: { _ in
                self.profileImageViewButton.profileImageView.image = nil
                self.profileImageViewButton.addCatIconView()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(alert, animated: true)
        }
    }
    
    func presentCameraImagePickerVC() {
        let imagePickerVC = UIImagePickerController() // dia inherit uiviewcontroller
        imagePickerVC.sourceType = .camera
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = true
        present(imagePickerVC, animated: true)
    }
    
    func presentPhotoLibraryImagePickerVC() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .savedPhotosAlbum
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = true
        present(imagePickerVC, animated: true)
    }
    
    
    // MARK: FETCH BREEDS AND HABITS DATA
    func fetchBreedsAndHabits(with species: String) {
        var success = false
        
        let group = DispatchGroup()
        group.enter()
        
        APICaller.shared.getBreedsAndHabits(species: species) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let response):
                self.petBreeds = response.data.petBreeds.compactMap({ petBreed in
                    return PetBreedRadioButton(
                        id: petBreed.id,
                        isSelected: false,
                        name: petBreed.name
                    )
                })
                
                self.petHabits = response.data.petHabits.compactMap({ petHabit in
                    return PetHabitCheckBox(
                        id: petHabit.id,
                        isSelected: false,
                        name: petHabit.name
                    )
                })
                
                success = true
                
                break
            case .failure(_):
                print("ERROR IN TAMBAH ANABUL VC")
                break
            }
        }
        
        group.notify(queue: .main) {
            self.rasDropDownTableView.reloadData()
            self.kebiasaanDropDownTableView.reloadData()
            
            self.rasTableViewHeightAnchor.constant = 0
            self.kebiasaanTableViewHeightAnchor.constant = 0
            
            if success {
                print(">> YEAHHH")
                print(self.rasDropDownButtonIsClicked)
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
                        if self.rasDropDownButtonIsClicked {
                            self.rasDropDownTableView.isHidden = false
                            
                            //                self.kebiasaanTableViewHeightAnchor.constant = (11 * 34)
                            self.rasTableViewHeightAnchor.constant = CGFloat(self.petBreeds.count * 34)
                        } else {
                            self.rasTableViewHeightAnchor.constant = 0
                        }
                        
                        self.view.layoutIfNeeded()
                    } completion: { isDone in
                        if isDone {
                            if !self.rasDropDownButtonIsClicked { // IF NOT CLICKED
                                self.rasDropDownTableView.isHidden = true
                                self.rasDropDownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                            }
                        }
                    }
                    
                    UIView.animate(withDuration: 0.3) {
                        if self.kebiasaanDropDownButtonIsClicked {
                            self.kebiasaanDropDownTableView.isHidden = false
                            
                            //                self.kebiasaanTableViewHeightAnchor.constant = (11 * 34)
                            self.kebiasaanTableViewHeightAnchor.constant = CGFloat(self.petHabits.count * 34)
                        } else {
                            self.kebiasaanTableViewHeightAnchor.constant = 0
                        }
                        
                        self.view.layoutIfNeeded()
                    } completion: { isDone in
                        if isDone {
                            if !self.kebiasaanDropDownButtonIsClicked { // IF NOT CLICKED
                                self.kebiasaanDropDownTableView.isHidden = true
                                self.kebiasaanDropDownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                            }
                        }
                    }
                }
            }
        }
    }
    
}


// MARK: IMAGE PICKER
extension TambahProfilAnabulViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            self.profileImageViewButton.profileImageView.image = image
            self.profileImageViewButton.catIconView.removeFromSuperview()
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}

// MARK: TABLE VIEW
extension TambahProfilAnabulViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === rasDropDownTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: RasDropDownTableViewCell.identifier, for: indexPath) as! RasDropDownTableViewCell
            cell.selectionStyle = .none
            
            cell.configure(with: self.petBreeds[indexPath.row])
            
            return cell
        } else if tableView === kebiasaanDropDownTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: KebiasaanDropDownTableViewCell.identifier, for: indexPath) as! KebiasaanDropDownTableViewCell
            cell.selectionStyle = .none
            
            cell.configure(with: self.petHabits[indexPath.row])
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === rasDropDownTableView {
            return self.petBreeds.count
        } else if tableView === kebiasaanDropDownTableView {
            return self.petHabits.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // TODO: KOK KEREN DIA BISA BEDAIN YA INDEXPATH.ROW NYA ???
        if tableView === rasDropDownTableView {
            let selectedRow: Int = indexPath.row
            
            for i in 0..<petBreeds.count {
                if i == selectedRow {
                    petBreeds[i].isSelected = true
                } else {
                    petBreeds[i].isSelected = false
                }
            }
            
            tableView.reloadData()
            shouldDisableSimpanButton()
        } else if tableView === kebiasaanDropDownTableView {
            self.petHabits[indexPath.row].isSelected = !self.petHabits[indexPath.row].isSelected
            
            tableView.reloadData()
            shouldDisableSimpanButton()
        }
        
        
        

        
        // TODO: KAK, INI BEST PRACTICE NYA GIMANA YA, AKU JADINYA TOGGLE LEWAT MODELS, AWAL NGIRANYA BISA BIKIN ARRAY CELL CELL NYA PAKE DOWN CASTING
//        let cells = kebiasaanDropDownTableView.subviews.compactMap { subview in
//            if let subview = subview as? KebiasaanDropDownTableViewCell {
//                return subview
//            } else {
//                return nil
//            }
//        }
        
        // TODO: KAK, INI SETELAH RELOAD DATA, CONSTRAINT NYA DIA KAYAKNYA NUMPUK
        // JADINYA LAYOUTING KU GANTI PAKAI YANG frame = CGRect()
        // tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 34 // HARD CODE 34
    }
}

// MARK: TEXT VIEW
extension TambahProfilAnabulViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        UIView.animate(withDuration: 0.3) {
            self.kebiasaanDropDownButtonIsClicked = false
            self.kebiasaanTableViewHeightAnchor.constant = 0
            self.view.layoutIfNeeded()
        } completion: { done in
            if done {
                if !self.kebiasaanDropDownButtonIsClicked {
                    self.kebiasaanDropDownTableView.isHidden = true
                }
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let heightMultiplier: CGFloat = ceil((textView.textInputView.height - 33) / 17) + 1
        
        self.riwayatPenyakitTextViewHeightAnchor.constant = heightMultiplier * 17
        
        
        UIView.animate(withDuration: 0.3) {
            self.kebiasaanDropDownButtonIsClicked = false
            self.kebiasaanTableViewHeightAnchor.constant = 0
            self.view.layoutIfNeeded()
        } completion: { done in
            if done {
                if !self.kebiasaanDropDownButtonIsClicked {
                    self.kebiasaanDropDownTableView.isHidden = true
                }
            }
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.viewModel.historyOfIllness = textView.text
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.viewModel.historyOfIllness = textView.text
        return true
    }
}
