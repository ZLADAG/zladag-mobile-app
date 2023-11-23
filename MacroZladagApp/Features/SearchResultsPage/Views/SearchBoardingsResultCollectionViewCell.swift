//
//  SearchBoardingsResultCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 04/10/23.
//

import UIKit
import SDWebImage

class SearchBoardingsResultCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchBoardingsResultCollectionViewCell"
    
    var facilities = [String]()
    var imageURLStrings = [String]()
    var viewModel: SearchBoardingViewModel? = nil
    weak var controllerDelegate: SearchResultsViewController?
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let imageCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIdx, _ in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(240),
                    heightDimension: .absolute(120)
                )
            )
            
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(242),
                    heightDimension: .absolute(120)
                ),
                subitem: item,
                count: 1
            )
            
            group.contentInsets.trailing = 2
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.groupPaging
            return section
        })
    )
    
    let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .customOrange
        return imageView
    }()
    
    let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "location-icon")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        return imageView
    }()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .gray
        
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    let titikLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = .gray
        label.text = "・"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19  , weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .textBlack
        return label
    }()
    
    let perEkorPerMalamLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .gray
        label.text = "per ekor per malam"
        return label
    }()
    
    let hScrollView = UIScrollView()
    let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        
        configureImageCell()
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(starImageView)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(locationImageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(titikLabel)
        contentView.addSubview(perEkorPerMalamLabel)
        contentView.addSubview(addressLabel)
        
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8

        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 1, height: 5)
        contentView.layer.shadowRadius = 2.0
        contentView.layer.shadowOpacity = 0.15
        contentView.layer.masksToBounds = false
    }
    
    func configureImageCell() {
        addSubview(imageCollectionView)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "imagecell")
        imageCollectionView.frame = bounds
        imageCollectionView.frame = CGRect(
            x: imageCollectionView.frame.minX,
            y: imageCollectionView.frame.minY,
            width: imageCollectionView.frame.width,
            height: 120
        )
        imageCollectionView.backgroundColor = .clear
        imageCollectionView.layer.cornerRadius = 8
        imageCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func configureScrollView() {
        contentView.addSubview(hScrollView)
        hScrollView.addSubview(containerView)
        
//        containerView.backgroundColor = .red
//        hScrollView.backgroundColor = .green
        
//        hScrollView.frame = CGRect(x: 16, y: imageView.bottom + 10, width: contentView.width, height: 23)
        hScrollView.frame = CGRect(x: 12, y: 120 + 10, width: contentView.width, height: 23)
        containerView.frame = CGRect(x: 0, y: 0, width: 2000, height: 23)
        
        var z = 0
        for facility in facilities[0..<Int(floor(CGFloat(Double(facilities.count) / 1.5)))] {
            let aView: UIView = {
                let aView = UIView()
                aView.backgroundColor = .facilityBlue
                
                let label = UILabel()
                label.text = facility
                label.textColor = .white
                label.font = .systemFont(ofSize: 12, weight: .regular)
                label.backgroundColor = .facilityBlue
                label.textAlignment = .center
                
                aView.addSubview(label)

                label.translatesAutoresizingMaskIntoConstraints = false
                
                label.centerXAnchor.constraint(equalTo: aView.centerXAnchor).isActive = true
                label.centerYAnchor.constraint(equalTo: aView.centerYAnchor).isActive = true
                label.widthAnchor.constraint(equalToConstant: 80).isActive = true
                label.heightAnchor.constraint(equalToConstant: 23).isActive = true
                
                aView.layer.masksToBounds = true
                aView.layer.cornerRadius = 4
                return aView
            }()
            
            hScrollView.addSubview(aView)
            

            aView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                aView.topAnchor.constraint(equalTo: hScrollView.topAnchor),
                aView.leadingAnchor.constraint(equalTo: hScrollView.leadingAnchor, constant: CGFloat((85 + 8) * z)),
                aView.widthAnchor.constraint(equalToConstant: 85),
                aView.heightAnchor.constraint(equalToConstant: 23),
            ])
            z += 1
        }
        hScrollView.layer.masksToBounds = true
        hScrollView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() { // dipanggil setiap component  view muncul
        super.layoutSubviews()
        
//        let leading: CGFloat = 16
        let leading: CGFloat = 12
        
        configureScrollView()
        
        nameLabel.frame = CGRect(x: leading, y: hScrollView.bottom + 10, width: contentView.width - 95, height: 19)
        
        starImageView.frame = CGRect(x: nameLabel.right, y: hScrollView.bottom + 11, width: 16, height: 16)
        ratingLabel.frame = CGRect(x: starImageView.right + 5, y: hScrollView.bottom + 11, width: contentView.width, height: 16)
        
        locationImageView.frame = CGRect(x: leading, y: nameLabel.bottom + 5, width: 16, height: 16)
        
        distanceLabel.sizeToFit()
        distanceLabel.frame = CGRect(x: locationImageView.right + 0.5, y: nameLabel.bottom + 5, width: distanceLabel.width, height: 15)
        titikLabel.frame = CGRect(x: distanceLabel.right - 3, y: nameLabel.bottom + 5, width: 15, height: 15)
        addressLabel.frame = CGRect(x: titikLabel.right + 2, y: nameLabel.bottom + 5, width: 200, height: 15)
        
        priceLabel.frame = CGRect(x: 0 - leading, y: addressLabel.bottom + 16, width: contentView.width, height: 21)
        perEkorPerMalamLabel.frame = CGRect(x: 0 - leading, y: priceLabel.bottom, width: contentView.width, height: 12)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        nameLabel.text = nil
        addressLabel.text = nil
    }
    
    func configure(with viewModel: SearchBoardingViewModel) {
        self.viewModel = viewModel
        imageURLStrings = viewModel.imageURLStrings
        facilities = viewModel.facilities
        nameLabel.text = viewModel.name
        distanceLabel.text = "\(viewModel.distance) dari lokasi"
        ratingLabel.attributedText = getRatingLabelAttributedString(rating: viewModel.rating, numOfReviews: viewModel.numOfReviews)
        addressLabel.text = "\(viewModel.subdistrictName), \(viewModel.provinceName)"
        
        priceLabel.text = Utils.getStringCurrencyFormatted(viewModel.price)
        
    }
    
    func getRatingLabelAttributedString(rating: Double, numOfReviews: Int) -> NSMutableAttributedString {
        let firstAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.customOrange
        ]
        
        let secondAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular),
            .foregroundColor: UIColor.customGrayForIcons
            
        ]
        
        let firstString = NSMutableAttributedString(string: "\(rating) ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "(\(numOfReviews))", attributes: secondAttributes)
        
        firstString.append(secondString)
        
        return firstString
    }
    
}

extension SearchBoardingsResultCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLStrings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagecell", for: indexPath)
//        cell.backgroundColor = .green
        cell.backgroundColor = .white
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: APICaller.shared.getImage(path: imageURLStrings[indexPath.row])))
        imageView.contentMode = .scaleAspectFill
        cell.addSubview(imageView)
        imageView.frame = cell.contentView.bounds
        return cell
    }
    
    
    // DISARANKAN UTK DIMATIKAN!!!!!!!
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel else { return }
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let vc = BoardingDetailsViewController(slug: viewModel.slug)
        vc.hidesBottomBarWhenPushed = true
        vc.navigationItem.largeTitleDisplayMode = .always
        vc.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.controllerDelegate?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


