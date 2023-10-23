//
//  SearchResultsViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import UIKit

protocol SearchResultsViewControllerDelegate { // harga tertinggi, cctv, makan, kucing
    func showResult(_ controller: UIViewController)
}

class SearchResultsViewController: UIViewController {

    var viewModels = [SearchBoardingViewModel]()
    
    let navbarLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Dekat Saya"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let navbarDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "1 Okt 2023, 1 Malam, 1 Kucing"
        label.textColor = .customGrayForIcons
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let navbarUbahButton: UIButton = {
        let button = UIButton()
        
        let label = UILabel()
        label.text = "Ubah"
        label.textColor = .customOrange
        label.font = .systemFont(ofSize: 12, weight: .bold)
        
        button.setTitle("Ubah", for: .normal)
        button.setTitleColor(.customOrange, for: .normal)
        button.backgroundColor = .orangeWithOpacity
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        
        return button
    }()
    
    public var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIdx, _ in
            switch sectionIdx {
            case 0:
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(66),
                        heightDimension: .absolute(33 + 16 + 16)
                    )
                )
                
                item.contentInsets.leading = 24
                item.contentInsets.bottom = 16
                item.contentInsets.top = 16
                
//                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leading, bottom: bottom, trailing: 0)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(66 + 24),
                        heightDimension: .absolute(33 + 16 + 16)
                      ),
                    subitem: item,
                    count: 1
                )
                
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(92)),
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top
                    )
                ]
            
                
                return section
            case 1:
                let bottom: CGFloat = 24
                let cardWidth: CGFloat = 342
                let cardHeight: CGFloat = 274
                let leading: CGFloat = (390 - cardWidth) / 2
                
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(cardWidth),
                        heightDimension: .absolute(cardHeight + bottom)
                    )
                )
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leading, bottom: bottom, trailing: 0)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(cardWidth + leading),
                        heightDimension: .absolute(cardHeight + bottom)
                      ),
                    subitem: item,
                    count: 1
                )

                
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            default:
                let bottom: CGFloat = 24
                let cardWidth: CGFloat = 342
                let cardHeight: CGFloat = 268
                let leading: CGFloat = (390 - cardWidth) / 2
                
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(cardWidth),
                        heightDimension: .absolute(cardHeight + bottom)
                    )
                )
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leading, bottom: bottom, trailing: 0)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(cardWidth + leading),
                        heightDimension: .absolute(cardHeight + bottom)
                      ),
                    subitem: item,
                    count: 1
                )

                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
        }
    )
    
    // MARK: CUSTOM NAVBAR
    public var locationValue = "Dekat Saya"
    public var detailsValue = "123 Jan"
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = locationValue
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.text = detailsValue
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .customGray3
        return label
    }()
    
    lazy var navbarTitleView: UIView = {
        let titleView = UIView()
        titleView.backgroundColor = .white
        view.addSubview(titleView)
        titleView.addSubview(locationLabel)
        titleView.addSubview(detailsLabel)
        
        titleView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 54 + 82 - 38)
        locationLabel.frame = CGRect(x: 80 - 44 + 10, y: 22 + 54 - 22 - 5, width: 250, height: 16)
        detailsLabel.frame = CGRect(x: locationLabel.frame.minX, y: locationLabel.frame.maxY + 6, width: 250, height: 16)
        return titleView
    }()
    
    let rightBarButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customOrangeOpacityUbah
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        
        let label = UILabel()
        label.text = "Ubah"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .customOrangeFont
        button.addSubview(label)
        button.frame = CGRect(x: 0, y: 0, width: 63, height: 32)
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 16)
        label.frame = CGRect(
            x: (button.frame.width - label.frame.width) / 2,
            y: (button.frame.height - label.frame.height) / 2,
            width: label.frame.width,
            height: label.frame.height
        )
        
        return button
    }()
    
    func setupCustomNavbar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationItem.titleView = navbarTitleView
        rightBarButton.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    }
    
    @objc func rightButtonClicked() {
        print("oke")
    }
    
    // MARK: LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .magenta
        configureCollectionView()
        setupCustomNavbar()
    }
    
    func setupNavigationBar() {
        //        let imageView = UIImageView(image: UIImage(systemName: "star"))
        //        imageView.contentMode = .scaleAspectFill
        //        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        //        imageView.widthAnchor.constraint(equalToConstant: 113).isActive = true
        //        navigationController?.navigationBar.backgroundColor = .clear
        //        navigationItem.titleView = imageView
        let titleView: UIView = {
            let view = UIView()
            view.backgroundColor = .red
            return view
        }()
        
        titleView.addSubview(navbarLocationLabel)
        titleView.addSubview(navbarDetailsLabel)
        
//        titleView.translatesAutoresizingMaskIntoConstraints = false
//        navbarLocationLabel.translatesAutoresizingMaskIntoConstraints = false
//        navbarDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            titleView.topAnchor
//        ])
        
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        navbarLocationLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        navbarDetailsLabel.frame = CGRect(x: 0, y: navbarLocationLabel.bottom, width: 100, height: 20)
        
        navigationController?.navigationItem.titleView = titleView
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .done, target: nil, action: nil)
    }
    
    func setupNavigationBar2() {
        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = .customLightOrange
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance

    }
    
    func setupNavigationBar3() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .customLightOrange
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .white
        
//        navigationController?.navigationBar.standardAppearance = appearance2
//        navigationController?.navigationBar.compactAppearance = appearance2
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect(x: view.bounds.minX, y: view.bounds.minY - 94, width: view.bounds.width, height: view.bounds.height + 94)
    }
    
    func configureCollectionView() {
        collectionView.register(SearchBoardingsResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchBoardingsResultCollectionViewCell.identifier)
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        collectionView.register(SearchResultHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultHeaderCollectionReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .customGray
        
        view.addSubview(collectionView)
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.viewModels.count
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        
        if section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
            cell.viewControllerDelegate = self // utk button filter!
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchBoardingsResultCollectionViewCell.identifier, for: indexPath) as? SearchBoardingsResultCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configure(with: viewModels[indexPath.row])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultHeaderCollectionReusableView.identifier, for: indexPath) as? SearchResultHeaderCollectionReusableView else { return UICollectionReusableView() }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    
        let viewModel = viewModels[indexPath.row]
        let vc = BoardingDetailsViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.navigationItem.largeTitleDisplayMode = .always
        vc.navigationController?.navigationBar.prefersLargeTitles = true

        let group = DispatchGroup()
        group.enter()
        
        APICaller.shared.getBoardingBySlug(slug: viewModel.slug) { result in
            defer {
                group.leave()
            }

            switch result {
            case .success(let response):
                vc.viewModel = BoardingDetailsViewModel(
                    name: response.data.name,
                    distance: response.data.distance,
                    address: response.data.address,
                    slug: response.data.slug,
                    description: response.data.description,
                    boardingCategory: response.data.boardingCategory,
                    subdistrictName: response.data.subdistrict,
                    provinceName: response.data.province,
                    boardingCages: response.data.boardingCages,
                    price: response.data.cheapestLodgingPrice,
                    images: response.data.images,
                    facilities: response.data.boardingFacilities,
                    shouldHaveBeenVaccinated: response.data.shouldHaveBeenVaccinated,
                    shouldHaveToBeFleaFree: response.data.shouldHaveToBeFleaFree,
                    minimumAge: response.data.minimumAge,
                    maximumAge: response.data.maximumAge,
                    rating: viewModel.rating,
                    numOfReviews: viewModel.numOfReviews
                )
                break
            case .failure(let error):
                let localResult = Utils.getOneBoardingDetails()!.data
                vc.viewModel = BoardingDetailsViewModel(
                    name: localResult.name,
                    distance: localResult.distance,
                    address: localResult.address,
                    slug: localResult.slug,
                    description: localResult.description,
                    boardingCategory: localResult.boardingCategory,
                    subdistrictName: localResult.subdistrict,
                    provinceName: localResult.province,
                    boardingCages: localResult.boardingCages,
                    price: localResult.cheapestLodgingPrice,
                    images: localResult.images,
                    facilities: localResult.boardingFacilities,
                    shouldHaveBeenVaccinated: localResult.shouldHaveBeenVaccinated,
                    shouldHaveToBeFleaFree: localResult.shouldHaveToBeFleaFree,
                    minimumAge: localResult.minimumAge,
                    maximumAge: localResult.maximumAge,
                    rating: viewModel.rating,
                    numOfReviews: viewModel.numOfReviews
                )
                print(error.localizedDescription)
                break
            }
        }
        
        group.notify(queue: .main) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
