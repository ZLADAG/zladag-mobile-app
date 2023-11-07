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
    
    public var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewLayout.leftAligned()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.alwaysBounceVertical = true
        collectionView.isScrollEnabled = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PetFacilityPrefCollectionViewCell.self, forCellWithReuseIdentifier: PetFacilityPrefCollectionViewCell.identifier)
        
        self.view = collectionView
        heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 100)
        heightConstraint.isActive = true
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            heightConstraint.isActive = false
            let contentSize = layout.collectionViewContentSize
            
            /// Update the height constraint of the collectionView
            heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: contentSize.height)
            heightConstraint.isActive = true
            
            /// Optionally, update the frame of the view (if needed)
            view.frame.size.height = contentSize.height
            view.layoutIfNeeded()
        }
    }
    
}
