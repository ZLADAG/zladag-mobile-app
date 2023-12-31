//
//  OrdersViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import UIKit

class OrdersViewController: UIViewController {
    
    var activeColumnViewModels = [OrdersViewModel]()
    var historyColumnViewModels = [OrdersViewModel]()
    
    // MARK: COLLECTION VIEWS
    
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
    var activeColumnWidthConstraint = NSLayoutConstraint()
    
    var historyColumnXAnchorLeading = NSLayoutConstraint()
    var historyColumnWidthConstraint = NSLayoutConstraint()
    
    let activeCollectionViewRefreshControl = UIRefreshControl()
    let historyCollectionViewRefreshControl = UIRefreshControl()
    
    
    // MARK: Segmented Control
    
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
        navigationItem.title = "Your Orders"
        
        setupLoadingScreen()
        fetchData(completion: { [weak self] in
            self?.setupSegmentedControl()
            self?.setupCollectionView()
            
            self?.spinner.hidesWhenStopped = true
            self?.spinner.stopAnimating()
        })
        
    }
    
    func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        setupUnderlineView()
        
        segmentedControl.backgroundColor = .white
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            for view in self.segmentedControl.subviews {
                let viewDesc: String = view.description
                
                if !(viewDesc.contains("UISegment")) {
                    view.isHidden = true
                }
            }
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
        
        // default state: hide "History" column
        collectionViewActiveColumn.isHidden = false
        collectionViewHistoryColumn.isHidden = true
        
        collectionViewActiveColumn.showsVerticalScrollIndicator = false
        collectionViewHistoryColumn.showsVerticalScrollIndicator = false
        
        // collection view setups
        collectionViewActiveColumn.delegate = self
        collectionViewActiveColumn.dataSource = self
        collectionViewActiveColumn.register(OrderCardCollectionViewCell.self, forCellWithReuseIdentifier: OrderCardCollectionViewCell.identifier)
        collectionViewActiveColumn.register(EmptyOrderCollectionViewCell.self, forCellWithReuseIdentifier: EmptyOrderCollectionViewCell.identifier)
        
        collectionViewHistoryColumn.delegate = self
        collectionViewHistoryColumn.dataSource = self
        collectionViewHistoryColumn.register(OrderCardCollectionViewCell.self, forCellWithReuseIdentifier: OrderCardCollectionViewCell.identifier)
        collectionViewHistoryColumn.register(EmptyOrderCollectionViewCell.self, forCellWithReuseIdentifier: EmptyOrderCollectionViewCell.identifier)
        
        // refresh control
        activeCollectionViewRefreshControl.addTarget(self, action: #selector(onPullRefresh), for: .valueChanged)
        historyCollectionViewRefreshControl.addTarget(self, action: #selector(onPullRefresh), for: .valueChanged)
        
        collectionViewActiveColumn.refreshControl = activeCollectionViewRefreshControl
        collectionViewHistoryColumn.refreshControl = historyCollectionViewRefreshControl
        
        // collection view stylings
        collectionViewActiveColumn.backgroundColor = .customLightGray242
        collectionViewHistoryColumn.backgroundColor = .customLightGray242
        
        collectionViewActiveColumn.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        collectionViewHistoryColumn.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
        collectionViewActiveColumn.translatesAutoresizingMaskIntoConstraints = false
        collectionViewHistoryColumn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionViewActiveColumn.topAnchor.constraint(equalTo: underlineView.bottomAnchor),
            /* "Active" Column LEADING ANCHOR */
            /* "Active" Column TRAILING ANCHOR */
            collectionViewActiveColumn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            collectionViewHistoryColumn.topAnchor.constraint(equalTo: underlineView.bottomAnchor),
            /* "History" Column LEADING ANCHOR */
            /* "History" Column TRAILING ANCHOR */
            collectionViewHistoryColumn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // "Active" Column
        self.activeColumnXAnchorLeading = collectionViewActiveColumn.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        activeColumnXAnchorLeading.isActive = true
        
        self.activeColumnWidthConstraint = collectionViewActiveColumn.widthAnchor.constraint(equalTo: view.widthAnchor)
        activeColumnWidthConstraint.isActive = true
        
        // "History" Column
        self.historyColumnXAnchorLeading = collectionViewHistoryColumn.leadingAnchor.constraint(equalTo: collectionViewActiveColumn.trailingAnchor)
        historyColumnXAnchorLeading.isActive = true
        
        self.historyColumnWidthConstraint = collectionViewHistoryColumn.widthAnchor.constraint(equalTo: view.widthAnchor)
        historyColumnWidthConstraint.isActive = true
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
    }
    
    // MARK: NOT SIGNED IN SETUPS
    
    func setupNotSignedInView() {
        let imageView = UIImageView(image: UIImage(named: "empty-state-image"))
        let mainLabel = UILabel()
        let subLabel = UILabel()
        
        view.addSubview(imageView)
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        
        imageView.contentMode = .scaleAspectFill
        imageView.frame.size = CGSize(width: 173, height: 173)
        
        mainLabel.text = "Kamu belum log in"
        mainLabel.textColor = .textBlack
        mainLabel.font = .systemFont(ofSize: 24, weight: .bold)
        mainLabel.sizeToFit()
        
        subLabel.text = "Yuk log in untuk akses fitur lengkap catnip"
        subLabel.textColor = .customGrayForLabels
        subLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subLabel.sizeToFit()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 112),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageView.width),
            imageView.heightAnchor.constraint(equalToConstant: imageView.height),
            
            mainLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.widthAnchor.constraint(equalToConstant: mainLabel.width),
            mainLabel.heightAnchor.constraint(equalToConstant: mainLabel.height),
            
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 4),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.widthAnchor.constraint(equalToConstant: subLabel.width),
            subLabel.heightAnchor.constraint(equalToConstant: subLabel.height),
        ])
        
        let masukButton = UIButton()
        let buatAkunLabel = UILabel()
        let buatAkunButton = UIButton()
        
        view.addSubview(masukButton)
        view.addSubview(buatAkunLabel)
        view.addSubview(buatAkunButton)
        
        masukButton.setTitle("Masuk", for: .normal)
        masukButton.setTitleColor(.white, for: .normal)
        masukButton.backgroundColor = .customOrange
        masukButton.layer.cornerRadius = 4
        masukButton.layer.masksToBounds = true
        
        buatAkunLabel.text = "Belum punya akun?"
        buatAkunLabel.font = .systemFont(ofSize: 14, weight: .medium)
        buatAkunLabel.textColor = .textBlack
        buatAkunLabel.sizeToFit()
        
        buatAkunButton.backgroundColor = .clear
        let label = UILabel()
        label.text = "Buat akun"
        label.textColor = .customOrange
        label.font = buatAkunLabel.font
        label.sizeToFit()
        buatAkunButton.addSubview(label)
        
        masukButton.translatesAutoresizingMaskIntoConstraints = false
        buatAkunLabel.translatesAutoresizingMaskIntoConstraints = false
        buatAkunButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            masukButton.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 62),
            masukButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            masukButton.widthAnchor.constraint(equalToConstant: 342),
            masukButton.heightAnchor.constraint(equalToConstant: 44),
            
            buatAkunLabel.topAnchor.constraint(equalTo: masukButton.bottomAnchor, constant: 8),
            buatAkunLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),
            buatAkunLabel.widthAnchor.constraint(equalToConstant: buatAkunLabel.width),
            buatAkunLabel.heightAnchor.constraint(equalToConstant: buatAkunLabel.height),
            
            buatAkunButton.topAnchor.constraint(equalTo: buatAkunLabel.topAnchor),
            buatAkunButton.leadingAnchor.constraint(equalTo: buatAkunLabel.trailingAnchor, constant: 2),
            buatAkunButton.widthAnchor.constraint(equalToConstant: label.width),
            buatAkunButton.heightAnchor.constraint(equalToConstant: label.height),
        ])
        
        masukButton.addTarget(self, action: #selector(onClickMasukButton), for: .touchUpInside)
        buatAkunButton.addTarget(self, action: #selector(onClickBuatAkunButton), for: .touchUpInside)
    }
    
    @objc func onClickMasukButton() {
        let signInVC = SignInViewController()
        signInVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @objc func onClickBuatAkunButton() {
        let signUpVC = CreateAccountViewController()
        signUpVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
    // MARK: @objc UIControl functions
    
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
            }) { _ in // FINISHED
                self.collectionViewActiveColumn.isHidden = true
            }
        } else if segmentTitle == "Active" {
            UIView.animate(withDuration: 0.25, animations: {
                self.underlineViewXConstraint.constant = CGFloat(selectedSegmentIndex) * UIScreen.main.bounds.width / 2
                
                self.collectionViewActiveColumn.isHidden = false
                let xOffSet = (screenWidth * 2) * CGFloat(1 - selectedSegmentIndex) - screenWidth
                
                self.activeColumnXAnchorLeading.constant += xOffSet
                
                self.view.layoutSubviews()
            }) { _ in // FINISHED
                self.collectionViewHistoryColumn.isHidden = true
            }
        }
    }
    
    @objc func onPullRefresh(sender: UIRefreshControl) {
        sender.beginRefreshing()
        
        fetchData {
            sender.endRefreshing()
        }
    }
    
    func fetchData(completion: (() -> ())? = nil) {
        
        var success1 = false
        var success2 = false
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        
        APICaller.shared.getProfileOrders(isActive: true) { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let response):
                self.activeColumnViewModels = response.data.compactMap({ orderDetails in
                    return OrdersViewModel(
                        id: orderDetails.id,
                        boarding: orderDetails.boarding,
                        pet: orderDetails.pet,
                        checkInDate: orderDetails.checkInDate,
                        checkOutDate: orderDetails.checkOutDate,
                        status: orderDetails.status
                    )
                })
                
                success1 = true
                
                
                break
            case .failure(let error):
                success1 = false
                print("ERROR WHEN FETCHING /profile/orders?active=true")
                print("\(error)\n")
                break
            }
        }
        
        APICaller.shared.getProfileOrders(isActive: false) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let response):
                self.historyColumnViewModels = response.data.compactMap({ orderDetails in
                    return OrdersViewModel(
                        id: orderDetails.id,
                        boarding: orderDetails.boarding,
                        pet: orderDetails.pet,
                        checkInDate: orderDetails.checkInDate,
                        checkOutDate: orderDetails.checkOutDate,
                        status: orderDetails.status
                    )
                })
                
                success2 = true
                break
            case .failure(let error):
                success2 = false
                print("ERROR WHEN FETCHING /profile/orders?active=false")
                print("\(error)\n")
                break
            }
        }
        
        group.notify(queue: .main) {
            if (success1 && success2) {
                
                DispatchQueue.main.async {
                    self.collectionViewHistoryColumn.reloadData()
                    self.collectionViewActiveColumn.reloadData()
                }
                
                completion?()
            } else {
                self.setupNotSignedInView()
                self.spinner.hidesWhenStopped = true
                self.spinner.stopAnimating()
            }
            
        }
    }
    
}

// MARK: COLLECTION VIEWS

extension OrdersViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView === collectionViewActiveColumn {
            
            if !(activeColumnViewModels.isEmpty) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCardCollectionViewCell.identifier, for: indexPath) as! OrderCardCollectionViewCell
                cell.configure(viewModel: self.activeColumnViewModels[indexPath.row])
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyOrderCollectionViewCell.identifier, for: indexPath) as! EmptyOrderCollectionViewCell
                return cell
            }
            
        } else if collectionView === collectionViewHistoryColumn {
            
            if !(historyColumnViewModels.isEmpty) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCardCollectionViewCell.identifier, for: indexPath) as! OrderCardCollectionViewCell
                cell.configure(viewModel: self.historyColumnViewModels[indexPath.row])
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyOrderCollectionViewCell.identifier, for: indexPath) as! EmptyOrderCollectionViewCell
                return cell
            }
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView === collectionViewActiveColumn {
            if !(self.activeColumnViewModels.isEmpty) {
                return self.activeColumnViewModels.count
            } else {
                return 1
            }
        } else if collectionView === collectionViewHistoryColumn {
            if !(self.historyColumnViewModels.isEmpty) {
                return self.historyColumnViewModels.count
            } else {
                return 1
            }
            
        } else {
            return 99
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView === collectionViewActiveColumn {
            if !(self.activeColumnViewModels.isEmpty) {
                return CGSize(width: 342, height: 141)
            } else {
                return CGSize(width: view.width, height: view.height)
            }
        } else if collectionView === collectionViewHistoryColumn {
            if !(self.historyColumnViewModels.isEmpty) {
                return CGSize(width: 342, height: 141)
            } else {
                return CGSize(width: 350, height: 500)
            }
            
        } else {
            return CGSize(width: 999, height: 999)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === collectionViewActiveColumn {
            
            if !(activeColumnViewModels.isEmpty) {
                let vc = OrderDetailsViewController(orderId: activeColumnViewModels[indexPath.row].id)
                vc.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        } else if collectionView === collectionViewHistoryColumn {
            
            if !(historyColumnViewModels.isEmpty) {
                let vc = OrderDetailsViewController(orderId: historyColumnViewModels[indexPath.row].id)
                vc.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    
}

// MARK: MISTIS (2)

// ????????
// self.segmentedControl.subviews[0].isHidden = true
// self.segmentedControl.subviews[1].isHidden = true
// self.segmentedControl.subviews[2].isHidden = true
// self.segmentedControl.subviews[3].isHidden = false
// self.segmentedControl.subviews[4].isHidden = false

/*

    <
    UIImageView: 0x12f82de00;
    frame = (0 0; 194 41);
    hidden = YES;
    opaque = NO;
    userInteractionEnabled = NO;
    layer = <CALayer: 0x600003f5dd60>
    >

    <
    UIImageView: 0x12f82ece0;
    frame = (195 0; 195 41);
    hidden = YES;
    opaque = NO;
    userInteractionEnabled = NO;
    layer = <CALayer: 0x600003f5f3a0>
    >

    <
    UIImageView: 0x12ed206d0;
    frame = (-3 -3; 200 47);
    hidden = YES;
    opaque = NO;
    userInteractionEnabled = NO;
    layer = <CALayer: 0x600003f4f340>
    >

    <
    UISegment: 0x12f82dff0;
    frame = (195 0; 195 41);
    opaque = NO;
    layer = <CALayer: 0x600003f5e320>
    >

    <
    UISegment: 0x12f82cfe0;
    frame = (0 0; 194 41);
    opaque = NO;
    layer = <CALayer: 0x600003f5c6a0>
    >

 */
