//
//  MyPetTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 08/11/23.
//

import UIKit

class MyPetTableViewCell: UITableViewCell {
    
    static let identifier = "MyPetTableViewCell"
    
    let petImageView = UIImageView() // if nil: cat-icon || dog-icon
    let nameLabel = UILabel()
    var subDetailLabel = UIStackView()
    var breedLabel = UILabel()
    var ageLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
        selectionStyle = .none
        backgroundColor = .white
        
    }
    
    func configure(petDetails: PetDetailsViewModel) {
        nameLabel.text = petDetails.name.capitalized
        breedLabel.text = "\(petDetails.name.capitalized)  ·  \(petDetails.age) tahun"
        
        setupPetImageView()
        setupNameLabel()
        setupBreedLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        breedLabel.frame = .zero
        ageLabel.frame = .zero
        subDetailLabel.frame = .zero
    }
    
    func configure2(petDetails: PetDetailsViewModel) {
        nameLabel.text = petDetails.name.capitalized
        
        setupPetImageView()
        setupNameLabel()
        setupSubDetailLabel(petDetails: petDetails)
    }
    
    
    func setupPetImageView() {
        addSubview(petImageView)
        
        petImageView.image = UIImage(named: "banner0")
        petImageView.contentMode = .scaleAspectFill
        petImageView.frame.size = CGSize(width: 48, height: 48)
        petImageView.layer.cornerRadius = petImageView.width / 2
        petImageView.layer.masksToBounds = true
        
        petImageView.frame.origin = CGPoint(x: 24, y: 12)
    }
    
    func setupSubDetailLabel(petDetails: PetDetailsViewModel) {
        
        subDetailLabel = createDetailStack(petDetails.petBreed, petDetails.age)
        subDetailLabel.backgroundColor = .red
        addSubview(subDetailLabel)

        subDetailLabel.frame.origin = CGPoint(x: petImageView.right + 12, y: nameLabel.bottom + 4)
//        subDetailLabel.frame = CGRect(x: 100, y: 30, width: 200, height: 40)
    }
    
    func setupNameLabel() {
        addSubview(nameLabel)
        
        nameLabel.sizeToFit()
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .textBlack
        
        nameLabel.setContentHuggingPriority(.required, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        nameLabel.frame.origin = CGPoint(x: petImageView.right + 12, y: petImageView.top + 2)
        
    }
    
    func setupBreedLabel() {
        addSubview(breedLabel)
        
        breedLabel.sizeToFit()
        breedLabel.font = .systemFont(ofSize: 14, weight: .medium)
        breedLabel.textColor = .customLightGray
        
        breedLabel.frame.origin = CGPoint(x: petImageView.right + 12, y: nameLabel.bottom + 4)
    }
    
    func setupAgeLabel() {
        addSubview(ageLabel)
        
        let dotSeparator = UILabel()
        addSubview(dotSeparator)
        dotSeparator.text = "·"
        dotSeparator.backgroundColor = .red
        dotSeparator.sizeToFit()
        dotSeparator.textColor = .customLightGray
        dotSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dotSeparator.leadingAnchor.constraint(equalTo: breedLabel.trailingAnchor, constant: 8),
            dotSeparator.centerYAnchor.constraint(equalTo: breedLabel.centerYAnchor),
            dotSeparator.widthAnchor.constraint(equalToConstant: dotSeparator.width),
            dotSeparator.heightAnchor.constraint(equalToConstant: dotSeparator.height),
        ])
        
        ageLabel.font = .systemFont(ofSize: 14, weight: .medium)
        ageLabel.textColor = .customLightGray
        ageLabel.sizeToFit()
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ageLabel.topAnchor.constraint(equalTo: breedLabel.topAnchor),
            ageLabel.leadingAnchor.constraint(equalTo: dotSeparator.leadingAnchor, constant: 8),
            ageLabel.widthAnchor.constraint(equalToConstant: ageLabel.width),
            ageLabel.heightAnchor.constraint(equalToConstant: ageLabel.height),
        ])
        
        
    }
    
    func createDetailStack(_ detail: String, _ age: Int) -> UIStackView {
        
        breedLabel = createDefaultLabel(detail.capitalized)
        breedLabel.sizeToFit()
        
        ageLabel = createDefaultLabel("\(age) tahun")
        ageLabel.sizeToFit()
        
        var dividerLabel = createDefaultLabel("·")
        dividerLabel.sizeToFit()
        
        print(">>> \(breedLabel.height), \(ageLabel.height)\n")
        
        var stack = UIStackView(arrangedSubviews: [breedLabel, dividerLabel, ageLabel])
//        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.horizontal
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.leading
        stack.spacing   = 8.0
        stack.frame.size = CGSize(
            width: breedLabel.width + ageLabel.width + dividerLabel.width + 16,
            height: breedLabel.height
        )
        
        return stack
    }
    
    func createDefaultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        /// wrap label fit text length
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = text
        label.textColor = .systemGray2
        label.numberOfLines = 0
        return label
    }

}
