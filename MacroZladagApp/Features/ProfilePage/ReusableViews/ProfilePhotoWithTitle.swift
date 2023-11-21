//
//  ProfilePhotoWithTitle.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 31/10/23.
//

import UIKit

class ProfilePhotoWithTitle: UIView {
    private var photoImage: UIImageView!
    private var nameTitleLabel: UILabel!
    private var nameDetailLabel: UILabel!
    private var ageLabel: UILabel!
    
    private var titleStack: UIStackView!
    private var detailStack: UIStackView!
    private var allContentStack: UIStackView!
    
    // MARK: Initialize Methods
    init(profileType: ProfileType, img: String, title: String, detailName: String?, age: Double?) {
        super.init(frame: .zero)
        setUpComponents(profileType, img, title, detailName, age)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: PUBLIC Functions
    func updateImage(imageName: String?) {
        self.photoImage = UIImageView(image: UIImage(named: imageName ?? "dummy-image"))
    }
    func updateNameTitleLabel(text: String) {
        self.nameTitleLabel.text = text
    }
    func updateNameDetailLabel(text: String) {
        self.nameDetailLabel.text = text
    }
    func updateAgeLabel(age: Double) {
        self.ageLabel.text = "\(age) bulan"
    }
    
    func getImage() -> UIImageView {
       return photoImage
    }
    func getNameTitleLabel() -> UILabel {
        return nameTitleLabel
    }
    func getNameDetailLabel() -> UILabel {
        return nameDetailLabel
    }
    func getAgeLabel() -> UILabel {
        return ageLabel
    }
    
    
    // MARK: PRIVATE Functions
    private func setUpComponents(_ profileType: ProfileType,_ img: String, _ title: String, _ detailName: String?, _ age: Double?) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        photoImage = createPhotoView(img)
        
        var stack: UIStackView!
        switch profileType {
        case .pet:
            stack = createPetProfile(title, detailName!, age!)
            break
        default:
            stack = createUserProfile(title)
            break
        }
        
        allContentStack = UIStackView(arrangedSubviews: [photoImage, stack])
        allContentStack.translatesAutoresizingMaskIntoConstraints = false
        allContentStack.axis  = NSLayoutConstraint.Axis.horizontal
        allContentStack.distribution  = UIStackView.Distribution.fill
        allContentStack.alignment = UIStackView.Alignment.center
        allContentStack.spacing   = 12.0
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        self.addSubview(allContentStack)
        
        NSLayoutConstraint.activate([
            photoImage.heightAnchor.constraint(equalToConstant: 48),
            photoImage.widthAnchor.constraint(equalToConstant: 48),
            
            allContentStack.heightAnchor.constraint(equalToConstant: 48),
            allContentStack.topAnchor.constraint(equalTo: self.topAnchor),
            allContentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            allContentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            allContentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    private func createUserProfile(_ title: String) -> UIStackView {
        nameTitleLabel = createTitleBoldLabel(title)
        
        let stack = UIStackView(arrangedSubviews: [nameTitleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.vertical
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing   = 4.0
        
        return stack
    }
  
    private func createPetProfile(_ title: String, _ detail: String, _ age: Double) -> UIStackView {
        nameTitleLabel = createTitleSemiBoldLabel(title)
        detailStack = createDetailStack(detail, age)
        
        let stack = UIStackView(arrangedSubviews: [nameTitleLabel, detailStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.vertical
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.leading
        stack.spacing   = 4.0
        
        return stack
    }
    private func createPhotoView(_ imgName:String) -> UIImageView {
        let dimension: CGFloat = 48.0 // The desired dimension for the square UIImageView

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.image = UIImage(named: imgName)
        
        imageView.backgroundColor = .purple
//        imageView.frame.size = CGSize(width: 24, height: 24)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = dimension / 2
        imageView.layer.backgroundColor = UIColor.white.cgColor
        
        imageView.clipsToBounds = true
        return imageView
    }
    
    private func createDetailStack(_ detail: String, _ age: Double) -> UIStackView {
        nameDetailLabel = createDefaultLabel(detail)
        ageLabel = createDefaultLabel("\(age) tahun")
        let dividerLabel = createDefaultLabel("·")
        
        let stack = UIStackView(arrangedSubviews: [nameDetailLabel, dividerLabel, ageLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.horizontal
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.leading
        stack.spacing   = 8.0
        
        return stack
    }
    private func createTitleBoldLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }
    private func createTitleSemiBoldLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }
    private func createDefaultLabel(_ text: String) -> UILabel {
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
