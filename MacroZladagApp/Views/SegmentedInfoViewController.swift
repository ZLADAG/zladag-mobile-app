//
//  SegmentedInfoViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 13/10/23.
//

import UIKit

class SegmentedInfoViewController: UIViewController {

    var screenSize = UIScreen.main.bounds.size

    // Titles
    var facilityTitleLabel: UILabel!
    var cageSizeTitleLabel: UILabel!
    var termsTitleLabel: UILabel!
    var aboutTitleLabel: UILabel!
    var locationTitleLabel: UILabel!
    
    // Facility content -> sesuai array
    var facilityContentStack: UIStackView! // hrsnya Collection view
    
    // Cage content
    var cageSizeContentStack: UIStackView!
    var cageSmallLabel: UILabel!
    var cageMediumLabel: UILabel!
    var cageLargeLabel: UILabel!
    
    // Term content
    var termsContentStack: UIStackView! // hrsnya Collection view
    
    // About content
    var aboutContentLabel: UILabel!
    
    // Location content
//    var locationMapView:
    var locationContentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpComponents()
        setUpConstraint()
    }
    
    //MARK: Setup components
    private func setUpComponents() {
        
        setUpFacilityContent()
        setUpCageSizeContent()
        setUpTermsContent()
        setUpAboutContent()
        setUpLocationContent()
        
        self.view.addSubview(facilityTitleLabel)
//        self.view.addSubview(facilityContentStack)
        
        self.view.addSubview(cageSizeTitleLabel)
        self.view.addSubview(cageSizeContentStack)
        
        self.view.addSubview(termsTitleLabel)
//        self.view.addSubview(termsContentStack)
        
        self.view.addSubview(aboutTitleLabel)
        self.view.addSubview(aboutContentLabel)
        
        self.view.addSubview(locationTitleLabel)
        self.view.addSubview(locationContentLabel)
    }
    
    //MARK: Setup constraints
    private func setUpConstraint() {
        // Facility
        NSLayoutConstraint.activate([
            facilityTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32),
            facilityTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            facilityTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([])
        
        // Cage Size
        NSLayoutConstraint.activate([
            cageSizeTitleLabel.topAnchor.constraint(equalTo: facilityTitleLabel.bottomAnchor, constant: 32),
            cageSizeTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            cageSizeTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            cageSizeContentStack.topAnchor.constraint(equalTo: cageSizeTitleLabel.bottomAnchor, constant: 16),
            cageSizeContentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            cageSizeContentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
        ])
        
        //Terms
        NSLayoutConstraint.activate([
            termsTitleLabel.topAnchor.constraint(equalTo: cageSizeContentStack.bottomAnchor, constant: 32),
            termsTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            termsTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([])
        
        // About
        NSLayoutConstraint.activate([
            aboutTitleLabel.topAnchor.constraint(equalTo: termsTitleLabel.bottomAnchor, constant: 32),
            aboutTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            aboutTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            aboutContentLabel.topAnchor.constraint(equalTo: aboutTitleLabel.bottomAnchor, constant: 16),
            aboutContentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            aboutContentLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
        ])
        
        // Location
        NSLayoutConstraint.activate([
            locationTitleLabel.topAnchor.constraint(equalTo: aboutContentLabel.bottomAnchor, constant: 32),
            locationTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            locationTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([])
        NSLayoutConstraint.activate([
            locationContentLabel.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor, constant: 16),
            locationContentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            locationContentLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
        ])
        
    
    }
    
    //MARK: Setup Content
    private func setUpFacilityContent() {
        // Set Title
        facilityTitleLabel = createTitleLabel("Fasilitas & Layanan")
        
        // Set Content
//        facilityContentStack =
    }
    
    private func setUpCageSizeContent() {
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
    }
    
    private func setUpTermsContent() {
        // Set Title
        termsTitleLabel = createTitleLabel("Kebijakan Pet Hotel")
    }
    
    private func setUpAboutContent() {
        // Set Title
        aboutTitleLabel = createTitleLabel("Tentang")
        
        // Set Content
        aboutContentLabel = createDefaultLabel("Lorem ipsum dolor sit amet olor sit amet olor sit amet olor sit amet")
    }
    
    private func setUpLocationContent() {
        // Set Title
        locationTitleLabel = createTitleLabel("Lokasi")

        // Set Content - map view

        // Set Content - location address
        locationContentLabel = createLocationLabel("Jl. Alamat pet hotelnya")
    }
    
    //MARK: Creation Stacks
    // Stack view
    private func createIconLabel(_ iconName:String, _ text: String) -> UIStackView {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: iconName)
        icon.contentMode = .scaleAspectFill
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        label.text = "\(text)"
        label.textColor = .black
        label.textAlignment = .left
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.firstBaseline
        stackView.spacing   = 8.0
        
        stackView.addSubview(icon)
        stackView.addSubview(label)
        
        return stackView
    }
    
    private func createIconLabelWithTitle(_ iconName:String, _ title: String, _ text: String) -> UIStackView {
    
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        titleLabel.text = "\(text)"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        label.text = "\(text)"
        label.textColor = .black
        label.textAlignment = .left
        
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: iconName)
        icon.contentMode = .scaleAspectFill
        
        let labelStackView = UIStackView()
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis  = NSLayoutConstraint.Axis.vertical
        labelStackView.distribution  = UIStackView.Distribution.fill
        labelStackView.alignment = UIStackView.Alignment.leading
        labelStackView.spacing   = 8.0
        
        labelStackView.addSubview(titleLabel)
        labelStackView.addSubview(label)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.top
        stackView.spacing   = 8.0
        
        stackView.addSubview(icon)
        stackView.addSubview(labelStackView)
        
        return stackView
    }
    
    private func createOpenHoursInfo() {
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
