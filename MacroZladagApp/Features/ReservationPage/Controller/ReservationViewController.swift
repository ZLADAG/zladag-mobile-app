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
        self.view = collectionView
        
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
                
            /// Dog orders
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(600))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                sectionLayout = NSCollectionLayoutSection(group: group)
            
            /// Cat Orders
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(600))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                sectionLayout = NSCollectionLayoutSection(group: group)
              
            /// TotalPrice
            case 3:
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

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(HeaderDateInputCollectionViewCell.self, forCellWithReuseIdentifier: HeaderDateInputCollectionViewCell.identifier)
        collectionView.register(HeaderPetAmountInputCollectionViewCell.self, forCellWithReuseIdentifier: HeaderPetAmountInputCollectionViewCell.identifier)
        
        collectionView.register(PetOrderCollectionViewCell.self, forCellWithReuseIdentifier: PetOrderCollectionViewCell.identifier)
//        collectionView.register(DogOrderCollectionViewCell.self, forCellWithReuseIdentifier: DogOrderCollectionViewCell.identifier)
//        collectionView.register(CatOrderCollectionViewCell.self, forCellWithReuseIdentifier: CatOrderCollectionViewCell.identifier)
        
        collectionView.register(TotalPriceSummaryCollectionViewCell.self, forCellWithReuseIdentifier: TotalPriceSummaryCollectionViewCell.identifier)
        
    }
    
}

extension ReservationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return AppAccountManager.shared.anjingCount
        case 2:
            return AppAccountManager.shared.kucingCount
        case 3:
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
            cell.titleLabel.text = "Anjing \(indexPath.row + 1)"
            
            print("anjing \(indexPath)")
            
            petCageOptTapped(withPrice: 0)
//            petCageOptTapped(idx: 0, priceWithAmount: PriceWithAmount(price: 0, amount: 0))
            petAddOnServicesTapped(withPrice: 0)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetOrderCollectionViewCell.identifier, for: indexPath) as! PetOrderCollectionViewCell
            cell.backgroundColor = .white

            cell.delegate = self
            cell.titleLabel.text = "Kucing \(indexPath.row + 1)"
            print("kucing \(indexPath)")

            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalPriceSummaryCollectionViewCell.identifier, for: indexPath) as! TotalPriceSummaryCollectionViewCell
            cell.backgroundColor = .white
            cell.delegate = self
            cell.updatePetAmount(amount: ReservationManager.shared.totalPets)
            return cell
        default:
            print("invalid section")
            return UICollectionViewCell()
        }
    }

    
}

extension ReservationViewController: CustomDatePickerViewControllerDelegate {
    func getDateLabel(completion: (() -> Void)?) {
        
 
        //    func getDateLabel() {
        ////        let mycell = cell as! HeaderDateInputCollectionViewCell
        ////        mycell.updateDateLabelText()
        //        updateDateLabelText()
        //        collectionView.reloadData()
        //    }
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



extension ReservationViewController: PetOrderCollectionViewCellDelegate {
    func petCageOptTapped(idx: Int, priceWithAmount: PriceWithAmount) {
        print("\ncage tapped: \(priceWithAmount.price) x \(priceWithAmount.amount)")
        if priceWithAmount.amount == 1 {
//            cagePrice = priceWithAmount.price
            totalDefaultPrice = totalDefaultPrice + priceWithAmount.price
        } else {
//            cagePrice = 0
            totalDefaultPrice = totalDefaultPrice - priceWithAmount.price
        }
        print("totalDefaultPrice = \(totalDefaultPrice)")
    }
    
    func petCageOptTapped(withPrice: Int) {
        
        print("\ncage tapped: \(withPrice)")
        totalDefaultPrice = withPrice
        print("totalDefaultPrice = \(totalDefaultPrice)")
        updateDefaultPrice(price: 0)


    }
    
    func petAddOnServicesTapped(withPrice: Int) {
        print("AddOnServices tapped: \(withPrice)")
        totalAddOnServicePrice = withPrice
        print("totalAddOnServicePrice = \(totalAddOnServicePrice)")
        updateAddOnServicePrice(price: 0)

    }
    
    func petOptButtonTapped(cell: UICollectionViewCell, atIndexPath: IndexPath) {
        print("\npetOptButtonTapped on \(String(describing: atIndexPath))")
        self.present(PetOptionSheetViewController(), animated: true) {
            print("dog hehe")
            
            let orderCell = cell as! PetOrderCollectionViewCell
            orderCell.petProfileItemTapped(cell: UITableViewCell(), atIdxPathRow: atIndexPath.row)
        }
    }
}


extension ReservationViewController : TotalPriceSummaryCollectionViewCellDelegate {
    func updatePetAmount(amount: Int) {
        
    }
    
    func updateDefaultPrice(price: Int) {
    }
    
    func updateAddOnServicePrice(price: Int) {
        
    }
    
    func updateTotalPrice(price: Int) {
//        totalPrice = price
    }
    
    func orderButtonTapped() {
        let successVC = ReservationSuccessPageViewController()
        present(successVC,animated: true)
        
        // TODO: GANTI PAKE PUSH CONTROLLER KL UDA JD FLOWNYA
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
