//
//  ReservationViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 07/11/23.
//

import UIKit

class ReservationViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        //        view.addSubview(collectionView)
        self.view = collectionView
        
        let layout = UICollectionViewCompositionalLayout { (sectionIdx, environment) -> NSCollectionLayoutSection? in
            
            // Define section layouts (e.g., a grid layout)
            var sectionLayout: NSCollectionLayoutSection!
            
            switch sectionIdx {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                sectionLayout = NSCollectionLayoutSection(group: group)
                
            default:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(530))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

                sectionLayout = NSCollectionLayoutSection(group: group)
                sectionLayout.interGroupSpacing = 12
            }
          
            return sectionLayout
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .customLightGray3
         
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(HeaderInputCollectionViewCell.self, forCellWithReuseIdentifier: HeaderInputCollectionViewCell.identifier)
        collectionView.register(PetOrderCollectionViewCell.self, forCellWithReuseIdentifier: PetOrderCollectionViewCell.identifier)
        
    }
    
}

extension ReservationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderInputCollectionViewCell.identifier, for: indexPath) as! HeaderInputCollectionViewCell
            if indexPath.row == 0 {
                cell.backgroundColor = .yellow
            } else {
                cell.backgroundColor = .orange
            }
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetOrderCollectionViewCell.identifier, for: indexPath) as! PetOrderCollectionViewCell
            cell.backgroundColor = .white
            cell.setUpCell()
            return cell
        }
    }
    
}






















































//class ReservationViewController: UIViewController {
//
//    private var headerInputView: UIView!
//    private var dateButton: HeaderInputButton!
//    private var petAmountButton: HeaderInputButton!
//
//    var date = ""
//    let datePickerVC  = RangeDatePickerViewController()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//
//        setUpComponents()
//
//        dateButton.delegate = self
//        petAmountButton.delegate = self
//        datePickerVC.delegate = self
//
//    }
//
//    private func setUpComponents() {
//        headerInputView = createHeaderInput()
//
//        setupConstraints()
//    }
//    private func setupConstraints() {
//        view.addSubview(headerInputView)
//        NSLayoutConstraint.activate([
//            headerInputView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
//            headerInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            headerInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
//
//    private func createHeaderInput() -> UIView {
//        dateButton = HeaderInputButton("Tanggal", "7 Oct - 9 Oct 2023", .date)
//        petAmountButton = HeaderInputButton("Anabul", "1 Kucing 2 Anjing", .petAmount)
//
//        let stack = UIStackView(arrangedSubviews: [dateButton, petAmountButton])
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .horizontal
//        stack.alignment = .fill
//        stack.distribution = .fillEqually
//        stack.spacing = 16
//
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .customLightGray3
//        view.addSubview(stack)
//        NSLayoutConstraint.activate([
//            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
//            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
//            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
//            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
//        ])
//
//        return view
//    }
//}
//
//extension ReservationViewController: HeaderInputButtonDelegate {
//    func btnTapped(_ senderButtonType: HeaderInputButton.ButtonType) {
//        if senderButtonType == .date {
//            dateButtonAction()
//        } else if senderButtonType == .petAmount {
//            petAmountButtonAction()
//        }
//    }
//
//    private func dateButtonAction() {
//        print("Date button tapped")
//        let vc  = RangeDatePickerViewController()
//        let navVc = UINavigationController(rootViewController: vc)
//
//        vc.modalPresentationStyle = .pageSheet
//
//        if let sheet = navVc.sheetPresentationController {
//            sheet.preferredCornerRadius = 10
//            sheet.detents = [
//                .custom(resolver: { context in
//                    0.83 * context.maximumDetentValue
//                })
//            ]
//            sheet.prefersGrabberVisible = true
//            sheet.largestUndimmedDetentIdentifier = .large
//        }
//        present(navVc, animated: true) { [self] in
////            updateData(date)
//        }
//
////        if (startDate != nil) {
////            vc.startDateLabel.text = String(vc.getDate(self.startDate!))
//////            print(startDate)
////        } else {
////            vc.startDate = nil
////        }
////
////        if (endDate != nil) {
////            vc.endDateLabel.text = String(vc.getDate(self.endDate!))
//////            print(endDate)
////        } else {
////            vc.endDate = nil
////        }
//
////        delegate?.navigationController?.present(navVc, animated: true, completion: nil)
//    }
//
//    private func petAmountButtonAction() {
//        print("Pet Amount button tapped")
//    }
//
//}
//
//extension ReservationViewController: RangeDatePickerViewControllerDelegate {
//    func updateData(_ btn: UIButton) {
//
//    }
//}

