//
//  ReservationViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 17/12/23.
//

import UIKit

class ReservationViewController: UIViewController {
    
    let slug: String
    let petBoardingName: String
//    var kucingAmount = AppAccountManager.shared.kucingCount
//    var anjingAmount = AppAccountManager.shared.anjingCount
    
    public var anabulArray = [String]()
    
    var viewModel = ReservationPageViewModel()
    var boardingReservationDataResponse: BoardingReservationDataResponse?
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .customOrange
        spinner.backgroundColor = .clear
        return spinner
    }()
    
    init(slug: String, petBoardingName: String) {
        self.slug = slug
        self.petBoardingName = petBoardingName
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIdx, _ in
            
            if sectionIdx == 0 {
                let cellWidth: CGFloat = (self.view.width * 0.5) - 32
                let cellHeight: CGFloat = 62
                let horizontalPadding: CGFloat = 16
                
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(cellWidth + horizontalPadding),
                        heightDimension: .absolute(cellHeight)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: horizontalPadding / 2, bottom: 0, trailing: horizontalPadding / 2)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(self.view.width),
                        heightDimension: .absolute(cellHeight)
                    ),
                    subitems: [item]
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24 - (horizontalPadding / 2), bottom: 0, trailing: 24 - (horizontalPadding / 2))
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 10, trailing: 0)
                return section
            } else {
                let cellHeight: CGFloat = 529
                let verticalPadding: CGFloat = 12
                
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(cellHeight + verticalPadding)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: verticalPadding, trailing: 0)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(cellHeight + verticalPadding)
                    ),
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light
        super.title = self.petBoardingName
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .textBlack
        
//        print("\nDATE1: \(AppAccountManager.shared.selectedDay1!.components)")
//        print("DATE2: \(AppAccountManager.shared.selectedDay2!.components)")
//        print("\(AppAccountManager.shared.anjingCount) ANJING, \(AppAccountManager.shared.kucingCount) KUCING")
        
        self.setupAnabulArray()
        
        fetchData { [weak self] in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.configureViews()
            }
        }
    }
    
    private func configureViews() {
        self.spinner.stopAnimating()
        self.setupAnabulData()
        self.setupCollectionView()
        
//        var z  = 0
//        for cell in self.viewModel.anabulCells {
//            print("z = \(z)")
//            for cage in cell.cages {
//                print(cage.name)
//                print(cage.priceString)
//                print(cage.isTapped)
//                print()
//            }
//            z += 1
//        }
    }
    
    public func setupAnabulArray() {
        if AppAccountManager.shared.kucingCount > 0 {
            for i in 1...AppAccountManager.shared.kucingCount {
                self.anabulArray.append("Kucing \(i)")
            }
        }
        
        if AppAccountManager.shared.anjingCount > 0 {
            for i in 1...AppAccountManager.shared.anjingCount {
                self.anabulArray.append("Anjing \(i)")
            }
        }
    }
    
    public func setupAnabulData() {
        guard let response = boardingReservationDataResponse else { return }
        
        self.viewModel.anabulCells = self.anabulArray.compactMap({ string in
            return ReservationCellViewModel()
        })
        
        for cell in self.viewModel.anabulCells {
            cell.cages = response.data.boardingCages.compactMap({ cageInfo in
                return ReservationCageDetails(id: cageInfo.id, name: cageInfo.name, price: cageInfo.price)
            })
            
            cell.services = response.data.boardingServices.compactMap({ serviceInfo in
                return ReservationServiceDetails(id: serviceInfo.id, name: serviceInfo.name, price: serviceInfo.price)
            })
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .customLightGray3
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // SMALL CELL ABOVE
        collectionView.register(TanggalReservationCollectionViewCell.self, forCellWithReuseIdentifier: TanggalReservationCollectionViewCell.identifier)
        collectionView.register(AnabulReservationCollectionViewCell.self, forCellWithReuseIdentifier: AnabulReservationCollectionViewCell.identifier)
        
        // CARD CELL
        collectionView.register(ReservationCollectionViewCell.self, forCellWithReuseIdentifier: ReservationCollectionViewCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44 + 50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func onClickCatsAndDogsButton() {
        let vc  = CatsAndDogsCounterViewController()
        vc.reservationController = self
        
        let navVc = UINavigationController(rootViewController: vc)
        
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 10
            sheet.detents = [
                .custom(resolver: { context in
                    0.33 * context.maximumDetentValue
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        navigationController?.present(navVc, animated: true, completion: nil)
    }
    
    func onClickDatePickerButton() {
        let vc = CustomDatePickerViewController()
        vc.reservationController = self
        
        let navVc = UINavigationController(rootViewController: vc)
        
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 10
            sheet.detents = [
                .custom(resolver: { context in
                    0.75 * context.maximumDetentValue
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        navigationController?.present(navVc, animated: true, completion: nil)
    }
    
    
    private func fetchData(completion: @escaping () -> ()) {
        setupLoadingScreen()
        
        
        APICaller.shared.getBoardingReservationDataBySlug(slug: self.slug) { result in
            switch result {
            case .success(let response):
                self.boardingReservationDataResponse = response
                
                
                completion()
                
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func setupLoadingScreen() {
        view.addSubview(spinner)
        spinner.hidesWhenStopped = true
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        spinner.startAnimating()
    }
    

    
    required init(coder: NSCoder) {
        fatalError()
    }
    
}

extension ReservationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return self.anabulArray.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TanggalReservationCollectionViewCell.identifier, for: indexPath) as! TanggalReservationCollectionViewCell
                cell.tag = 461
                cell.configure()
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnabulReservationCollectionViewCell.identifier, for: indexPath) as! AnabulReservationCollectionViewCell
                cell.tag = 462
                cell.configure()
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReservationCollectionViewCell.identifier, for: indexPath) as! ReservationCollectionViewCell
            cell.reservationViewController = self
            
            cell.configure(
                title: self.anabulArray[indexPath.row],
                cellViewModel: self.viewModel.anabulCells[indexPath.row]
            )
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                self.onClickDatePickerButton()
            } else {
                self.onClickCatsAndDogsButton()
            }
        }
    }
    
}
