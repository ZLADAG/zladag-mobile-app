//
//  FacilityPrefCollectionViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 06/11/23.
//

import UIKit


class PetFacilityPrefCollectionViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var facilitiesPref : [Facility] = []
    
    var viewHeight = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlue
        let layout = UICollectionViewLayout.leftAligned()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .brown // Set your desired background color
//        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView.alwaysBounceVertical = true
        collectionView.isScrollEnabled = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PetFacilityPrefCollectionViewCell.self, forCellWithReuseIdentifier: PetFacilityPrefCollectionViewCell.identifier)
        
       
        
//        view.addSubview(collectionView)
        self.view = collectionView
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        view.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
//        view.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
//        
//        
//        collectionView.setContentCompressionResistancePriority(.required, for: .vertical)
//        collectionView.setContentHuggingPriority(.required, for: .vertical)
        
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
////            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
////            collectionView.heightAnchor.constraint(equal),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//        ])
        
        //
        //        self.collectionView.dataSource = self
        //        self.collectionView.delegate = self
        //
        //        self.collectionView.alwaysBounceVertical = true
        //        self.collectionView.backgroundColor = .white
        //
        //        self.collectionView.register(PetFacilityPrefCollectionViewCell.self, forCellWithReuseIdentifier: PetFacilityPrefCollectionViewCell.identifier)
        //
        //        collectionView.backgroundColor = .customBlue
        //        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        //
        view.backgroundColor = .customGray
        //
        ////        view.addSubview(collectionView)
        //
        //        NSLayoutConstraint.activate([
        //            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
        //            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        //            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        //            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        //        ])
        
    }
    //    override func loadView() {
    //        let layout = UICollectionViewLayout.leftAligned()
    //        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    //        collectionView.backgroundColor = .customBlue
    //        self.view = collectionView
    //    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        
        viewHeight = collectionView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
//        print(viewHeight)
            // Calculate the content size of the collection view
//            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                let contentSize = layout.collectionViewContentSize
//                // Update the view controller's view frame to match the content size
//                view.frame = CGRect(origin: view.frame.origin, size: contentSize)
//
//                viewHeight = contentSize.height
//                print(viewHeight)
//            }
        }
    
}

extension PetFacilityPrefCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        facilitiesPref.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetFacilityPrefCollectionViewCell.identifier, for: indexPath) as! PetFacilityPrefCollectionViewCell
        
        let content = ProfileIconLabel(iconName: "facility-vet-icon", titleName: facilitiesPref[indexPath.row].name, type: .facilityTag)
        cell.setUpCell(content: content)
        cell.bounds.size.width = cell.cellWidth
        cell.bounds.size.height = cell.cellHeight
        return cell
    }
    
}
