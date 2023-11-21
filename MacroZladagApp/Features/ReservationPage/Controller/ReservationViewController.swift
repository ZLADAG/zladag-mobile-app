//
//  ReservationViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 07/11/23.
//

import UIKit

class ReservationViewController: UIViewController {
        
    var collectionView: UICollectionView!
    
    var totalDefaultPrice = 0
    var totalAddOnServicePrice = 0
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIdx, environment) -> NSCollectionLayoutSection? in
            
            /// Define section layouts (e.g., a grid layout)
            var sectionLayout: NSCollectionLayoutSection!
            
            switch sectionIdx {
            /// Header input
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(90))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                sectionLayout = NSCollectionLayoutSection(group: group)
                
            /// Cat orders
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(600))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                sectionLayout = NSCollectionLayoutSection(group: group)
            
                let amount = AppAccountManager.shared.kucingCount
                if ReservationManager.shared.defaultPrices.isEmpty {
                    ReservationManager.shared.defaultPrices = Array(repeating: 0, count: amount)
                }
                if ReservationManager.shared.addOnServicePrices.isEmpty {
                    ReservationManager.shared.addOnServicePrices = Array(repeating: 0, count: amount)
                }
            /// Dog Orders
//            case 2:
//                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(600))
//                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//                sectionLayout = NSCollectionLayoutSection(group: group)
              
            /// TotalPrice
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                sectionLayout = NSCollectionLayoutSection(group: group)
//                sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
            default:
                print("invalid section")
                return nil
            }
            return sectionLayout
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = .white
        
        collectionView.register(HeaderDateInputCollectionViewCell.self, forCellWithReuseIdentifier: HeaderDateInputCollectionViewCell.identifier)
        collectionView.register(HeaderPetAmountInputCollectionViewCell.self, forCellWithReuseIdentifier: HeaderPetAmountInputCollectionViewCell.identifier)
        collectionView.register(PetOrderCollectionViewCell.self, forCellWithReuseIdentifier: PetOrderCollectionViewCell.identifier)
        collectionView.register(TotalPriceSummaryCollectionViewCell.self, forCellWithReuseIdentifier: TotalPriceSummaryCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view = collectionView
        
        
    }
    
}

extension ReservationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return AppAccountManager.shared.kucingCount
//        case 2:
////            return 0
//            return AppAccountManager.shared.anjingCount
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderDateInputCollectionViewCell.identifier, for: indexPath) as! HeaderDateInputCollectionViewCell
                cell.delegate = self
                cell.datePickerButton.infoLabel.text = AppAccountManager.shared.calendarTextDetails
                cell.backgroundColor = .customLightGray3
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderPetAmountInputCollectionViewCell.identifier, for: indexPath) as! HeaderPetAmountInputCollectionViewCell
                cell.delegate = self
                cell.updateInfoLabel(cats: AppAccountManager.shared.kucingCount, dogs: AppAccountManager.shared.anjingCount)
                cell.backgroundColor = .customLightGray3
                return cell
            }
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetOrderCollectionViewCell.identifier, for: indexPath) as! PetOrderCollectionViewCell
            cell.backgroundColor = .white
            
            cell.delegate = self
            
            cell.type = .cat
            cell.titleLabel.text = "Kucing \(indexPath.row + 1)"
            print("Kucing \(indexPath)")
            return cell
//        case 2:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetOrderCollectionViewCell.identifier, for: indexPath) as! PetOrderCollectionViewCell
//            cell.backgroundColor = .white
//
//            cell.delegate = self
//
//            cell.type = .dog
//            cell.titleLabel.text = "Anjing \(indexPath.row + 1)"
//
//            print("Anjing \(indexPath)")
//
//            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalPriceSummaryCollectionViewCell.identifier, for: indexPath) as! TotalPriceSummaryCollectionViewCell

            cell.backgroundColor = .white
            cell.delegate = self
            cell.updatePetAmountLabel(amount: ReservationManager.shared.totalPets)
            cell.updateDefaultPriceLabel(price: ReservationManager.shared.totalDefaultPrice)
            cell.updateTotalPriceLabel(price: ReservationManager.shared.totalOrder)
            
            return cell
        default:
            print("invalid section")
            return UICollectionViewCell()
        }
    }
}

// MARK: Pet Order Cell
extension ReservationViewController: PetOrderCollectionViewCellDelegate {
    func petOptTapped(cell: UICollectionViewCell, atIndexPath: IndexPath) {
        let sheetVC = PetOptionSheetViewController()
        let orderCell = cell as! PetOrderCollectionViewCell
        
        sheetVC.delegate = orderCell
        sheetVC.setType(type: orderCell.type)
        self.collectionView.reloadData()

        self.present(sheetVC, animated: true)
    }
    
    func cageOptTapped(cell: UICollectionViewCell, atIndexPath: IndexPath) {
        if let totalPriceCell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 2)) as? TotalPriceSummaryCollectionViewCell {
            totalPriceCell.updateDefaultPriceLabel(price: ReservationManager.shared.totalDefaultPrice)
            totalPriceCell.updateAddOnServicePriceLabel(price: ReservationManager.shared.totalAddOnServicePrice)
            totalPriceCell.updateTotalPriceLabel(price: ReservationManager.shared.totalOrder)
//            self.collectionView.reloadData()
        }
    }
    
    func serviceOptTapped(cell: UICollectionViewCell, atIndexPath: IndexPath) {
        if let totalPriceCell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 2)) as? TotalPriceSummaryCollectionViewCell {
//            totalPriceCell.updatePetAmountLabel(amount: ReservationManager.shared.totalPets)
            totalPriceCell.updateDefaultPriceLabel(price: ReservationManager.shared.totalDefaultPrice)
            totalPriceCell.updateAddOnServicePriceLabel(price: ReservationManager.shared.totalAddOnServicePrice)
            totalPriceCell.updateTotalPriceLabel(price: ReservationManager.shared.totalOrder)
//            self.collectionView.reloadData()
        }
    }
}

// MARK: Total Payment Cell
extension ReservationViewController : TotalPriceSummaryCollectionViewCellDelegate {
    
    func orderButtonTapped() {
        let successVC = ReservationSuccessPageViewController()
        present(successVC,animated: true)
        
        // TODO: GANTI PAKE PUSH CONTROLLER KL UDA JD FLOWNYA
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ReservationViewController: CustomDatePickerViewControllerDelegate {
    func getDateLabel(completion: (() -> Void)?) {
    }
}
extension ReservationViewController: HeaderDateInputCollectionViewCellDelegate {
    func updateDateLabelText(dateText: String) {
        print(dateText)
    }
    
    func dateInputInputBtnTapped() {
        let datePickerSheetVC = CustomDatePickerViewController()
        datePickerSheetVC.delegate = self
        datePickerSheetVC.modalPresentationStyle = .pageSheet

        let navVc = UINavigationController(rootViewController: datePickerSheetVC)
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
        present(navVc, animated: true, completion: nil)
//        delegate?.navigationController?.present(navVc, animated: true, completion: nil)
    }
}
extension ReservationViewController: HeaderPetAmountInputCollectionViewCellDelegate {
    func petAmountInputBtnTapped() {
        
        let petAmountSheetVC = CatsAndDogsCounterViewController()
        petAmountSheetVC.modalPresentationStyle = .pageSheet

        let navVc = UINavigationController(rootViewController: petAmountSheetVC)
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 10
            sheet.detents = [
                .custom(resolver: { context in
                    0.4 * context.maximumDetentValue
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        present(navVc, animated: true, completion: nil)
//        delegate?.navigationController?.present(navVc, animated: true, completion: nil)
    }
}

