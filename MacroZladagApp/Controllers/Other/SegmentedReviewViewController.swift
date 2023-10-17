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
    
    var reviewCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Calculate the total content height
//        let totalContentHeight = 0.0// Calculate the height based on your content
//
//        // Set the frame of the subview
//        self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: totalContentHeight)

        // Calculate content size
//        let fittingSize = self.view.systemLayoutSizeFitting(
//            UIView.layoutFittingCompressedSize
//        )
//        print("fittingSize: \(fittingSize)")
//
//        // Set the frame of the view
//        self.view.frame = CGRect(
//            origin: self.view.frame.origin,
//            size: fittingSize
//        )
        
        setUpComponents()
        setUpConstraint()
    }
    
    //MARK: Setup components
    private func setUpComponents() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 150)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
        reviewCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        reviewCollection.translatesAutoresizingMaskIntoConstraints = false
       
        reviewCollection.isScrollEnabled = false
//        reviewCollection.contentInsetAdjustmentBehavior = .never
//        reviewCollection.isDirectionalLockEnabled = true
            
        self.view.addSubview(reviewCollection)
//        reviewCollection.backgroundColor = .customBlue
        configureReviewCollectionView()
    }
    
    //MARK: Setup constraints
    private func setUpConstraint() {
        
//        reviewCollection.frame = self.view.bounds
        NSLayoutConstraint.activate([
            reviewCollection.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 24),
            reviewCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            reviewCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -0),
            reviewCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -24),
//            reviewCollection.heightAnchor.constraint(equalToConstant: 150)
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
        
        
        calculateCellHeights()
        
        // Register your custom cell
        reviewCollection.register(BoardingReviewCollectionViewCell.self, forCellWithReuseIdentifier: "boardingReviewCollectionViewCell")

        // Set up your data source
        reviewCollection.dataSource = self
        reviewCollection.delegate = self
        reviewCollection.reloadData()
        
    }
    private func calculateCellHeights() {
        var items: [String] = ["1", "2", "3", "4", "5", "6"]
        for (index, item) in items.enumerated() {
            // Instantiate a cell from the collection view, set its content, and calculate the height
            if let cell = reviewCollection.dequeueReusableCell(withReuseIdentifier: "boardingReviewCollectionViewCell", for: IndexPath(item: index, section: 0)) as? BoardingReviewCollectionViewCell {
                cell.configure()
//                cell.configure(with: item)
                cell.layoutIfNeeded()
                cell.heightAnchor.constraint(equalToConstant: cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height).isActive = true
//                let cellHeight = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
//                item.height = cellHeight // Store the calculated height in your data model
            }
        }
        
        // Reload the collection view to reflect the updated cell heights
        reviewCollection.reloadData()
    }
    
//    private func calculateContentHeight() {
//        // Disable scrolling in the table view if needed
//        reviewCollection.isScrollEnabled = false
//
//        // Calculate content size for each cell
//        for indexPath in 0..<5 {
//            if let cell = reviewCollection.cellForItem(at: indexPath) as? BoardingReviewCollectionViewCell {
//                // Calculate height based on cell content
//                let fittingSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
//
//                // Update the cell's frame
//                cell.frame = CGRect(origin: cell.frame.origin, size: fittingSize)
//            }
//        }
//    }
    
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

//MARK: Collection view extension
extension SegmentedReviewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
    
}
extension SegmentedReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("helaurr")
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardingReviewCollectionViewCell", for: indexPath) as? BoardingReviewCollectionViewCell {
            
//            let string = photoPaths[indexPath.row]
//            cell.configure(with: string)
//            cell.setUpConstraints()
            
//            print("nanonano") // NANO NANO MANIS ASAM ASIN RAMAI RASANYA!
//            print("\(String(describing: cell.reviewerName.text))")
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}

extension SegmentedReviewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate the size based on your cell content
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardingReviewCollectionViewCell", for: indexPath) as! BoardingReviewCollectionViewCell
        // Configure yourCell with the data at indexPath
//        cell.configure(with: yourData[indexPath.row])
//        cell.configure()
        cell.layoutIfNeeded()
        let size = cell.contentView.systemLayoutSizeFitting(CGSize(width: screenSize.width, height: UIView.layoutFittingCompressedSize.height))
        return size
    }
}
