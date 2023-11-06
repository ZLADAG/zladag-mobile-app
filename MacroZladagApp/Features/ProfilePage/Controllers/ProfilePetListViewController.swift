//
//  PetProfilesViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 02/11/23.
//

import UIKit

class ProfilePetListViewController: UIViewController {
    
    var screenSize = UIScreen.main.bounds.size
    var profileCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpComponents()
        
//        profileCollection.dataSource = self
//        profileCollection.delegate = self
//        profileCollection.register(PetProfileCollectionViewCell.self, forCellWithReuseIdentifier: "petProfileCollectionViewCell")
        
    }
    
    //MARK: Setup components
    private func setUpComponents() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 150)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        
        profileCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        profileCollection.translatesAutoresizingMaskIntoConstraints = false
        profileCollection.alwaysBounceVertical = true
        profileCollection.sizeToFit()
//        profileCollection.isScrollEnabled = false
        //        profileCollection.contentInsetAdjustmentBehavior = .never
        //        profileCollection.isDirectionalLockEnabled = true
        
        self.view.addSubview(profileCollection)
        //        profileCollection.backgroundColor = .customBlue

        profileCollection.backgroundColor = .customBlue
        setUpConstraint()

    }
    
    
    //MARK: Setup constraints
    private func setUpConstraint() {
        
        //        profileCollection.frame = self.view.bounds
        NSLayoutConstraint.activate([
            profileCollection.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            profileCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            profileCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            profileCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            //            profileCollection.heightAnchor.constraint(equalToConstant: 150)
        ])
        
    }
    
    
}

//
////MARK: Collection view extension
//extension ProfilePetListViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
//    }
//
//}
//extension ProfilePetListViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "petProfileCollectionViewCell", for: indexPath) as? PetProfileCollectionViewCell {
//
//            let content = ProfilePhotoWithTitle(profileType: .user, img: "banner1", title: "Michelle", detailName: "Anjing", age: 1)
//
//            cell.content = ProfilePhotoWithTitle(profileType: .user, img: "banner1", title: "Michelle", detailName: "Anjing", age: 1)
//            print("HAHAHA")
//            print(cell.content)
//            //            let string = photoPaths[indexPath.row]
//            //            cell.configure(with: string)
//            //            cell.setUpConstraints()
//
//            //            print("nanonano") // NANO NANO MANIS ASAM ASIN RAMAI RASANYA!
//            //            print("\(String(describing: cell.reviewerName.text))")
//            return cell
//        }
//        fatalError("Unable to dequeue subclassed cell")
//    }
//}
//
//extension ProfilePetListViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        // Calculate the size based on your cell content
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "petProfileCollectionViewCell", for: indexPath) as! PetProfileCollectionViewCell
//        // Configure yourCell with the data at indexPath
//        //        cell.configure(with: yourData[indexPath.row])
//        //        cell.configure()
//
////        let content = ProfilePhotoWithTitle(profileType: .pet, img: "banner0", title: "Michelle", detailName: "Kucing", age: 5)
////        cell.configureContent(content)
//
//        cell.layoutIfNeeded()
//        let size = cell.contentView.systemLayoutSizeFitting(CGSize(width: screenSize.width, height: UIView.layoutFittingCompressedSize.height))
//        return size
//    }
//}
