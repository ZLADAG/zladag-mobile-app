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
    
    init(slug: String, petBoardingName: String) {
        self.slug = slug
        self.petBoardingName = petBoardingName
        super.init(nibName: nil, bundle: nil)
        
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout {
            sectionIdx,
            _ in
            
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
        setupAnabulArray()
        setupCollectionView()
    }
    
    private func setupAnabulArray() {
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
            cell.configure(title: self.anabulArray[indexPath.row])
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
