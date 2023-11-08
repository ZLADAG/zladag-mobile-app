//
//  PetHabitsCollectionViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 06/11/23.
//

import UIKit


class PetHabitsCollectionViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var habits : [String] = []
    
    public var heightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewLayout.leftAligned()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.alwaysBounceVertical = true
        collectionView.isScrollEnabled = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PetHabitsCollectionViewCell.self, forCellWithReuseIdentifier: PetHabitsCollectionViewCell.identifier)
        
        self.view = collectionView
        heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 100)
        heightConstraint.isActive = true
    }
}

///Collection View Delegate
extension PetHabitsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetHabitsCollectionViewCell.identifier, for: indexPath) as! PetHabitsCollectionViewCell
        
        cell.setUpCell(habitText: habits[indexPath.row])
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

