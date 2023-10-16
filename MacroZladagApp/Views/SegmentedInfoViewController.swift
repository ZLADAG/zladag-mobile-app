//
//  SegmentedInfoViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 13/10/23.
//

import UIKit

class SegmentedInfoViewController: UIViewController {

    var screenSize = UIScreen.main.bounds.size

    var height = 0.0
    
    // Titles
    var facilityTitleLabel: UILabel!
    var cageSizeTitleLabel: UILabel!
    var policyTitleLabel: UILabel!
    var aboutTitleLabel: UILabel!
    var locationTitleLabel: UILabel!
    
    // Facility content -> sesuai array
    var facilityContentStack: UIStackView! // hrsnya Collection view
    
    // Cage content
    var cageSizeContentStack: UIStackView!
    var cageSmallLabel: UILabel!
    var cageMediumLabel: UILabel!
    var cageLargeLabel: UILabel!
    
    // Policy content
    var policyContentStack: UIStackView!
    
    // About content
    var aboutContentStack: UIStackView!
    
    // Location content
//    var locationMapView:
    var locationContentStack: UIStackView!
    
    var facilityInfoStack: UIStackView!
    var cageSizeInfoStack: UIStackView!
    var policyInfoStack: UIStackView!
    var aboutInfoStack: UIStackView!
    var locationInfoStack: UIStackView!

    var infoDetailsStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpComponents()
        setUpConstraint()
    }
    
    //MARK: Setup components
    private func setUpComponents() {
        
        setUpFacilityInfo()
        setUpCageSizeInfo()
        setUpPolicyInfo()
        setUpAboutInfo()
        setUpLocationInfo()
        
        infoDetailsStack = UIStackView(arrangedSubviews: [facilityInfoStack, cageSizeInfoStack, policyInfoStack, aboutInfoStack, locationInfoStack])
        infoDetailsStack.translatesAutoresizingMaskIntoConstraints = false
        infoDetailsStack.axis  = NSLayoutConstraint.Axis.vertical
        infoDetailsStack.distribution  = UIStackView.Distribution.fill
        infoDetailsStack.alignment = UIStackView.Alignment.fill
        infoDetailsStack.spacing   = 32.0
        
        self.view.addSubview(infoDetailsStack)
        
    }
    
    //MARK: Setup constraints
    private func setUpConstraint() {
        NSLayoutConstraint.activate([
            infoDetailsStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32),
            infoDetailsStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            infoDetailsStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            infoDetailsStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32)
        ])
    }
    
    //MARK: Setup Content
    private func setUpFacilityInfo() {
        // Set Title
        facilityTitleLabel = createTitleLabel("Fasilitas & Layanan")
        
        let playgroundStatus = true
        let acStatus = true
        let cctvStatus = true
        let petFoodStatus = true
        let pickUpStatus = false
        let groomingStatus = true
        let vetStatus = false
        
        var allViewItems:[UIView] = []
        var leftViewItems:[UIView] = []
        var rightViewItems:[UIView] = []
        
        // Validate provided facilities
        if (playgroundStatus) {
            let playground = createIconLabel("facility-playground-icon", "Tempat Bermain")
            allViewItems.append(playground)
        }
        if (acStatus) {
            let ac = createIconLabel("facility-ac-icon", "Ruangan ber-AC")
            allViewItems.append(ac)
        }
        if (cctvStatus) {
            let cctv = createIconLabel("facility-cctv-icon", "CCTV")
            allViewItems.append(cctv)
        }
        if (petFoodStatus) {
            let petFood = createIconLabel("facility-petFood-icon", "Termasuk Makanan")
            allViewItems.append(petFood)
        }
        if (pickUpStatus) {
            let pickUp = createIconLabel("facility-pickUp-icon", "Jasa Antar Jemput")
            allViewItems.append(pickUp)
        }
        if (groomingStatus) {
            let grooming = createIconLabel("facility-grooming-icon", "Termasuk Grooming")
            allViewItems.append(grooming)
        }
        if (vetStatus) {
            let vet = createIconLabel("facility-vet-icon", "Tersedia Dokter Hewan")
            allViewItems.append(vet)
        }
    
        
        // DIVIDE ITEMS TO LEFT & RIGHT VIEW
        let totFacility = allViewItems.count
        var centerIdx = 0
        
        // Add left item
        if totFacility % 2 == 0 {
            centerIdx = totFacility/2 - 1
            for i in 0...centerIdx {
                leftViewItems.append(allViewItems[i])
            }
        } else {
            centerIdx = totFacility/2
            for i in 0...centerIdx {
                leftViewItems.append(allViewItems[i])
            }
        }
        
        // Add right items
        for i in (centerIdx + 1)...(totFacility - 1) {
            rightViewItems.append(allViewItems[i])
        }
        
        // pop all items in allViewItems[]
        allViewItems.removeAll()
        
         
        // CREATE STACKS
        let leftStackView = UIStackView(arrangedSubviews: leftViewItems)
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.axis  = NSLayoutConstraint.Axis.vertical
        leftStackView.distribution  = UIStackView.Distribution.fill
        leftStackView.alignment = UIStackView.Alignment.fill
        leftStackView.spacing   = 16.0
        
        let rightStackView = UIStackView(arrangedSubviews: rightViewItems)
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.axis  = NSLayoutConstraint.Axis.vertical
        rightStackView.distribution  = UIStackView.Distribution.fill
        rightStackView.alignment = UIStackView.Alignment.fill
        rightStackView.spacing   = 16.0
        
        facilityContentStack = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        facilityContentStack.translatesAutoresizingMaskIntoConstraints = false
        facilityContentStack.axis  = NSLayoutConstraint.Axis.horizontal
        facilityContentStack.distribution  = UIStackView.Distribution.fillEqually
        facilityContentStack.alignment = UIStackView.Alignment.firstBaseline
        
        // Wrap all
        facilityInfoStack = createInfoStack(facilityTitleLabel, content: facilityContentStack)
    }
    
    private func setUpCageSizeInfo() {
        // Set Title
        cageSizeTitleLabel = createTitleLabel("Ukuran Kandang")

        // Set Content
        cageSmallLabel = createCageLabel("S", 35, 60, "cm")
        cageMediumLabel = createCageLabel("M", 45, 70, "cm")
        cageLargeLabel = createCageLabel("L", 55, 80, "cm")
        
        cageSizeContentStack = UIStackView(arrangedSubviews: [cageSmallLabel, cageMediumLabel, cageLargeLabel])
        cageSizeContentStack.translatesAutoresizingMaskIntoConstraints = false

        cageSizeContentStack.axis  = NSLayoutConstraint.Axis.vertical
        cageSizeContentStack.distribution  = UIStackView.Distribution.equalSpacing
        cageSizeContentStack.alignment = UIStackView.Alignment.leading
        cageSizeContentStack.spacing   = 8.0
        
        // Wrap all
        cageSizeInfoStack = createInfoStack(cageSizeTitleLabel, content: cageSizeContentStack)
    }
    
    private func setUpPolicyInfo() {
        // Set Title
        policyTitleLabel = createTitleLabel("Kebijakan Pet Hotel")
        
        // Open hours
        let startCheckIn = "12.00"
        let endCheckIn = "23.00"
        let startCheckOut = "14.00"
        let endCheckOut = "17.00"
        
        let openHoursStack = createPolicyOpenHourContent(
            "policy-clock-icon",
            "Waktu Check In",
            "\(startCheckIn) - \(endCheckIn)",
            "\(startCheckOut) - \(endCheckOut)"
        )
        // Vaccinated
        let vaccinatedStack = createIconLabelWithTitle("policy-vaccine-icon", "Sudah Vaksin", "Anabul melakukan vaksin tahunan")
        
        // Age Range
        let minAge = 3
        let maxAge = 5
        let ageRangeStack = createIconLabelWithTitle("policy-age-icon", "Usia Anabul", "Menerima anabul usia \(minAge) bulan - \(maxAge) tahun")
        
        // FelaFree
        let felaFreeStack = createIconLabelWithTitle("policy-clean-icon", "Bebas Kutu", "Anabul bebas dari kutu yang dapat menular")
        
        policyContentStack = UIStackView(arrangedSubviews: [openHoursStack, vaccinatedStack, ageRangeStack, felaFreeStack])
        policyContentStack.translatesAutoresizingMaskIntoConstraints = false

        policyContentStack.axis  = NSLayoutConstraint.Axis.vertical
        policyContentStack.distribution  = UIStackView.Distribution.equalSpacing
        policyContentStack.alignment = UIStackView.Alignment.fill
        policyContentStack.spacing   = 16.0
        
        // Wrap all
        policyInfoStack = createInfoStack(policyTitleLabel, content: policyContentStack)
    }
    
    private func setUpAboutInfo() {
        // Set Title
        aboutTitleLabel = createTitleLabel("Tentang")
        
        // Set Content
        let label = createDefaultLabel("Lorem ipsum dolor sit amet olor sit amet olor sit amet olor sit amet")
        
        aboutContentStack = UIStackView(arrangedSubviews: [label])
        aboutContentStack.translatesAutoresizingMaskIntoConstraints = false
        aboutContentStack.axis  = NSLayoutConstraint.Axis.vertical
        aboutContentStack.distribution  = UIStackView.Distribution.fill
        aboutContentStack.alignment = UIStackView.Alignment.fill
        aboutContentStack.spacing   = 0.0
        
        // Wrap all
        aboutInfoStack = createInfoStack(aboutTitleLabel, content: aboutContentStack)
    }
    
    private func setUpLocationInfo() {
        // Set Title
        locationTitleLabel = createTitleLabel("Lokasi")


        // Set Content - location address
        let label = createLocationLabel("Jl. Alamat pet hotelnya")
        locationInfoStack = UIStackView(arrangedSubviews: [label])
        locationInfoStack.translatesAutoresizingMaskIntoConstraints = false
        locationInfoStack.axis  = NSLayoutConstraint.Axis.vertical
        locationInfoStack.distribution  = UIStackView.Distribution.fill
        locationInfoStack.alignment = UIStackView.Alignment.fill
        locationInfoStack.spacing   = 0.0
        
        // Set Content - map view
        //...
        
        // Wrap all
        locationInfoStack = createInfoStack(locationTitleLabel, content: locationInfoStack)
    }
    
    //MARK: Creation Stacks
    // Stack view
    private func createIconLabel(_ iconName:String, _ text: String) -> UIStackView {
        let icon = createIconImage(iconName)
        let label = createDefaultLabel(text)
        
        let stackView = UIStackView(arrangedSubviews: [icon, label])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.firstBaseline
        stackView.spacing   = 8.0
        
        return stackView
    }
    
    private func createIconLabelWithTitle(_ iconName:String, _ title: String, _ text: String) -> UIStackView {
    
        let titleLabel = createDefaultLabel(title)
        let captlabel = createDefaultLabel(text)
        let icon = createIconImage(iconName)
        
        let labelStackView = UIStackView(arrangedSubviews:[titleLabel, captlabel])
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis  = NSLayoutConstraint.Axis.vertical
        labelStackView.distribution  = UIStackView.Distribution.fill
        labelStackView.alignment = UIStackView.Alignment.fill
        labelStackView.spacing   = 8.0
        
        let stackView = UIStackView(arrangedSubviews: [icon, labelStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.firstBaseline
        stackView.spacing   = 8.0
        
        return stackView
    }
    
    private func createPolicyOpenHourContent(_ iconName:String, _ title: String, _ checkInText: String, _ checkOutText: String) -> UIStackView {
        
        let titleLabel = createDefaultLabel(title)
        let checkInTitle = createDefaultLabel("Check in :")
        let checkOutTitle = createDefaultLabel("Check out :")
        
        let checkInTimeLabel = createDefaultLabel(checkInText)
        let checkOutTimeLabel = createDefaultLabel(checkOutText)
        
        let icon = createIconImage(iconName)
        
        let checkInStack = UIStackView(arrangedSubviews:[checkInTitle, checkInTimeLabel])
        checkInStack.translatesAutoresizingMaskIntoConstraints = false
        checkInStack.axis  = NSLayoutConstraint.Axis.vertical
        checkInStack.distribution  = UIStackView.Distribution.fill
        checkInStack.alignment = UIStackView.Alignment.leading
        checkInStack.spacing   = 0.0
        
        let checkOutStack = UIStackView(arrangedSubviews:[checkOutTitle, checkOutTimeLabel])
        checkOutStack.translatesAutoresizingMaskIntoConstraints = false
        checkOutStack.axis  = NSLayoutConstraint.Axis.vertical
        checkOutStack.distribution  = UIStackView.Distribution.fill
        checkOutStack.alignment = UIStackView.Alignment.leading
        checkOutStack.spacing   = 0.0
        
        let timeStack = UIStackView(arrangedSubviews: [checkInStack, checkOutStack])
        timeStack.translatesAutoresizingMaskIntoConstraints = false
        timeStack.axis  = NSLayoutConstraint.Axis.horizontal
        timeStack.distribution  = UIStackView.Distribution.fillEqually
        timeStack.alignment = UIStackView.Alignment.fill
        timeStack.spacing   = 8.0
        
        let labelStackView = UIStackView(arrangedSubviews:[titleLabel, timeStack])
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis  = NSLayoutConstraint.Axis.vertical
        labelStackView.distribution  = UIStackView.Distribution.fill
        labelStackView.alignment = UIStackView.Alignment.fill
        labelStackView.spacing   = 8.0

        let stackView = UIStackView(arrangedSubviews: [icon, labelStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.firstBaseline
        stackView.spacing   = 8.0
        
        return stackView
    }
    
    private func createInfoStack(_ title: UILabel, content: UIStackView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [title, content])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 16.0
        
        return stackView
    }
    
    //MARK: Creation Label
    private func createTitleLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        label.text = "\(text)"
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }
    
    private func createDefaultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        label.text = "\(text)"
        label.textColor = .black
        label.textAlignment = .left
        
        // enable text wrapping
        label.numberOfLines = 0
        
        return label
    }
    
    private func createCageLabel(_ size: String, _ width: Int, _ height: Int, _ metrics: String) -> UILabel {
        let label = createDefaultLabel("\(size.uppercased()) = \(width)\(metrics) x \(height)\(metrics)")
        return label
    }
    
    private func createLocationLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .customGrayForIcons
        return label
    }
    
    //MARK: Creation Icon
    private func createIconImage(_ img: String) -> UIImageView {
        let icon =  UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: img)
        icon.contentMode = .scaleAspectFit
        icon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return icon
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
