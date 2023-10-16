//
//  ReviewCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 14/10/23.
//

import UIKit

class BoardingReviewCollectionViewCell: UICollectionViewCell {
    static let identifier = "boardingReviewCollectionViewCell"
    
    let boardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banner0")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var reviewerPhoto: UIImageView!
    var reviewerName: UILabel!
    var date: UILabel!
    var reviewNote: UILabel!
    
    var reviewerInfoStack: UIStackView!
    var reviewContentStack: UIStackView!
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        contentView.addSubview(boardingImageView)
        setUpComponents()
        setUpConstraints()
        
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
//        contentView.frame.width =
//        contentView.layer.cornerRadius = 8
//        contentView.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 800)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() { // dipanggil setiap component  view muncul
        super.layoutSubviews()
        
//        boardingImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 198)
//        reviewContentStack.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 800)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        boardingImageView.image = nil
        reviewerPhoto.image = nil
    }
    
    
    
    func setUpComponents(){
        setUpContent()
        contentView.addSubview(reviewContentStack)
        
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.customGray2.cgColor

        
    }
    
    func setUpConstraints(){
        
        NSLayoutConstraint.activate([
            // set width = screenwidth - (padding left + right)
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - (24 + 24))
            
        ])
            
        NSLayoutConstraint.activate([
            reviewContentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            reviewContentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            reviewContentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            reviewContentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
        ])

    }
    
    func setUpContent() {
        reviewerPhoto = createReviewerPhoto("person.fill")
        reviewerName = createDefaultLabel("John Doe")
        date = createDateLabel("27 September 2023")
        reviewNote = createReviewLabel("Lorem ipsum dolor sit amet olor sit amet olor sit amet olor sit amet. Ipsum dolor sit amet olor sit amet olor sit amet olor sit amet.")
        
        let stackView = UIStackView(arrangedSubviews: [reviewerName, date])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 4.0
        
        reviewerInfoStack = UIStackView(arrangedSubviews: [stackView, reviewerPhoto])
        reviewerInfoStack.translatesAutoresizingMaskIntoConstraints = false
        reviewerInfoStack.axis  = NSLayoutConstraint.Axis.horizontal
        reviewerInfoStack.distribution  = UIStackView.Distribution.fillProportionally
        reviewerInfoStack.alignment = UIStackView.Alignment.center
        reviewerInfoStack.spacing   = 4.0

        reviewContentStack = UIStackView(arrangedSubviews: [reviewerInfoStack, reviewNote])
        reviewContentStack.translatesAutoresizingMaskIntoConstraints = false
        reviewContentStack.axis  = NSLayoutConstraint.Axis.vertical
        reviewContentStack.distribution  = UIStackView.Distribution.fill
        reviewContentStack.alignment = UIStackView.Alignment.fill
        reviewContentStack.spacing   = 8.0
        
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
    
    private func createDateLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .customGrayForIcons

        return label
    }
    private func createReviewLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        
        return label
    }
    
    private func createReviewerPhoto(_ imageName: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "\(imageName)")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .customGray2
        return imageView
    }
    
    func configure() {
//    func configure(with imageURL: String) {
//        promoImageView.sd_setImage(with: URL(string: APICaller.shared.getRandomImageURL(id: Int.random(in: 0...3))))
//        boardingImageView.image = UIImage(named: imageURL)
//        contentView.addSubview(boardingImageView)
        
//        reviewerPhoto.image = UIImage(systemName: "person")
        
        setUpConstraints()
        

    }
}
