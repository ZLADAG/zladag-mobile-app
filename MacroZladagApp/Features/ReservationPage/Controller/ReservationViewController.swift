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
    
    var slug: String

    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .customOrange
        spinner.backgroundColor = .clear
        return spinner
    }()
    
    init(slug: String) {
        self.slug = slug
        super.init(nibName: nil, bundle: nil)
        print(slug)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLoadingScreen()
        APICaller.shared.getBoardingReservationDataBySlug(slug: self.slug) { result in
            var success = false
            switch result {
            case .success(let response):
                print(response.data)
                print("ok")
                ReservationManager.shared.reservationModel = ReservationViewModel(
                    slug: response.data.boarding.slug,
                    name: response.data.boarding.name,
                    cats: response.data.pets.cats,
                    dogs: response.data.pets.dogs,
                    cages: response.data.boardingCages,
                    services: response.data.boardingServices)
                
                success = true
                break
            case .failure(let error):
                print("ERROR IN GET BOARDING BY SLUG:\n\(error)")
            }
            
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    
                    self.navigationController?.navigationItem.largeTitleDisplayMode = .always
                    self.navigationItem.title = "\(ReservationManager.shared.reservationModel!.name)"
                    
                    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

                    self.navigationController?.navigationBar.tintColor = .customOrange
                    self.navigationController?.navigationBar.barStyle = .default
                    
                    self.navigationController?.navigationBar.isTranslucent = true
                    
                   
                    self.setupCollectionView()
                    
                    self.spinner.stopAnimating()
                    self.spinner.hidesWhenStopped = true
                    self.spinner.isHidden = true
                })
            }
        }
    }
    func setupLoadingScreen() {
        view.addSubview(spinner)
        
        spinner.frame = CGRect(
            x: view.frame.midX - 25,
            y: view.frame.midY - 25,
            width: 50,
            height: 50
        )
        
        spinner.startAnimating()
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
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(700))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                sectionLayout = NSCollectionLayoutSection(group: group)
            
                let amount = AppAccountManager.shared.kucingCount
                if ReservationManager.shared.catDefaultPrices.isEmpty {
                    ReservationManager.shared.catDefaultPrices = Array(repeating: 0, count: amount)
                }
                if ReservationManager.shared.catAddOnServicePrices.isEmpty {
                    ReservationManager.shared.catAddOnServicePrices = Array(repeating: 0, count: amount)
                }
                
            /// Dog Orders
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(700))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                sectionLayout = NSCollectionLayoutSection(group: group)
            
                let amount = AppAccountManager.shared.kucingCount
                if ReservationManager.shared.dogDefaultPrices.isEmpty {
                    ReservationManager.shared.dogDefaultPrices = Array(repeating: 0, count: amount)
                }
                if ReservationManager.shared.dogAddOnServicePrices.isEmpty {
                    ReservationManager.shared.dogAddOnServicePrices = Array(repeating: 0, count: amount)
                }
              
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
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return AppAccountManager.shared.kucingCount
        case 2:
            return AppAccountManager.shared.anjingCount
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
            cell.type = .cat
            cell.titleLabel.text = "Kucing \(indexPath.row + 1)"
            print("Kucing \(indexPath)")
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetOrderCollectionViewCell.identifier, for: indexPath) as! PetOrderCollectionViewCell
            cell.backgroundColor = .white

            cell.delegate = self
            cell.type = .dog
            cell.titleLabel.text = "Anjing \(indexPath.row + 1)"
            
            print("Anjing \(indexPath)")

            return cell
        case 3:
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
        
        let navVc = UINavigationController(rootViewController: sheetVC)
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
        
    }
    
    func cageOptTapped(cell: UICollectionViewCell, atIndexPath: IndexPath) {
        if let totalPriceCell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 2)) as? TotalPriceSummaryCollectionViewCell {
            totalPriceCell.updatePetAmountLabel(amount: ReservationManager.shared.totalPets)
            totalPriceCell.updateDefaultPriceLabel(price: ReservationManager.shared.totalDefaultPrice)
            totalPriceCell.updateAddOnServicePriceLabel(price: ReservationManager.shared.totalAddOnServicePrice)
            totalPriceCell.updateTotalPriceLabel(price: ReservationManager.shared.totalOrder)
        }
    }
    
    func serviceOptTapped(cell: UICollectionViewCell, atIndexPath: IndexPath) {
        if let totalPriceCell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 2)) as? TotalPriceSummaryCollectionViewCell {
            totalPriceCell.updatePetAmountLabel(amount: ReservationManager.shared.totalPets)
            totalPriceCell.updateDefaultPriceLabel(price: ReservationManager.shared.totalDefaultPrice)
            totalPriceCell.updateAddOnServicePriceLabel(price: ReservationManager.shared.totalAddOnServicePrice)
            totalPriceCell.updateTotalPriceLabel(price: ReservationManager.shared.totalOrder)
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

// MARK: Header Date Input Cell
extension ReservationViewController: HeaderDateInputCollectionViewCellDelegate {
    func dateInputBtnTapped(cell: UICollectionViewCell, atIndexPath: IndexPath) {
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
    }
    
    func updateDateLabelText(dateText: String) {
        print(dateText)
    }
}
extension ReservationViewController: CustomDatePickerViewControllerDelegate {
    func datePickerSaveButtonTapped() {
        if let datePickerCell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? HeaderDateInputCollectionViewCell {
            datePickerCell.updateInfoLabel()
        }
    }
}

// MARK: Header Pet Amount Input Cell
extension ReservationViewController: HeaderPetAmountInputCollectionViewCellDelegate {
    
    func petAmountInputBtnTapped(cell: UICollectionViewCell) {
        let petAmountSheetVC = CatsAndDogsCounterViewController()
        petAmountSheetVC.delegate = self
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
    }
}
extension ReservationViewController: CatsAndDogsCounterViewControllerDelegate {
    func saveButtonTapped() {
        if let petAmountCell = self.collectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as? HeaderPetAmountInputCollectionViewCell {
            
            let newCatAmount = AppAccountManager.shared.kucingCount
            let newDogAmount = AppAccountManager.shared.anjingCount
            
            let recentCatAmount = collectionView.numberOfItems(inSection: 1)
            let recentDogAmount = collectionView.numberOfItems(inSection: 2)
            
            var catIndexPaths : [IndexPath] = []
//            var dogIndexPaths : [IndexPath] = []
            
            
            /// Update button info label
            petAmountCell.updateInfoLabel(cats: newCatAmount, dogs: newDogAmount)

            collectionView.performBatchUpdates({
                /// Print data source arrays before changes
                print("Before Update - defaultPrices: \(ReservationManager.shared.catDefaultPrices)")
                print("Before Update - addOnServicePrices: \(ReservationManager.shared.catAddOnServicePrices)")
                
                /// CAT - Update collection view
                if recentCatAmount > newCatAmount {
                    /// Delete kelebihan row
                    for i in (newCatAmount ..< recentCatAmount).reversed() {
                        print("*i: \(i) -> start: \(newCatAmount), end: \(recentCatAmount)")
                        catIndexPaths.append(IndexPath(row: i, section: 1))
                        ReservationManager.shared.updateCatDefaultPrices(indexPath: IndexPath(row: i, section: 1), price: 0)
                        ReservationManager.shared.updateCatAddOnServicePrices(indexPath: IndexPath(row: i, section: 1), price: 0)

                        ReservationManager.shared.catDefaultPrices.removeLast()
                        ReservationManager.shared.catAddOnServicePrices.removeLast()

                        print(ReservationManager.shared.catAddOnServicePrices.count)
                    }
                    collectionView.deleteItems(at: catIndexPaths)
                    collectionView.reloadData()
                } else if recentCatAmount < newCatAmount {
                    /// Tambah row yang kurang
                    for i in recentCatAmount ..< newCatAmount {
                        catIndexPaths.append(IndexPath(row: i, section: 1))
    //                    ReservationManager.shared.defaultPrices.insert(0, at: i)
    //                    ReservationManager.shared.addOnServicePrices.insert(0, at: i)
                        ReservationManager.shared.catDefaultPrices.append(0)
                        ReservationManager.shared.catAddOnServicePrices.append(0)
                        print(i)
                    }
                    // TODO: Kenapa kl action yg atas sync sm yg baru ditambah?
                    collectionView.insertItems(at: catIndexPaths)
    //                collectionView.reloadData()
                    
                    /// Print data source arrays after changes
                    print("After Update - defaultPrices: \(ReservationManager.shared.catDefaultPrices)")
                    print("After Update - addOnServicePrices: \(ReservationManager.shared.catAddOnServicePrices)")

                }
                }, completion: { [self] finished in
                    /// DOG - Update collection view
//                    if recentDogAmount > newDogAmount {
//                        /// Delete kelebihan row
//                        for i in (newDogAmount ..< recentDogAmount).reversed() {
//                            print("*i: \(i) -> start: \(newDogAmount), end: \(recentDogAmount)")
//                            dogIndexPaths.append(IndexPath(row: i, section: 2))
//                            ReservationManager.shared.updateDogDefaultPrices(indexPath: IndexPath(row: i, section: 2), price: 0)
//                            ReservationManager.shared.updateDogAddOnServicePrices(indexPath: IndexPath(row: i, section: 2), price: 0)
//
//                            ReservationManager.shared.dogDefaultPrices.removeLast()
//                            ReservationManager.shared.dogAddOnServicePrices.removeLast()
//
//                            print(ReservationManager.shared.dogAddOnServicePrices.count)
//                        }
//                        collectionView.deleteItems(at: dogIndexPaths)
//                        collectionView.reloadData()
//                    } else if recentDogAmount < newDogAmount {
//                        /// Tambah row yang kurang
//                        for i in recentDogAmount ..< newDogAmount {
//                            dogIndexPaths.append(IndexPath(row: i, section: 2))
//        //                    ReservationManager.shared.defaultPrices.insert(0, at: i)
//        //                    ReservationManager.shared.addOnServicePrices.insert(0, at: i)
//                            ReservationManager.shared.dogDefaultPrices.append(0)
//                            ReservationManager.shared.dogAddOnServicePrices.append(0)
//                            print(i)
//                        }
//                        // TODO: Kenapa kl action yg atas sync sm yg baru ditambah?
//                        collectionView.insertItems(at: dogIndexPaths)
//        //                collectionView.reloadData()
//                    }
//
                    print("pet amount saved")
                    dismiss(animated: true)
                })
            
        
            

            /// Update collection view
//            if recentCatAmount > newCatAmount {
//                /// Delete excess rows
//                let rangeToRemove = newCatAmount..<recentCatAmount
//                catIndexPaths = rangeToRemove.map { IndexPath(row: $0, section: 1) }
//
//                collectionView.performBatchUpdates({
//                    collectionView.deleteItems(at: catIndexPaths)
//                    // Remove corresponding data from the array
//                    ReservationManager.shared.defaultPrices.removeSubrange(rangeToRemove)
//                    ReservationManager.shared.addOnServicePrices.removeSubrange(rangeToRemove)
//                }, completion: nil)
//            } else if recentCatAmount < newCatAmount {
//                /// Add missing rows
//                let rangeToAdd = recentCatAmount..<newCatAmount
//                catIndexPaths = rangeToAdd.map { IndexPath(row: $0, section: 1) }
//
//                collectionView.performBatchUpdates({
//                    collectionView.insertItems(at: catIndexPaths)
//                    // Add corresponding data to the array
//                    ReservationManager.shared.defaultPrices.append(contentsOf: Array(repeating: 0, count: newCatAmount - recentCatAmount))
//                    ReservationManager.shared.addOnServicePrices.append(contentsOf: Array(repeating: 0, count: newCatAmount - recentCatAmount))
//                }, completion: nil)
//            }

           
        }
    }
}


extension ReservationViewController {
    func postRequest() {
        
//        guard let viewModel else { return }
//        
//        var fields = [[String]]()
//        fields.append(["name", viewModel.name])
//        fields.append(["age", viewModel.age.description])
//        fields.append(["bodyMass", viewModel.bodyMass.description])
//        fields.append(["bodyMass", viewModel.bodyMass.description])
//        fields.append(["hasBeenSterilized", viewModel.hasBeenSterilized ? "1": "0"])
//        fields.append(["hasBeenVaccinatedRoutinely", viewModel.hasBeenVaccinatedRoutinely ? "1": "0"])
//        fields.append(["hasBeenFleaFreeRegularly", viewModel.hasBeenFleaFreeRegularly ? "1": "0"])
//        fields.append(["historyOfIllness", viewModel.historyOfIllness])
//        
//        for facility in viewModel.boardingFacilities {
//            fields.append(["boardingFacilities[]", facility])
//        }
//        
//        if viewModel.petHabitIds.count != 0 {
//            for petHabitId in viewModel.petHabitIds {
//                fields.append(["petHabitIds[]", petHabitId])
//            }
//        } else {
//            fields.append(["petHabitIds[]", "PT1781819477"])
//        }
//        
//        fields.append(["petGender", viewModel.petGender])
//        fields.append(["petBreedId", viewModel.petBreedId])
//        
////        for field in fields {
////            print(field)
////        }
//        
//        var multipart = MultipartRequest()
//        
//        for field in fields {
//            multipart.add(key: field[0], value: field[1])
//        }
//
//        if let image = viewModel.image {
//            multipart.add(
//                key: "image",
//                fileName: "\(viewModel.name)_\(UUID().uuidString).png",
//                fileMimeType: "image/png",
//                fileData: image.pngData() ?? Data()
//            )
//        }
//        
//        let url = URL(string: APICaller.Constants.baseAPIURL + "/profile/pets/store")!
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue(
//            "Bearer " + (AuthManager.shared.token ?? "NO-TOKEN"),
//            forHTTPHeaderField: "Authorization"
//        )
//        
//        
//        
//        request.setValue(multipart.httpContentTypeHeaderValue, forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        
//        request.httpBody = multipart.httpBody
//        
//        let task = URLSession.shared.dataTask(with: request) { data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            
//            do {
//                let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print(result)
//            } catch {
//                print(error)
//                print("ERROR WHEN POST PET PROFILE")
//            }
//        }
//        
//        task.resume()
    }
}
