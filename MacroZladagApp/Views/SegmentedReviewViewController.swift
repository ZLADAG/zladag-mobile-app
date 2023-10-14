//
//  SegmentedReviewViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 14/10/23.
//

import UIKit

class SegmentedReviewViewController: UIViewController {

    var screenSize = UIScreen.main.bounds.size
    
    var label: UILabel!
    
    var reviewCollection: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 150)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
//        collectionView.contentInsetAdjustmentBehavior = .never
//        collectionView.isDirectionalLockEnabled = true
        
//        collectionView.backgroundColor = .customGray2
        
//        layout.itemSize.height = collectionView.contentSize.height
        
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpComponents()
        setUpConstraint()
    }
    
    //MARK: Setup components
    private func setUpComponents() {
        
        self.view.addSubview(reviewCollection)
        configureReviewCollectionView()
    }
    
    //MARK: Setup constraints
    private func setUpConstraint() {
        
//        reviewCollection.frame = self.view.bounds
        NSLayoutConstraint.activate([
            reviewCollection.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 24),
            reviewCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            reviewCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            reviewCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -24),
//            reviewCollection.heightAnchor.constraint(equalToConstant: 600)
        ])

    }
    
    func configureReviewCollectionView(){
        reviewCollection.dataSource = self
        reviewCollection.delegate = self
        reviewCollection.register(BoardingReviewCollectionViewCell.self, forCellWithReuseIdentifier: "boardingReviewCollectionViewCell")
        reviewCollection.alwaysBounceVertical = true
        reviewCollection.sizeToFit()
//        reviewCollection.backgroundColor = .customGray
        
//        for _ in 0..<7 {
//            reviewCollection.append("banner\(Int.random(in: 0...4).description)")
//        }
    }
    
    
    //MARK: Setup Content
    
    
    //MARK: Creation Stacks
    // Stack view
    
    
    //MARK: Creation Label
    // Label
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// Collection view extension
extension SegmentedReviewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
//        print(indexPath.row)
    }
    
}
extension SegmentedReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("helaurr")
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardingReviewCollectionViewCell", for: indexPath) as? BoardingReviewCollectionViewCell {
            
//            let string = photoPaths[indexPath.row]
//            cell.configure(with: string)
//            cell.setUpConstraints()
            
            print("nanonano")
            print("\(String(describing: cell.reviewerName.text))")
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
    
   
}
