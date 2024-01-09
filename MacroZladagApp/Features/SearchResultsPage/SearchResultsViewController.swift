//
//  SearchResultsViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import UIKit

class SearchResultsViewController: UIViewController {

    public var viewModels = [SearchBoardingViewModel]()
    
    public var anjingCount = 0
    public var kucingCount = 0
    
    var isLoading: Bool = false
    
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
        label.textColor = .textBlack
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
    
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .customOrange
        spinner.backgroundColor = .clear
        return spinner
    }()
    
    func setupCustomNavbar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationItem.titleView = navbarTitleView
        rightBarButton.addTarget(self, action: #selector(onClickUbahButton), for: .touchUpInside)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    }
    
    @objc func onClickUbahButton() {
        let vc  = UbahPencarianViewController()
        let navVc = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .pageSheet
        vc.searchControllerDelegate = self
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 10
            sheet.detents = [
                .custom(resolver: { context in
                    0.35 * context.maximumDetentValue
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        self.navigationController?.present(navVc, animated: true, completion: nil)
    }
    
    // MARK: LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .textBlack
        
        configureCollectionView()
        setupCustomNavbar()
        setupLoadingScreen()
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
    
    func setupLoadingScreen() {
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        spinner.startAnimating()
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
            cell.controllerDelegate = self
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
        let vc = BoardingDetailsViewController(slug: viewModel.slug)
        vc.hidesBottomBarWhenPushed = true
        vc.navigationItem.largeTitleDisplayMode = .always
        vc.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
