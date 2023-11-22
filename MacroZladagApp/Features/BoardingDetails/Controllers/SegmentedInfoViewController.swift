//
//  SegmentedInfoViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 13/10/23.
//

import UIKit
import Foundation

class SegmentedInfoViewController: UIViewController {

    var screenSize = UIScreen.main.bounds.size
    var mainVc: BoardingDetailsViewController?
    
    var height = 0.0
    
    // Titles
    var facilityTitleLabel: UILabel!
    var cageSizeTitleLabel: UILabel!
    var policyTitleLabel: UILabel!
    var aboutTitleLabel: UILabel!
    var locationTitleLabel: UILabel!
    
    // Facility content -> sesuai array
    var facilityContentStack: UIStackView! // hrsnya Collection view   // baikla 👍
    
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
    var locationMapView = BoardingMapViewController()
    var locationContentStack: UIStackView!
    
    var facilityInfoStack: UIStackView!
    var cageSizeInfoStack: UIStackView!
    var policyInfoStack: UIStackView!
    var aboutInfoStack: UIStackView!
    var locationInfoStack: UIStackView!

    var infoDetailsStack: UIStackView!
    
    // CERITANYA LOADING ANJAAYYYZZ
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .customOrange
        spinner.backgroundColor = .clear
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.mainVc?.group.notify(queue: .main) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//                self.spinner.hidesWhenStopped = true
//                self.spinner.stopAnimating()
//                self.spinner.removeFromSuperview()
//                
//                self.setUpComponents()
//                self.setUpConstraint()
//            })
//        }
//        
//        setupLoadingScreen()
        
        self.setUpComponents()
        self.setUpConstraint()
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
//            infoDetailsStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32)
        ])
    }
    
    //MARK: Setup Content
    private func setUpFacilityInfo() {
        guard let mainVcViewModel = mainVc?.viewModel else { return }
        
        print("\n>> SLUG: \(mainVcViewModel.slug)")
        print("\n>> FACILITIES: \(mainVcViewModel.facilities)")
        print()
        
        // Set Title
        facilityTitleLabel = createTitleLabel("Fasilitas & Layanan")
          
        var allViewItems:[UIView] = []
        var leftViewItems:[UIView] = []
        var rightViewItems:[UIView] = []
        
        
        // Validate provided facilities
        if (mainVcViewModel.facilities.contains("Playground") || mainVcViewModel.facilities.contains("Tempat Bermain")) {
            let playground = createIconLabel("facility-playground-icon", "Tempat Bermain")
            allViewItems.append(playground)
        }
        if (mainVcViewModel.facilities.contains("AC") || mainVcViewModel.facilities.contains("Ruangan Ber-AC")) {
            let ac = createIconLabel("facility-ac-icon", "Ruangan ber-AC")
            allViewItems.append(ac)
        }
        if (mainVcViewModel.facilities.contains("CCTV")) {
            let cctv = createIconLabel("facility-cctv-icon", "CCTV")
            allViewItems.append(cctv)
        }
        
        // GANTI FACILITIES KE SERVICES
        if (mainVcViewModel.facilities.contains("Food") || mainVcViewModel.facilities.contains("Termasuk Makanan")) {
            let petFood = createIconLabel("facility-petFood-icon", "Termasuk Makanan")
            allViewItems.append(petFood)
        }
        if (mainVcViewModel.facilities.contains("Delivery") || mainVcViewModel.facilities.contains("Antar Jemput")) {
            let pickUp = createIconLabel("facility-pickUp-icon", "Jasa Antar Jemput")
            allViewItems.append(pickUp)
        }
        if (mainVcViewModel.facilities.contains("Grooming")) {
            let grooming = createIconLabel("facility-grooming-icon", "Termasuk Grooming")
            allViewItems.append(grooming)
        }
        if (mainVcViewModel.facilities.contains("Veterinary") || mainVcViewModel.facilities.contains("Tersedia Dokter Hewan")) {
            let vet = createIconLabel("facility-vet-icon", "Tersedia Dokter Hewan")
            allViewItems.append(vet)
        }
    
        print(">>>>>>")
        for item in allViewItems {
            print("facility item name:", item.layer.name)
        }
        
        // DIVIDE ITEMS TO LEFT & RIGHT VIEW
        if allViewItems.count > 0 {
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
            print(">> totFacility", totFacility)
            print(">> leftViewItems", leftViewItems.count)
            if allViewItems.count == 1 {
                leftViewItems.append(allViewItems[0])
            } else if allViewItems.count > 1 {
                for i in (centerIdx + 1)...(totFacility - 1) {
                    rightViewItems.append(allViewItems[i])
                }
            }
            
            // pop all items in allViewItems[]
            allViewItems.removeAll()
        }
        
         
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
        facilityContentStack.distribution  = UIStackView.Distribution.fill
        facilityContentStack.alignment = UIStackView.Alignment.firstBaseline
        
        // Wrap all
        facilityInfoStack = createInfoStack(facilityTitleLabel, content: facilityContentStack)
    }
    
    private func setUpCageSizeInfo() {
        guard let mainVcViewModel = mainVc?.viewModel else { return }
        
        // Set Title
        cageSizeTitleLabel = createTitleLabel("Ukuran Kandang")

        // Set Content
//        cageSmallLabel = createCageLabel("S", 35, 60, "cm")
        
        // MARK: "Z" cage name, optionals
        var labels = [UILabel]()
        for cage in mainVcViewModel.boardingCages {
            labels.append(
                createCageLabel(
                    String(cage.name.split(separator: " ").first ?? "Z"),
                    cage.width,
                    cage.length,
                    "cm"
                )
            )
        }
        
        cageSizeContentStack = UIStackView(arrangedSubviews: labels)
        cageSizeContentStack.translatesAutoresizingMaskIntoConstraints = false

        cageSizeContentStack.axis  = NSLayoutConstraint.Axis.vertical
        cageSizeContentStack.distribution  = UIStackView.Distribution.fill
        cageSizeContentStack.alignment = UIStackView.Alignment.leading
        cageSizeContentStack.spacing   = 8.0
        
        // Wrap all
        cageSizeInfoStack = createInfoStack(cageSizeTitleLabel, content: cageSizeContentStack)
    }
    
    private func setUpPolicyInfo() {
        guard let mainVcViewModel = mainVc?.viewModel else { return }
        
        var subViews = [UIStackView]()
        
        // Set Title
        policyTitleLabel = createTitleLabel("Kebijakan Pet Hotel")
        
        // Open hours
//        let startCheckIn = 22
//        let endCheckIn = 22
//        let startCheckOut = 22
//        let endCheckOut = 22
        let startCheckIn = mainVcViewModel.startCheckInTime
        let endCheckIn = mainVcViewModel.endCheckInTime
        let startCheckOut = mainVcViewModel.startCheckOutTime
        let endCheckOut = mainVcViewModel.endCheckOutTime
        
        let openHoursStack = createPolicyOpenHourContent(
            "policy-clock-icon",
            "Waktu Check In",
            "\(startCheckIn) - \(endCheckIn)",
            "\(startCheckOut) - \(endCheckOut)"
        )
        subViews.append(openHoursStack)
        
        // Vaccinated
        if mainVcViewModel.shouldHaveBeenVaccinated {
            let vaccinatedStack = createIconLabelWithTitle("policy-vaccine-icon", "Sudah Vaksin", "Anabul melakukan vaksin tahunan")
            subViews.append(vaccinatedStack)
        }
        
        // Age Range
        let minAge = mainVcViewModel.minimumAge
        let maxAge = Int(ceil(Double(mainVcViewModel.maximumAge / 12)))
        let ageRangeStack = createIconLabelWithTitle("policy-age-icon", "Usia Anabul", "Menerima anabul usia \(minAge) bulan - \(maxAge) tahun")
        subViews.append(ageRangeStack)
        
        // FleaFree
        if mainVcViewModel.shouldHaveToBeFleaFree {
            let fleaFreeStack = createIconLabelWithTitle("policy-clean-icon", "Bebas Kutu", "Anabul bebas dari kutu yang dapat menular")
            subViews.append(fleaFreeStack)
        }
        
//        policyContentStack = UIStackView(arrangedSubviews: [openHoursStack, vaccinatedStack, ageRangeStack, fleaFreeStack])
        policyContentStack = UIStackView(arrangedSubviews: subViews)
        policyContentStack.translatesAutoresizingMaskIntoConstraints = false

        policyContentStack.axis  = NSLayoutConstraint.Axis.vertical
        policyContentStack.distribution  = UIStackView.Distribution.fill
        policyContentStack.alignment = UIStackView.Alignment.fill
        policyContentStack.spacing   = 16.0
                
        // Wrap all
        policyInfoStack = createInfoStack(policyTitleLabel, content: policyContentStack)
    }
    
    private func setUpAboutInfo() {
        guard let mainVcViewModel = mainVc?.viewModel else { return }
        // Set Title
        aboutTitleLabel = createTitleLabel("Tentang")
        
        // Set Content
        let label = createDefaultLabel(mainVcViewModel.description)
        
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
//        guard let mainVc else { return }
        guard let mainVcViewModel = mainVc?.viewModel else { return }
        // Set Title
        locationTitleLabel = createTitleLabel("Lokasi")


        // Set Content - location address
        let label = createLocationLabel("\(mainVcViewModel.address), \(mainVcViewModel.provinceName)")
        
        locationInfoStack = UIStackView(arrangedSubviews: [locationMapView.view, label])
        locationInfoStack.translatesAutoresizingMaskIntoConstraints = false
        locationInfoStack.axis  = NSLayoutConstraint.Axis.vertical
        locationInfoStack.distribution  = UIStackView.Distribution.fill
        locationInfoStack.alignment = UIStackView.Alignment.fill
        locationInfoStack.spacing   = 16.0
        
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
                
        stackView.layer.name = text
        
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
        label.textColor = .textBlack
        label.textAlignment = .left
        
        return label
    }
    
    private func createDefaultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        label.text = "\(text)"
        label.textColor = .textBlack
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
        icon.tintColor = .customOrange
        icon.contentMode = .scaleAspectFit
        icon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return icon
    }
    
    // MARK: SETUP LOADING SCREEN
    func setupLoadingScreen() {
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        spinner.startAnimating()
    }
}
