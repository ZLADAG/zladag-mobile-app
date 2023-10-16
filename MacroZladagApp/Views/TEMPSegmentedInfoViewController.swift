//
//  TEMPSegmentedInfoViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 14/10/23.
//

import UIKit

class TEMPSegmentedInfoViewController: UIViewController {

    var screenSize = UIScreen.main.bounds.size

    // Titles
    var facilitiesTitleLabel: UILabel {
        let label = createTitleLabel("Fasilitas & Layanan")
        return label
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
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing   = 8.0

        stackView.backgroundColor = .magenta
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
    var test: UILabel!
    
    var aboutLabel: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        label.text = "Lorem ipsum dolor sit amet olor sit amet olor sit amet olor sit amet"
        label.textColor = .customGrayForIcons
        label.textAlignment = .left
        // enable text wrapping
        label.numberOfLines = 0
        label.backgroundColor = .brown
        
//        self.view.addSubview(label)
//        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
//        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
//        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
//        label.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 20)

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
        let label = UILabel(frame: CGRect(x: 0, y: 24, width: screenSize.width, height: 60))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        label.text = "\(text)"
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .customBlue
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.view.addSubview(facilitiesTitleLabel)
//        self.view.addSubview(facilitiesTitleLabel)
        
//        test = createTitleLabel("yow tess")
        test = UILabel()
        test.translatesAutoresizingMaskIntoConstraints = false
        test.font = .systemFont(ofSize: 14, weight: .medium)
        
        test.text = "Lorem ipsum dolor sit amet olor sit amet olor sit amet olor sit amet"
        test.textColor = .customGrayForIcons
        test.textAlignment = .left
        // enable text wrapping
        test.numberOfLines = 0
        test.backgroundColor = .brown
        
        
        let test2 = UILabel()
        test2.translatesAutoresizingMaskIntoConstraints = false
        test2.font = .systemFont(ofSize: 14, weight: .medium)
        
        test2.text = "Lorem ipsum dolor sit amet olor sit amet olor sit amet olor sit amet"
        test2.textColor = .customGrayForIcons
        test2.textAlignment = .left
        // enable text wrapping
        test2.numberOfLines = 0
        test2.backgroundColor = .blue
        
        
        self.view.addSubview(test)
        test.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        test.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        test.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        self.view.addSubview(test2)
        test2.topAnchor.constraint(equalTo: test.topAnchor, constant: 60).isActive = true
        test2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        test2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        
//        self.view.addSubview(aboutLabel)
//        self.view.addSubview(locationLabel)
//        self.view.addSubview(labelContent)
        self.view.backgroundColor = .green
        
        
//        labelContent.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: self.view.width, height: 20))
        
        
        
//        self.view.addConstraints([
//           // Facility
//            labelContent.topAnchor.constraint(equalTo: self.view.topAnchor),
//            labelContent.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            labelContent.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            labelContent.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//        ])
        
//        setUpConstraint()
    }
    
    
    private func setUpConstraint() {
        print("segmented info")

       
//        NSLayoutConstraint.activate([
//            // Facility
//            facilitiesTitleLabel.topAnchor.constraint(equalTo: view.topAnchor),
//            facilitiesTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            facilitiesTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            facilitiesTitleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            // Facility
//            labelContent.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
//            labelContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
//            labelContent.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
