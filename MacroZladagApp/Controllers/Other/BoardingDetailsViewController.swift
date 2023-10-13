//
//  BoardingDetailsViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 04/10/23.
//

import UIKit

class BoardingDetailsViewController: UIViewController {
    
    
    var photoPaths:[String] = []
    var photoIdx = 0
    
    let viewModel: BoardingsCellViewModel
    
    let infoSegment = SegmentedInfoViewController()

    init(viewModel: BoardingsCellViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil) // INI APA SIH
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // Content Scroll View
    var scrollview: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false // Enable auto layout
        scrollView.contentInsetAdjustmentBehavior = .never
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.backgroundColor = .customLightOrange
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)

        return scrollView

    }()
    
    // Photo Collection & Control
    var photoCollection: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 198)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isDirectionalLockEnabled = true
        
        // Pagination
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
//        collectionView.backgroundColor = .customGray2
        return collectionView
    }()
    
    var photosPageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.pageIndicatorTintColor = .customGray2
        control.currentPageIndicatorTintColor = .white
        control.backgroundColor = .clear
        control.contentVerticalAlignment = .bottom
        
        control.addTarget(BoardingDetailsViewController.self, action: #selector(photosPageControlValueChanged(_:)), for: .valueChanged)
        
        return control
    }()
    
    // Tag name
    lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        
        label.text = "\(viewModel.boardingCategoryName)"
        label.backgroundColor = .customGray
        //        label.textColor = .customGray3
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        
        return label
    }()
    
    // Place name as title
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "\(viewModel.name)"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        
        return label
    }()
    
    // Location info (distance, distict)
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "\(1.5) km dari lokasi・\(viewModel.subdistrictName), \(viewModel.districtName)"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .customGray3
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        
        return label
    }()
    
    // Rating Horizontal Stack
    lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.tintColor = .customOrange
        imageView.sizeToFit()
        return imageView
    }()
    lazy var ratingNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "\(viewModel.rating)"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .customOrange
        
        return label
    }()
    lazy var rateStackView: UIStackView = {
        let stackView   = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.firstBaseline
        stackView.spacing   = 2.0
        
        stackView.addArrangedSubview(ratingImageView)
        stackView.addArrangedSubview(ratingNumLabel)
        
        return stackView
    }()
    
    lazy var reviewerNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "(\(viewModel.numOfReviews) review)"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .customGray3
        
        return label
    }()
    
    lazy var rateReviewStackView: UIStackView = {
        let stackView   = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.firstBaseline
        stackView.spacing   = 4.0
        
        stackView.addArrangedSubview(rateStackView)
        stackView.addArrangedSubview(reviewerNumLabel)
        
        return stackView
    }()
    
    // Segmented Control
    lazy var infoSegmentedControlContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(infoSegmentedControl)
        containerView.addSubview(bottomUnderlineView)
        return containerView
    }()
    lazy var infoSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Info", "Review"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .clear
        
        segmentedControl.setTitleTextAttributes([
            .font: UIFont.systemFont(ofSize: 16, weight: .medium),
            .foregroundColor: UIColor.customGrayForIcons
        ], for: .normal)
        segmentedControl.setTitleTextAttributes([
            .foregroundColor: UIColor.black
        ], for: .selected)
        
        // Remove default gray color :')
        if #available(iOS 13.0, *){
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
                for i in 0 ... (segmentedControl.numberOfSegments-1) {
                    let bgSegmentView = segmentedControl.subviews[i]
                    bgSegmentView.isHidden = true
                }
            })
        }

        segmentedControl.addTarget(self, action: #selector(infoSegmentedControlValueChanged(_:)), for: .valueChanged)
        
        return segmentedControl
    }()
    
    lazy var bottomUnderlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = .customGray
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.addSubview(activeBottomUnderlineView)
        return underlineView
    }()
    lazy var activeBottomUnderlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = .customOrange
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        return underlineView
    }()
    lazy var leadingDistanceConstraint: NSLayoutConstraint = {
        return activeBottomUnderlineView.leftAnchor.constraint(equalTo: infoSegmentedControl.leftAnchor)
    }()
    
    // Segmented View Items
//    lazy var segmentedContainerView: UIView = {
//        let segmentedView = UIView()
//        segmentedView.translatesAutoresizingMaskIntoConstraints = false
//
////        let segmentedInfoView = SegmentedInfoView()
////        segmentedInfoView.frame = segmentedView.bounds
//
////        segmentedView.addSubview(segmentedReviewView)
//        segmentedView.backgroundColor = .customBlue
////        segmentedView.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
////        showSegmentedView(index: 0)
//
//        return segmentedView
//    }()
//
//    lazy var segmentedInfoView: SegmentedInfoView = {
//        let segmentedView = SegmentedInfoView()
//        segmentedView.frame = segmentedContainerView.bounds
//        return segmentedView
//    }()
//
//    lazy var segmentedReviewView: SegmentedReviewView = {
//        let segmentedView = SegmentedReviewView()
//        segmentedView.frame = segmentedContainerView.bounds
//        return segmentedView
//    }()
    
    // Select Service
    lazy var seletctServiceView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.backgroundColor = .white
        
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOffset = CGSize(width: 0, height: -4) // Adjust the shadow offset as needed
        uiView.layer.shadowRadius = 8 // Adjust the shadow radius as needed
        uiView.layer.shadowOpacity = 0.05 // Adjust the shadow opacity as needed
        
        uiView.addSubview(selectServiceStackView)
        uiView.bringSubviewToFront(scrollview)

        return uiView
    }()
    
    lazy var selectServiceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalCentering
        stackView.alignment = UIStackView.Alignment.center

        stackView.addArrangedSubview(priceInfoStackView)
        stackView.addArrangedSubview(selectServiceButton)
        return stackView
    }()
    
    lazy var priceInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing   = 4.0
        
        stackView.addArrangedSubview(priceTitleLabel)
        stackView.addArrangedSubview(priceStackView)
        return stackView
    }()
    
    
    lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mulai dari"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .customGray3
        return label
    }()
    
    lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.leading
//        stackView.spacing   = 4.0
        
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(priceMeasurementLabel)
        
        return stackView
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "IDR \(viewModel.price)"
        label.font = .systemFont(ofSize: 20, weight: .regular)

        return label
    }()
    lazy var priceMeasurementLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "per ekor per malam"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .customGray3
        return label
    }()
    
    lazy var selectServiceButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Pilih layanan", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .customOrange
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Controller Settings
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .white
        
        // Create the button
        let shareButton = UIBarButtonItem(image: UIImage(named: "share-icon"), style: .plain, target: self, action: #selector(shareButtonTapped))
        
        // Add the button to the right side of the navigation bar
        navigationItem.rightBarButtonItem = shareButton
        
        // View Settings
        view.backgroundColor = .white
        
        
        view.addSubview(scrollview)
        view.addSubview(seletctServiceView)
        
        scrollview.addSubview(photoCollection)
        scrollview.addSubview(photosPageControl)
        scrollview.addSubview(tagLabel)
        scrollview.addSubview(titleLabel)
        scrollview.addSubview(locationLabel)
        scrollview.addSubview(rateReviewStackView)
        scrollview.addSubview(infoSegmentedControlContainerView)
//        scrollview.addSubview(segmentedContainerView)
//        segmentedContainerView.backgroundColor = .red
        
        addInfoSegment()
        
        setupConstraints()
        configurePhotosCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK: Functions
    
    func addInfoSegment() {
        addChild(infoSegment)
        view.addSubview(infoSegment.view)
        infoSegment.view.backgroundColor = .yellow
        infoSegment.didMove(toParent: self)
    }
    
    func setupConstraints() {
        
        infoSegment.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // Scroll View
            scrollview.topAnchor.constraint(equalTo: view.topAnchor),
            scrollview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Photos Carousel
            photoCollection.topAnchor.constraint(equalTo: scrollview.topAnchor),
            photoCollection.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            photoCollection.heightAnchor.constraint(equalToConstant: 198),
            
            photosPageControl.bottomAnchor.constraint(equalTo: photoCollection.bottomAnchor, constant: 0),
            photosPageControl.leadingAnchor.constraint(equalTo: photoCollection.leadingAnchor, constant: 0),
            photosPageControl.trailingAnchor.constraint(equalTo: photoCollection.trailingAnchor, constant: 0),
            photosPageControl.centerXAnchor.constraint(equalTo: scrollview.centerXAnchor),
            
            // Header Content
            tagLabel.topAnchor.constraint(equalTo: photoCollection.bottomAnchor, constant: 20),
            tagLabel.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor, constant: 24),
            tagLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 75),
            tagLabel.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor, constant: -24),
            
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor, constant: 24),
            locationLabel.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor, constant: -24),
            
            rateReviewStackView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            rateReviewStackView.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor, constant: 24),
            
            // Segmented Control
            infoSegmentedControlContainerView.topAnchor.constraint(equalTo: rateReviewStackView.bottomAnchor, constant: 16),
            infoSegmentedControlContainerView.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            infoSegmentedControlContainerView.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
            infoSegmentedControlContainerView.heightAnchor.constraint(equalToConstant: 45),
            
            infoSegmentedControl.topAnchor.constraint(equalTo: infoSegmentedControlContainerView.topAnchor),
            infoSegmentedControl.leadingAnchor.constraint(equalTo: infoSegmentedControlContainerView.leadingAnchor),
            infoSegmentedControl.centerXAnchor.constraint(equalTo: infoSegmentedControlContainerView.centerXAnchor),
            infoSegmentedControl.centerYAnchor.constraint(equalTo: infoSegmentedControlContainerView.centerYAnchor),
            
            bottomUnderlineView.bottomAnchor.constraint(equalTo: infoSegmentedControl.bottomAnchor),
            bottomUnderlineView.heightAnchor.constraint(equalToConstant: 2),
            bottomUnderlineView.leadingAnchor.constraint(equalTo: infoSegmentedControlContainerView.leadingAnchor),
            bottomUnderlineView.trailingAnchor.constraint(equalTo: infoSegmentedControlContainerView.trailingAnchor),
            activeBottomUnderlineView.bottomAnchor.constraint(equalTo: infoSegmentedControl.bottomAnchor),
            activeBottomUnderlineView.heightAnchor.constraint(equalToConstant: 2),
            leadingDistanceConstraint,
            activeBottomUnderlineView.widthAnchor.constraint(equalTo: infoSegmentedControl.widthAnchor, multiplier: 1 / CGFloat(infoSegmentedControl.numberOfSegments)),
            
//            segmentedContainerView.topAnchor.constraint(equalTo: infoSegmentedControlContainerView.bottomAnchor, constant: 100),
//            segmentedContainerView.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
//            segmentedContainerView.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
//            segmentedContainerView.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
////            segmentedContainerView.widthAnchor.constraint(equalToConstant: 100),
//            segmentedContainerView.heightAnchor.constraint(equalToConstant: 900),

//            segmentedInfoView.topAnchor.constraint(equalTo: segmentedContainerView.topAnchor),
//            segmentedInfoView.bottomAnchor.constraint(equalTo: segmentedContainerView.bottomAnchor),
//            segmentedInfoView.leadingAnchor.constraint(equalTo: segmentedContainerView.leadingAnchor),
//            segmentedInfoView.trailingAnchor.constraint(equalTo: segmentedContainerView.trailingAnchor),
//
//            segmentedReviewView.topAnchor.constraint(equalTo: segmentedContainerView.topAnchor),
//            segmentedReviewView.bottomAnchor.constraint(equalTo: segmentedContainerView.bottomAnchor),
//            segmentedReviewView.leadingAnchor.constraint(equalTo: segmentedContainerView.leadingAnchor),
//            segmentedReviewView.trailingAnchor.constraint(equalTo: segmentedContainerView.trailingAnchor),
        
            

            infoSegment.view.topAnchor.constraint(equalTo: infoSegmentedControlContainerView.bottomAnchor, constant: 20),
            infoSegment.view.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor, constant: 0),
            infoSegment.view.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor, constant: 0),
            infoSegment.view.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor, constant: 0),
            
            
            
            
            // Bottom-fixed menu
            seletctServiceView.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor, constant: 0),
            seletctServiceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seletctServiceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            selectServiceStackView.topAnchor.constraint(equalTo: seletctServiceView.topAnchor, constant: 24),
            selectServiceStackView.bottomAnchor.constraint(equalTo: seletctServiceView.bottomAnchor, constant: -48),
            selectServiceStackView.leadingAnchor.constraint(equalTo: seletctServiceView.leadingAnchor, constant: 24),
            selectServiceStackView.trailingAnchor.constraint(equalTo: seletctServiceView.trailingAnchor, constant: -24),
            
            
            selectServiceButton.heightAnchor.constraint(equalToConstant: 40),
            selectServiceButton.widthAnchor.constraint(equalToConstant: 160),
        
        ])
        
        photoCollection.frame = view.bounds
//        segmentedContainerView.backgroundColor = .systemPink
    }
    
    func configurePhotosCollectionView(){
        photoCollection.dataSource = self
        photoCollection.delegate = self
        photoCollection.register(BoardingPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "boardingPhotoCollectionViewCell")
        photoCollection.alwaysBounceVertical = true
        photoCollection.backgroundColor = .customGray
        
        for _ in 0..<7 {
            photoPaths.append("banner\(Int.random(in: 0...4).description)")
        }
        photosPageControl.numberOfPages = photoPaths.count

        print(photoPaths)
    }
    
    func showSegmentedView(index: Int) {
        // Remove any previously displayed view
//        segmentedContainerView.subviews.forEach { $0.removeFromSuperview() }
//
//        if index == 0 {
//            segmentedContainerView.addSubview(infoSegmentedControl)
//        } else if index == 1 {
//            segmentedContainerView.addSubview(segmentedReviewView)
//        }
    }
    
    // Change position of the underline
    private func changeSegmentedControlLinePosition() {
        let segmentIndex = CGFloat(infoSegmentedControl.selectedSegmentIndex)
        let segmentWidth = infoSegmentedControl.frame.width / CGFloat(infoSegmentedControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.leadingDistanceConstraint.constant = leadingDistance
        })
    }
    
    
    
    
    // MARK: Action Handler Functions
    @objc func shareButtonTapped() {
        print("share button tapped")
    }
    
    @objc func photosPageControlValueChanged(_ sender: UIPageControl) {
        
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        print("indexpath: \(indexPath)")
        photoCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    @objc func infoSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Handle segmented control value changes
        let selectedIndex = sender.selectedSegmentIndex
        
        showSegmentedView(index: selectedIndex)
        print("Selected index: \(selectedIndex)")
        changeSegmentedControlLinePosition()

    }
}

// Collection view extension
extension BoardingDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        photosPageControl.currentPage = indexPath.row
        print(indexPath.row)
    }
    // Add this method to update the page control index when scrolling ends
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == photoCollection {
            let pageWidth = scrollView.frame.size.width
            let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
            photosPageControl.currentPage = currentPage
        }
    }
}
extension BoardingDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(photoPaths.count)
        return photoPaths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardingPhotoCollectionViewCell", for: indexPath) as? BoardingPhotoCollectionViewCell {
            
            let string = photoPaths[indexPath.row]
            cell.configure(with: string)
            
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}

//#Preview {
//    BoardingDetailsViewController()
//}
