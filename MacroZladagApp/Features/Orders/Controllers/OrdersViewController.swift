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
        title = "Your Orders"
        
        setupLoadingScreen()
        setupSegmentedControl()
        setupCollectionView()
//        setupEmptyStateView()
        
    }
    
    
    
    func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        setupUnderlineView()
        
        self.filteredOrdersA = viewModel.items.filter({ order in
            return order.section == "active"
        })
        
        self.filteredOrdersB = viewModel.items.filter({ order in
            return order.section == "history"
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
        
        self.segmentedControlYConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        segmentedControlYConstraint.isActive = true
        
        DispatchQueue.main.async {
//            for sbv in self.segmentedControl.subviews {
//                print(sbv)
//                print()
//            }
            
            // ????????
            self.segmentedControl.subviews[0].isHidden = true
            self.segmentedControl.subviews[1].isHidden = true
            self.segmentedControl.subviews[2].isHidden = true
            self.segmentedControl.subviews[3].isHidden = false
            self.segmentedControl.subviews[4].isHidden = false
        }
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
        
        collectionViewActiveColumn.isHidden = false
        collectionViewHistoryColumn.isHidden = true
        
        collectionViewActiveColumn.delegate = self
        collectionViewActiveColumn.dataSource = self
        collectionViewActiveColumn.register(OrderCardCollectionViewCell.self, forCellWithReuseIdentifier: OrderCardCollectionViewCell.identifier)
        
        collectionViewHistoryColumn.delegate = self
        collectionViewHistoryColumn.dataSource = self
        collectionViewHistoryColumn.register(OrderCardCollectionViewCell.self, forCellWithReuseIdentifier: OrderCardCollectionViewCell.identifier)
        
        collectionViewActiveColumn.backgroundColor = .customLightGray242
        collectionViewHistoryColumn.backgroundColor = .customLightGray242
        
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
        
        self.activeColumnXAnchorTrailing = collectionViewActiveColumn.widthAnchor.constraint(equalTo: view.widthAnchor)
        activeColumnXAnchorTrailing.isActive = true
        
        self.historyColumnXAnchorLeading = collectionViewHistoryColumn.leadingAnchor.constraint(equalTo: collectionViewActiveColumn.trailingAnchor)
        historyColumnXAnchorLeading.isActive = true
        
        self.historyColumnXAnchorTrailing = collectionViewHistoryColumn.widthAnchor.constraint(equalTo: view.widthAnchor)
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
    
    func setupEmptyStateView() {
        let imageView = UIImageView(image: UIImage(named: "empty-state-image"))
        let mainLabel = UILabel()
        let subLabel = UILabel()
        
        view.addSubview(imageView)
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 137.28, height: 173)
        
        mainLabel.text = "Belum ada pesanan"
        mainLabel.textColor = .textBlack
        mainLabel.font = .systemFont(ofSize: 24, weight: .bold)
        mainLabel.adjustsFontSizeToFitWidth = true
        mainLabel.sizeToFit()
        
        subLabel.text = "Cari pet hotel untuk anabulmu"
        subLabel.textColor = .customLightGray161
        subLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subLabel.adjustsFontSizeToFitWidth = true
        subLabel.sizeToFit()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 80),
            imageView.widthAnchor.constraint(equalToConstant: imageView.width),
            imageView.heightAnchor.constraint(equalToConstant: imageView.height),
            
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            mainLabel.widthAnchor.constraint(equalToConstant: mainLabel.width),
            mainLabel.heightAnchor.constraint(equalToConstant: mainLabel.height),
            
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 4),
            subLabel.widthAnchor.constraint(equalToConstant: subLabel.width),
            subLabel.heightAnchor.constraint(equalToConstant: subLabel.height)
            
            
        ])
        
    }
    
    // MARK: UIControl functions
    
    @objc func onChangeSegmentedControl(sender: UISegmentedControl) {
        
        let selectedSegmentIndex: Int = sender.selectedSegmentIndex
        let segmentTitle: String = sender.titleForSegment(at: selectedSegmentIndex) ?? ""
        let screenWidth = UIScreen.main.bounds.width
        
        if segmentTitle == "History" {
            UIView.animate(withDuration: 0.25, animations: {
                self.underlineViewXConstraint.constant = CGFloat(selectedSegmentIndex) * UIScreen.main.bounds.width / 2
                
                self.collectionViewHistoryColumn.isHidden = false
                let xOffSet = -(screenWidth * 2) * CGFloat(selectedSegmentIndex) + screenWidth
                
                self.activeColumnXAnchorLeading.constant += xOffSet
                
                self.view.layoutSubviews()
            }) { finished in
                if finished {
                    self.collectionViewActiveColumn.isHidden = true
                }
            }
        } else if segmentTitle == "Active" {
            UIView.animate(withDuration: 0.25, animations: {
                self.underlineViewXConstraint.constant = CGFloat(selectedSegmentIndex) * UIScreen.main.bounds.width / 2
                
                self.collectionViewActiveColumn.isHidden = false
                let xOffSet = (screenWidth * 2) * CGFloat(1 - selectedSegmentIndex) - screenWidth
                
                self.activeColumnXAnchorLeading.constant += xOffSet
                
                self.view.layoutSubviews()
            }) { finished in
                if finished {
                    self.collectionViewHistoryColumn.isHidden = true
                }
            }
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
