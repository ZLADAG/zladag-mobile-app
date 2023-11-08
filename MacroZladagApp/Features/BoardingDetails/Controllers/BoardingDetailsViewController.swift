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
    
    var viewModel: BoardingDetailsViewModel?
    
    let infoSegment = SegmentedInfoViewController()
    let reviewSegment = SegmentedReviewViewController()
    
    var group: DispatchGroup

    init(group: DispatchGroup) {
        self.group = group
        super.init(nibName: nil, bundle: nil)

        self.infoSegment.mainVc = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // Content Scroll View
    var scrollview: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false // Enable auto layout
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        return scrollView

    }()
    
    // Photo Collection & Control
    var photoCollection: UICollectionView!
    var photosPageControl: UIPageControl!

    var headerStack: UIStackView!
    
    var tagLabel: UILabel!
    var titleLabel: UILabel!
    var locationLabel: UILabel!
    
    var ratingIcon: UIImageView!
    var ratingNumLabel: UILabel!
    var reviewerNumLabel: UILabel!
    var rateReviewStackView: UIStackView!
    
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
    lazy var segmentedContainerView: UIView = {
        let segmentedView = UIView()
        segmentedView.translatesAutoresizingMaskIntoConstraints = false
        segmentedView.backgroundColor = .customBlue

        return segmentedView
    }()
    
    // Select Service
    lazy var selectServiceView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.backgroundColor = .white
        
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOffset = CGSize(width: 0, height: -4) // Adjust the shadow offset as needed
        uiView.layer.shadowRadius = 8 // Adjust the shadow radius as needed
        uiView.layer.shadowOpacity = 0.05 // Adjust the shadow opacity as needed
        
        uiView.addSubview(selectServiceStackView)
//        uiView.bringSubviewToFront(scrollview)

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
        label.text = Utils.getStringCurrencyFormatted(viewModel?.price ?? 99)
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
        
        button.addTarget(self, action: #selector(selectServiceButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Controller Settings
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .customOrange
        navigationController?.navigationBar.barStyle = .default

        navigationController?.navigationBar.isTranslucent = true
        
        // Create the button
        let shareButton = UIBarButtonItem(image: UIImage(named: "share-icon"), style: .plain, target: self, action: #selector(shareButtonTapped))
        
        // Add the button to the right side of the navigation bar
        navigationItem.rightBarButtonItem = shareButton
    
        
        // View Settings
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        
        view.addSubview(scrollview)
        setUpPhotos()
        setUpHeader()
        
        scrollview.addSubview(infoSegmentedControlContainerView)
        
//        scrollview.addSubview(segmentedContainerView)

        
        addReviewSegmentView()
        reviewSegment.view.isHidden = true
        addInfoSegmentView()
        
        view.addSubview(selectServiceView)
        
        setupConstraints()
        
        scrollview.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK: Functions
    
    func addInfoSegmentView() {
        addChild(infoSegment)
        scrollview.addSubview(infoSegment.view)
//        infoSegment.view.backgroundColor = .yellow
        infoSegment.didMove(toParent: self)
//        var contentAboveHeight: CGFloat = 0

//        for subview in infoSegment.view.subviews. {
//            contentAboveHeight += subview.frame.height
//        }
//        let contentAboveHeight = scrollView.subviews
//                    .filter { $0.frame.maxY < infoSegmentedControlContainerView.frame.minY }
//                       .map { $0.frame.height }
//                       .reduce(0, +)
//        print("contentAboveHeight - INFO: \(contentAboveHeight)")

    }
    
    func addReviewSegmentView() {
        addChild(reviewSegment)
        scrollview.addSubview(reviewSegment.view)
//        reviewSegment.view.backgroundColor = .green
        reviewSegment.didMove(toParent: self)
//        var contentAboveHeight: CGFloat = 0
//
//        for subview in infoSegment.view.subviews {
//            contentAboveHeight += subview.frame.height
//        }
//
//        print("contentAboveHeight - REVIEW: \(contentAboveHeight)")
        
    }
    
    func setupConstraints() {
        
        // Bottom-fixed menu
        NSLayoutConstraint.activate([
            selectServiceView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            selectServiceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectServiceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            selectServiceStackView.topAnchor.constraint(equalTo: selectServiceView.topAnchor, constant: 24),
            selectServiceStackView.bottomAnchor.constraint(equalTo: selectServiceView.bottomAnchor, constant: -48),
            selectServiceStackView.leadingAnchor.constraint(equalTo: selectServiceView.leadingAnchor, constant: 24),
            selectServiceStackView.trailingAnchor.constraint(equalTo: selectServiceView.trailingAnchor, constant: -24),
                        
            selectServiceButton.heightAnchor.constraint(equalToConstant: 40),
            selectServiceButton.widthAnchor.constraint(equalToConstant: 160),

        ])
        
        // Scroll view
        NSLayoutConstraint.activate([
            scrollview.topAnchor.constraint(equalTo: view.topAnchor),
            scrollview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollview.bottomAnchor.constraint(equalTo: selectServiceView.topAnchor, constant: 0),
        ])
        
        // Photos Carousel
        NSLayoutConstraint.activate([
            photoCollection.topAnchor.constraint(equalTo: scrollview.topAnchor),
            photoCollection.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            photoCollection.heightAnchor.constraint(equalToConstant: 198),
            
            photosPageControl.bottomAnchor.constraint(equalTo: photoCollection.bottomAnchor, constant: 0),
            photosPageControl.leadingAnchor.constraint(equalTo: photoCollection.leadingAnchor, constant: 0),
            photosPageControl.trailingAnchor.constraint(equalTo: photoCollection.trailingAnchor, constant: 0),
            photosPageControl.centerXAnchor.constraint(equalTo: scrollview.centerXAnchor),
        ])
        photoCollection.frame = view.bounds
        photoCollection.backgroundColor = .yellow
        
        // Header Content
        NSLayoutConstraint.activate([

            tagLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 75),
            tagLabel.heightAnchor.constraint(equalToConstant: 20),
            
            headerStack.topAnchor.constraint(equalTo: photoCollection.bottomAnchor, constant: 20),
            headerStack.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor, constant: 24),
            headerStack.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor, constant: -24),
        ])

        // Segmented Control
        NSLayoutConstraint.activate([
            infoSegmentedControlContainerView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 16),
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
        ])

        //Segmented Content - Info
//        let segmentedContentHeight = max(infoSegment.infoDetailsStack.height, reviewSegment.screenSize.height)
        print("infoSegment.infoDetailsStack.height: \(infoSegment.view.height)")

        infoSegment.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoSegment.view.topAnchor.constraint(equalTo: infoSegmentedControlContainerView.bottomAnchor, constant: 0),
            infoSegment.view.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor, constant: 0),
            infoSegment.view.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor, constant: 0),
            infoSegment.view.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor, constant: 0),
            infoSegment.view.heightAnchor.constraint(equalToConstant: 1100)
        ])


        //Segmented Content - Review
        reviewSegment.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewSegment.view.topAnchor.constraint(equalTo: infoSegmentedControlContainerView.bottomAnchor, constant: 0),
            reviewSegment.view.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor, constant: 0),
            reviewSegment.view.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor, constant: 0),
            reviewSegment.view.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            reviewSegment.view.heightAnchor.constraint(equalToConstant: 1100)
        ])
    }
    
    func configurePhotosCollectionView(){
        guard let images = viewModel?.images else { return }
        photoCollection.dataSource = self
        photoCollection.delegate = self
        photoCollection.register(BoardingPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "boardingPhotoCollectionViewCell")
        photoCollection.alwaysBounceVertical = true
        photoCollection.backgroundColor = .customGray
        
        photoPaths = images
        photosPageControl.numberOfPages = photoPaths.count

        // DEBUG
//        print("photoPaths: \(photoPaths)")
    }
    
    func showSegmentedView(index: Int) {
        // Remove any previously displayed view
        segmentedContainerView.subviews.forEach { $0.removeFromSuperview() }
//
        if index == 0 {
            addInfoSegmentView()
            infoSegment.view.heightAnchor.constraint(equalToConstant: infoSegment.view.height).isActive = true

            infoSegment.view.isHidden = false
            reviewSegment.view.isHidden = true
//            segmentedContainerView.addSubview(infoSegment.view)

            
        } else if index == 1 {
            addReviewSegmentView()
            reviewSegment.view.heightAnchor.constraint(equalToConstant: reviewSegment.view.height).isActive = true

            reviewSegment.view.isHidden = false
            infoSegment.view.isHidden = true
//            segmentedContainerView.addSubview(reviewSegment.view)
        }
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        // This method will be called as the user scrolls the scrollview
//        // You can add your custom behavior here based on the scrolling offset
//
//        let yOffset = scrollView.contentOffset.y
//
//        // You can adjust this value as needed to control when the segmented view sticks
//        let threshold: CGFloat = 100
//
//        if yOffset > threshold {
//            // Stick the segmented view under the navigation bar
//            infoSegmentedControlContainerView.topAnchor.constraint(equalTo: rateReviewStackView.bottomAnchor, constant: yOffset - threshold).isActive = true
//        } else {
//            // Keep the segmented view at its original position
////            segmentedViewTopConstraint.constant = 0
//            infoSegmentedControlContainerView.topAnchor.constraint(equalTo: rateReviewStackView.bottomAnchor, constant: 16).isActive = true
//        }
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           // This method will be called as the user scrolls the scrollview
           // You can add your custom behavior here based on the scrolling offset
   
           let yOffset = scrollView.contentOffset.y
//           let contentAboveHeight = scrollView.subviews
//            .filter { $0.frame.maxY < infoSegmentedControlContainerView.frame.minY }
//               .map { $0.frame.height }
//               .reduce(0, +)
   
            var contentAboveHeight: CGFloat = 0

            for subview in scrollView.subviews {
                if subview.frame.maxY < infoSegmentedControlContainerView.frame.minY {
                    contentAboveHeight += subview.frame.height
                }
            }

           // You can adjust this value as needed to control when the segmented view sticks
           let threshold: CGFloat = contentAboveHeight - 40
    
//           print("height:\(contentAboveHeight)")
   
           if yOffset > threshold {
               // Stick the segmented view under the navigation bar
               //            segmentedBarTopConstraint.constant = yOffset - threshold
               scrollview.topAnchor.constraint(equalTo: view.bottomAnchor, constant: yOffset - threshold).isActive = true
               //            infoSegmentedControlContainerView.topAnchor.constraint(equalTo: rateReviewStackView.bottomAnchor, constant: yOffset - threshold).isActive = true
           } else {
               // Keep the segmented view at its original position
               //            segmentedBarTopConstraint.constant = 0
               scrollview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
               //            infoSegmentedControlContainerView.topAnchor.constraint(equalTo: rateReviewStackView.bottomAnchor, constant: 16).isActive = true
           }
       }
    
    
    /// Change position of the underline
    private func changeSegmentedControlLinePosition() {
        let segmentIndex = CGFloat(infoSegmentedControl.selectedSegmentIndex)
        let segmentWidth = infoSegmentedControl.frame.width / CGFloat(infoSegmentedControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.leadingDistanceConstraint.constant = leadingDistance
        })
    }
    
    private func presentOpenUrlAlert(_ title: String, _ message: String, _ urlAddress: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        // Cancel action
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .destructive,
            handler: nil
        )
        alertController.addAction(cancelAction)
        
        
        // OK Acrion
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { (action) in
                // Handle the "Open Website" button tap
                self.openUrl("https://www.google.com")
            }
        )
        alertController.addAction(okAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    private func openUrl(_ urlAddress: String) {
        if let url = URL(string: urlAddress) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func setUpPhotos() {
        photoCollection = createPhotoCollection()
        photosPageControl = createPageControl()
        
        scrollview.addSubview(photoCollection)
        scrollview.addSubview(photosPageControl)
        
        configurePhotosCollectionView()
    }

    private func setUpHeader() {
        let tag = viewModel?.boardingCategory ?? "NO TAG"
        let title = viewModel?.name ?? "NO TITLE"
        
        let locDistance = 1.5
        let locSubdistict = viewModel?.subdistrictName ?? "NO SUB-DISTR"
        let locProvince = viewModel?.provinceName ?? "NO SUB-PROV"
        
        let iconName = "star.fill"
        let ratingNum = viewModel?.rating ?? 99
        let reviewerNum = viewModel?.numOfReviews ?? 99
        
        tagLabel = createTagLabel(tag)
        titleLabel = createTitleLabel(title)
        locationLabel = createGrayLabel("\(locDistance) km dari lokasi・\(locSubdistict), \(locProvince)")
        
        rateReviewStackView = createRateReviewStack(iconName, ratingNum, reviewerNum)
        
        let stackView = UIStackView(arrangedSubviews: [tagLabel, titleLabel, locationLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing   = 8.0
        
        
        headerStack = UIStackView(arrangedSubviews: [stackView, rateReviewStackView])
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        headerStack.axis  = NSLayoutConstraint.Axis.vertical
        headerStack.distribution  = UIStackView.Distribution.fill
        headerStack.alignment = UIStackView.Alignment.fill
        headerStack.spacing   = 16.0

        scrollview.addSubview(headerStack)
    }
    private func createPhotoCollection() -> UICollectionView{
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
        
        return collectionView
    }
    private func createPageControl() -> UIPageControl {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.pageIndicatorTintColor = .customGray2
        control.currentPageIndicatorTintColor = .white
        control.backgroundColor = .clear
        control.contentVerticalAlignment = .bottom
        
        control.addTarget(BoardingDetailsViewController.self, action: #selector(photosPageControlValueChanged(_:)), for: .valueChanged)
        
        return control
    }
    private func createRateReviewStack(_ iconName: String, _ ratingNum: Double, _ reviewerNum: Int) -> UIStackView {
        
        ratingIcon = createRatingIcon(iconName)
        ratingNumLabel = createRateNumLabel("\(ratingNum)")
        reviewerNumLabel = createGrayLabel("(\(reviewerNum) review)")
        
        let stackView   = UIStackView(arrangedSubviews: [ratingIcon, ratingNumLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 5.0
        
        let allStackView = UIStackView(arrangedSubviews: [stackView, reviewerNumLabel])
        allStackView.translatesAutoresizingMaskIntoConstraints = false
        allStackView.axis = NSLayoutConstraint.Axis.horizontal
        allStackView.distribution = UIStackView.Distribution.fillProportionally
        allStackView.alignment = UIStackView.Alignment.firstBaseline
        allStackView.spacing   = 4.0
        return allStackView
    }
    
    private func createRatingIcon(_ iconName: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: iconName))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.tintColor = .customOrange
        imageView.contentMode = .scaleAspectFill
        imageView.sizeToFit()
        
        return imageView
    }
    
    private func createRateNumLabel(_ text: String) -> UILabel {
        let label = createTitleLabel(text)
        label.textColor = .customOrange
        return label
    }
    private func createGrayLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.textColor = .customGray3
        return label
    }
    private func createTitleLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }
    private func createTagLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.backgroundColor = .customGray
        label.textColor = .customGray3
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }
    private func createDefaultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = text
        label.numberOfLines = 0
        return label
    }
    
    // MARK: Action Handler
    @objc func shareButtonTapped() {
        print("share button tapped")
    }
    
    @objc func selectServiceButtonTapped() {

        let urlAdress = "https://www.google.com"
        presentOpenUrlAlert("Open Webpage", "You will be directed to a webpage", urlAdress)
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
    /// Add this method to update the page control index when scrolling ends
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
        // DEBUG
//        print(photoPaths.count)
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
