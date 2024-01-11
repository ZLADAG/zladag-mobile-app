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
    
    var lastTextView: ReservationTextView?
    
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
            } else if sectionIdx == 1 {
                let cagesCount: Int = self.viewModel.anabulCells[0].cages.count
                let servicesCount: Int = self.viewModel.anabulCells[0].services.count
                
                let cellHeight: CGFloat = CGFloat(412) + CGFloat((cagesCount + servicesCount) * 34) // 20 + (7*2)
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
            } else {
                let cellHeight: CGFloat = 188 + 400
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        self.setupAnabulArray() // step 1
        
        fetchData { [weak self] in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.configureViews()
            }
        }
    }
    
    private func configureViews() {
        self.spinner.stopAnimating()
        
        self.setupAnabulData() // step 2
        self.setupCollectionView()
    }
    
    public func setupAnabulArray() { // step 1
        if AppAccountManager.shared.kucingCount == 0 && AppAccountManager.shared.anjingCount == 0 {
            AppAccountManager.shared.kucingCount = 1
        }
            
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
    
    public func setupAnabulData() { // step 2
        guard let response = boardingReservationDataResponse else { return }
        
        self.viewModel.anabulCells = self.anabulArray.compactMap({ nthAnabul in
            return ReservationCellViewModel(nthAnabul: nthAnabul) // Kucing 0
        })
        
        self.viewModel.usersCats = response.data.pets.cats.compactMap({ cat in
            return UsersPet(
                id: cat.id,
                name: cat.name,
                petBreed: cat.petBreed,
                age: cat.age,
                image: cat.image,
                hasCompliedThePolicy: cat.hasCompliedThePolicy
            )
        })
        
        self.viewModel.usersDogs = response.data.pets.dogs.compactMap({ dog in
            return UsersPet(
                id: dog.id,
                name: dog.name,
                petBreed: dog.petBreed,
                age: dog.age,
                image: dog.image,
                hasCompliedThePolicy: dog.hasCompliedThePolicy
            )
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
        
        // TOTAL PEMESANAN CELL (LOWEST SECTION)
        collectionView.register(TotalPemesananCollectionViewCell.self, forCellWithReuseIdentifier: TotalPemesananCollectionViewCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44 + 50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 400),
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
                print("ERROR WHEN getBoardingReservationDataBySlug:", error)
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
    
    @objc func keyboardWillShow(notification: NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y == 0 {
            if let lastTextView {
                if lastTextView.isFirstResponder {
                    self.view.frame.origin.y -= keyboardFrame.height
                }
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += keyboardFrame.height
        }
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
}

extension ReservationViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return self.anabulArray.count
        } else {
            return 1
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
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReservationCollectionViewCell.identifier, for: indexPath) as! ReservationCollectionViewCell
            cell.reservationViewController = self
            
            cell.configure(
                title: self.anabulArray[indexPath.row],
                cellViewModel: self.viewModel.anabulCells[indexPath.row]
            )
            cell.textView.tag = 500 + indexPath.row
            
            if indexPath.row == (self.anabulArray.count - 1) {
                self.lastTextView = cell.viewWithTag(500 + indexPath.row) as? ReservationTextView
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalPemesananCollectionViewCell.identifier, for: indexPath) as! TotalPemesananCollectionViewCell
            cell.reservationController = self
            cell.configure(boardingSlug: self.slug, cellsViewModel: self.viewModel.anabulCells)
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
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
