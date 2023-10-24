//
//  SegmentedInfoView.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 12/10/23.
//

import UIKit

class SegmentedInfoView: UIView {

    var screenSize = UIScreen.main.bounds.size
    
    // Titles
    var facilitiesTitleLabel: UILabel {
        return createTitleLabel("Fasilitas & Layanan")
    }
    
    var cageSizeTitleLabel: UILabel {
        return createTitleLabel("Ukuran Kandang")
    }
    var termsTitleLabel: UILabel {
        return createTitleLabel("Kebijakan Pet Hotel")
    }
    var aboutTitleLabel: UILabel {
        return createTitleLabel("Tentang")
    }
    var locationTitleLabel: UILabel {
        return createTitleLabel("Lokasi")
    }
    
    // Facility content -> sesuai array
    var groomingLabel: UIStackView {
        return createFacilityLabelStack("", "Termasuk Grooming")
    }
    
    
    // Cage content
    var labelContent: UIStackView {
        let stackView = UIStackView(arrangedSubviews: [cageSmallLabel, cageMediumLabel, cageLargeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing   = 8.0

//        stackView.addSubview(cageSmallLabel)
//        stackView.addSubview(cageMediumLabel)
//        stackView.addSubview(cageLargeLabel)
        
        
//        self.addSubview(stackView)
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
//            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
//            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 24)
//        ])
        
        return stackView
    }
    var cageSmallLabel: UILabel {
        return createCageLabel("S", 30, 60, "cm")
    }
    var cageMediumLabel: UILabel {
        return createCageLabel("M", 40, 80, "cm")
    }
    var cageLargeLabel: UILabel {
        return createCageLabel("L", 50, 100, "cm")
    }
    
    // Term content
    
    // About content
    var aboutLabel: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        label.text = "Lorem ipsum dolor sit amet olor sit amet olor sit amet olor sit amet"
        label.textColor = .customGrayForIcons
        label.textAlignment = .left
        
        // enable text wrapping
        label.numberOfLines = 0
        
//        self.addSubview(label)
//        label.frame = CGRect(x: 0, y: 0, width: 200, height: 30)

//        NSLayoutConstraint.activate([
//            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
//            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
//            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 24)
//        ])
        return label
    }
    
    // Location content
    var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        label.text = "location address"
        label.textColor = .customGrayForIcons
        label.textAlignment = .left
        
        return label
    }()
    
    func createTitleLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        label.text = "\(text)"
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }
    
    func createFacilityLabelStack(_ iconName:String, _ text: String) -> UIStackView {
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
    
    func createCageLabel(_ size: String, _ width: Int, _ height: Int, _ metrics: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        label.text = "\(size.uppercased()) = \(width)\(metrics) x \(height)\(metrics)"
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }
    
//    init() {
//        super.init(frame: .zero)
//
//        backgroundColor = .customGray
////        layer.cornerRadius = 4
//
////        addSubview(labelContent)
//        addSubview(aboutLabel)
//        print("1")
////        addSubview(cageSizeTitleLabel)
////        print("2")
////        addSubview(termsTitleLabel)
////        print("3")
////        addSubview(aboutTitleLabel)
////        print("4")
////        addSubview(locationTitleLabel)
//
////        setUpConstraint()
////        addSubview()
//    }


//    required init?(coder: NSCoder) {
//        fatalError()
//    }
    
//    override func layoutSubviews() {
////        imageView.frame = CGRect(x: 10, y: 14, width: 16, height: 16)
//
////        if hasMapIcon != nil {
////            mapIcon.frame = CGRect(x: self.frame.width - 8 - 16, y: 14, width: 16, height: 16)
////        }
//        setUpConstraint()
//    }
    
    
    
    
    
    
    
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
////        addSubview(facilitiesTitleLabel)
//        self.frame = bounds
//        addSubview(labelContent)
//        addSubview(aboutLabel)
//
//        // Set up constraints for the scroll view
////        NSLayoutConstraint.activate([
////            facilitiesTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
////            facilitiesTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
////            facilitiesTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
////            facilitiesTitleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
////        ])
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init-override")
        setUpConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init-required")
        setUpConstraint()

    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        // Your layout code goes here
//        setUpConstraint()
//
//    }
    
    private func setUpConstraint() {
        print("segmented info")
        
        self.addSubview(aboutLabel)
        self.addSubview(labelContent)
        self.backgroundColor = .systemPink
        
        aboutLabel.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 60, height: 20))
        labelContent.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 60, height: 20))
//        facilitiesTitleLabel.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
//        facilitiesTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        facilitiesTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        facilitiesTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
//        NSLayoutConstraint.activate([
//            // Facility
//            facilitiesTitleLabel.topAnchor.constraint(equalTo: topAnchor),
//            facilitiesTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            facilitiesTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
//            facilitiesTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
//
//            // Facility
//            labelContent.topAnchor.constraint(equalTo: topAnchor, constant: 40),
//            labelContent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
//            labelContent.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
        
//        NSLayoutConstraint.activate([
//            // Facility
//            facilitiesTitleLabel.topAnchor.constraint(equalTo: topAnchor),
//            facilitiesTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            facilitiesTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
//            facilitiesTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
//
//            // Cage Size
//            cageSizeTitleLabel.topAnchor.constraint(equalTo: facilitiesTitleLabel.bottomAnchor),
//            cageSizeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            cageSizeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
//            cageSizeTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
//
//            // Terms
//            termsTitleLabel.topAnchor.constraint(equalTo: cageSizeTitleLabel.bottomAnchor),
//            termsTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            termsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
//            termsTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
//
//            // About
//            aboutTitleLabel.topAnchor.constraint(equalTo: termsTitleLabel.bottomAnchor),
//            aboutTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            aboutTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
//            aboutTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
//
//            // Location
//            locationTitleLabel.topAnchor.constraint(equalTo: aboutTitleLabel.bottomAnchor),
//            locationTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            locationTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
//            locationTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
//
//
//        ])
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

