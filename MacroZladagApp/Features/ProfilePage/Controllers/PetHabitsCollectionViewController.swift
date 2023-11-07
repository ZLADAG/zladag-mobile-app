//
//  PetHabitsCollectionViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 06/11/23.
//

import UIKit

class PetHabitsCollectionViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var habits : [Habit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
        self.collectionView.isScrollEnabled = false
        
        self.collectionView.register(PetHabitsCollectionViewCell.self, forCellWithReuseIdentifier: PetHabitsCollectionViewCell.identifier)
    }
    override func loadView() {
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 11
        layout.minimumLineSpacing = 11 // Adjust as needed
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Adjust as needed
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view = collectionView
    }
}

///Collection View Delegate
extension PetHabitsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetHabitsCollectionViewCell.identifier, for: indexPath) as! PetHabitsCollectionViewCell
        
        cell.setUpCell(habitText: habits[indexPath.row].name)
        cell.bounds.size.width = cell.cellWidth
        cell.bounds.size.height = cell.cellHeight
        return cell
    }
    
}
