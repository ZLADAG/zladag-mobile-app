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
//        contentView.backgroundColor = .white
        
//        contentView.addSubview(boardingImageView)
        setUpComponents()
        setUpConstraints()
        
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
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

//        contentView.addSubview(reviewerName)
//        contentView.addSubview(date)
//        contentView.addSubview(reviewerPhoto)
//        contentView.addSubview(reviewerInfoStack)
//        contentView.addSubview(reviewNote)
//        contentView.backgroundColor = .yellow

        
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            
        
            reviewerName.topAnchor.constraint(equalTo: reviewerInfoStack.topAnchor, constant: 0),
            reviewerName.leadingAnchor.constraint(equalTo: reviewerInfoStack.leadingAnchor, constant: 0),
            
            date.leadingAnchor.constraint(equalTo: reviewerInfoStack.leadingAnchor, constant: 0),
            
            reviewerPhoto.trailingAnchor.constraint(equalTo: reviewerInfoStack.trailingAnchor, constant: -16),
            
            reviewerInfoStack.topAnchor.constraint(equalTo: reviewContentStack.topAnchor, constant: 16),
            reviewerInfoStack.leadingAnchor.constraint(equalTo: reviewContentStack.leadingAnchor, constant: 16),
            reviewerInfoStack.trailingAnchor.constraint(equalTo: reviewContentStack.trailingAnchor, constant: -16),
            
            reviewNote.leadingAnchor.constraint(equalTo: reviewContentStack.leadingAnchor, constant: 16),
            reviewNote.trailingAnchor.constraint(equalTo: reviewContentStack.trailingAnchor, constant: -16),
            reviewNote.bottomAnchor.constraint(equalTo: reviewContentStack.bottomAnchor, constant: -16),
            
            reviewContentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            reviewContentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 100),
            reviewContentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
//            reviewContentStack.heightAnchor.constraint(equalToConstant: 1000),
            reviewContentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
        ])
    }
    
    func setUpContent() {
        reviewerPhoto = createReviewerPhoto("person.fill")
        reviewerName = createDefaultLabel("John Doe")
        date = createDateLabel("27 September 2023")
        reviewNote = createReviewLabel("Lorem ipsum dolor sit amet olor sit amet olor sit amet olor sit amet. Ipsum dolor sit amet olor sit amet olor sit amet olor sit amet")
        
        let stackView = UIStackView(arrangedSubviews: [reviewerName, date])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 4.0
//        stackView.backgroundColor = .purple
        
//        reviewContentStack = stackView
        reviewerInfoStack = UIStackView(arrangedSubviews: [stackView, reviewerPhoto])
        reviewerInfoStack.translatesAutoresizingMaskIntoConstraints = false
        reviewerInfoStack.axis  = NSLayoutConstraint.Axis.horizontal
        reviewerInfoStack.distribution  = UIStackView.Distribution.fillProportionally
        reviewerInfoStack.alignment = UIStackView.Alignment.center
        reviewerInfoStack.spacing   = 4.0
//        reviewerInfoStack.backgroundColor = .systemPink

        reviewContentStack = UIStackView(arrangedSubviews: [reviewerInfoStack, reviewNote])
        reviewContentStack.translatesAutoresizingMaskIntoConstraints = false
        reviewContentStack.axis  = NSLayoutConstraint.Axis.vertical
        reviewContentStack.distribution  = UIStackView.Distribution.fill
        reviewContentStack.alignment = UIStackView.Alignment.leading
        reviewContentStack.spacing   = 8.0
        reviewContentStack.layer.cornerRadius = 5.0
        reviewContentStack.layer.borderWidth = 1.0
        reviewContentStack.layer.borderColor = UIColor.customGray2.cgColor
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
//        label.backgroundColor = .orange
        return label
    }
    
    private func createDateLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .customGrayForIcons
//        label.backgroundColor = .black
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
    
    func configure(with imageURL: String) {
//        promoImageView.sd_setImage(with: URL(string: APICaller.shared.getRandomImageURL(id: Int.random(in: 0...3))))
        boardingImageView.image = UIImage(named: imageURL)
        
        contentView.addSubview(boardingImageView)
        
        NSLayoutConstraint.activate([
            boardingImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            boardingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            boardingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            boardingImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
        

    }
}
