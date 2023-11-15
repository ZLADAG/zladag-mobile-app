//
//  OrdersViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import Foundation
import UIKit

class OrdersViewController: UIViewController {
    
    let viewModel = DummyOrders()
    var filteredOrdersA = [DummyOrder]()
    var filteredOrdersB = [DummyOrder]()
    
    let collectionViewActiveColumn: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    let collectionViewHistoryColumn: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    var activeColumnXAnchorLeading = NSLayoutConstraint()
    var activeColumnXAnchorTrailing = NSLayoutConstraint()
    var historyColumnXAnchorLeading = NSLayoutConstraint()
    var historyColumnXAnchorTrailing = NSLayoutConstraint()
    
    let segmentedControl = UISegmentedControl(items: ["Active", "History"])
    var segmentedControlYConstraint = NSLayoutConstraint()
    
    let underlineView = UIView()
    var underlineViewXConstraint = NSLayoutConstraint()
    
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .customOrange
        spinner.backgroundColor = .clear
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.title = "mantap"
        
        setupLoadingScreen()
        setupSegmentedControl()
        setupCollectionView()
        
    }
    
    
    
    func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        setupUnderlineView()
        
        self.filteredOrdersA = viewModel.items.filter({ order in
            return order.status == "active"
        })
        
        self.filteredOrdersB = viewModel.items.filter({ order in
            return order.status == "history"
        })
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16, weight: .medium), .foregroundColor: UIColor.customGrayForIcons], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.textBlack], for: .selected)
        
        segmentedControl.addTarget(self, action: #selector(onChangeSegmentedControl), for: .valueChanged)
        
        // constraints
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        self.segmentedControlYConstraint = segmentedControl.topAnchor.constraint(equalTo: view.topAnchor)
        segmentedControlYConstraint.constant = 100
        segmentedControlYConstraint.isActive = true
    }
    
    func setupUnderlineView() {
        view.addSubview(underlineView)
        underlineView.backgroundColor = .customOrange
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underlineView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            underlineView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 0.5),
            underlineView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        self.underlineViewXConstraint = underlineView.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor)
        underlineViewXConstraint.isActive = true
    }
    
    func setupCollectionView() {
        view.addSubview(collectionViewActiveColumn)
        view.addSubview(collectionViewHistoryColumn)
        
        
        collectionViewActiveColumn.delegate = self
        collectionViewActiveColumn.dataSource = self
        collectionViewActiveColumn.register(OrderCardCollectionViewCell.self, forCellWithReuseIdentifier: OrderCardCollectionViewCell.identifier)
        
        collectionViewHistoryColumn.delegate = self
        collectionViewHistoryColumn.dataSource = self
        collectionViewHistoryColumn.register(OrderCardCollectionViewCell.self, forCellWithReuseIdentifier: OrderCardCollectionViewCell.identifier)
        
        collectionViewActiveColumn.backgroundColor = .customLightGray242
//        collectionViewHistoryColumn.backgroundColor = .customLightGray242
        collectionViewHistoryColumn.backgroundColor = .blue
        
        collectionViewActiveColumn.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        collectionViewHistoryColumn.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
        
        collectionViewActiveColumn.translatesAutoresizingMaskIntoConstraints = false
        collectionViewHistoryColumn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionViewActiveColumn.topAnchor.constraint(equalTo: underlineView.bottomAnchor),
            /* Active Column LEADING ANCHOR */
            /* Active Column TRAILING ANCHOR */
            collectionViewActiveColumn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            collectionViewHistoryColumn.topAnchor.constraint(equalTo: underlineView.bottomAnchor),
            /* History Column LEADING ANCHOR */
            /* History Column TRAILING ANCHOR */
            collectionViewHistoryColumn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.activeColumnXAnchorLeading = collectionViewActiveColumn.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        activeColumnXAnchorLeading.isActive = true
        
        self.activeColumnXAnchorTrailing = collectionViewActiveColumn.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        activeColumnXAnchorTrailing.isActive = true
        
        self.historyColumnXAnchorLeading = collectionViewHistoryColumn.leadingAnchor.constraint(equalTo: collectionViewActiveColumn.trailingAnchor)
        historyColumnXAnchorLeading.isActive = true
        
        self.historyColumnXAnchorTrailing = collectionViewHistoryColumn.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        historyColumnXAnchorTrailing.isActive = true
    }
    
    func setupLoadingScreen() {
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        spinner.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.spinner.stopAnimating()
            self.spinner.hidesWhenStopped = true
        }
    }
    
    // MARK: UIControl functions
    
    @objc func onChangeSegmentedControl(sender: UISegmentedControl) {
        print("collectionViewActiveColumn.isHidden: \(collectionViewActiveColumn.isHidden)")
        print("collectionViewHistoryColumn.isHidden: \(collectionViewHistoryColumn.isHidden)")
        
        
        let selectedSegmentIndex: Int = sender.selectedSegmentIndex
        let segmentTitle: String = sender.titleForSegment(at: selectedSegmentIndex) ?? ""
        let screenWidth = UIScreen.main.bounds.width
        
        if segmentTitle == "History" {
            //        UIView.animate(withDuration: 0.25, animations: {
            UIView.animate(withDuration: 3.25, animations: {
                self.underlineViewXConstraint.constant = CGFloat(selectedSegmentIndex) * UIScreen.main.bounds.width / 2
                
                let xOffSet = -(screenWidth * 2) * CGFloat(selectedSegmentIndex) + screenWidth
                print("aa", xOffSet)
                self.activeColumnXAnchorLeading.constant += xOffSet
                self.activeColumnXAnchorTrailing.constant += xOffSet
                print(self.historyColumnXAnchorLeading.constant)
                print(self.historyColumnXAnchorTrailing.constant)
                
                self.view.layoutSubviews()
            })
        } else if segmentTitle == "Active" {
            UIView.animate(withDuration: 3.25, animations: {
                self.underlineViewXConstraint.constant = CGFloat(selectedSegmentIndex) * UIScreen.main.bounds.width / 2
                
                let xOffSet = (screenWidth * 2) * CGFloat(1) - screenWidth
                print("bb", xOffSet)
                self.activeColumnXAnchorLeading.constant += xOffSet
                self.activeColumnXAnchorTrailing.constant += xOffSet
                
                self.historyColumnXAnchorLeading.constant = 0
                self.historyColumnXAnchorTrailing.constant = 0
                
                self.view.layoutSubviews()
            })
        }
        
    }
    
}

extension OrdersViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView === collectionViewActiveColumn {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCardCollectionViewCell.identifier, for: indexPath) as! OrderCardCollectionViewCell
            cell.configure(viewModel: self.filteredOrdersA[indexPath.row])
            return cell
            
        } else if collectionView === collectionViewHistoryColumn {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCardCollectionViewCell.identifier, for: indexPath) as! OrderCardCollectionViewCell
            cell.configure(viewModel: self.filteredOrdersB[indexPath.row])
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView === collectionViewActiveColumn {
            return self.filteredOrdersA.count
            
        } else if collectionView === collectionViewHistoryColumn {
            return self.filteredOrdersB.count
            
        } else {
            return 99
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 342, height: 141)
    }
    
}
