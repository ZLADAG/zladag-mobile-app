//
//  CatsAndDogsCounterViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 09/10/23.
//

import UIKit

protocol CatsAndDogsCounterViewControllerDelegate {
    func saveButtonTapped()
}
class CatsAndDogsCounterViewController: UIViewController {

    var delegate: CatsAndDogsCounterViewControllerDelegate?
    
    var mainHeaderDelegate: MainHeaderCollectionReusableView?
    var controllerDelegate: SearchResultsViewController?
    var ubahControllerDelegate: UbahPencarianViewController?
    
    let kucingLabel: UILabel = {
        let label = UILabel()
        label.text = "Kucing"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .textBlack
        label.sizeToFit()
        return label
    }()
    
    let anjingLabel: UILabel = {
        let label = UILabel()
        label.text = "Anjing"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .textBlack
        label.sizeToFit()
        return label
    }()
    
    public var kucingCount: Int = AppAccountManager.shared.kucingCount
    public var anjingCount: Int = AppAccountManager.shared.anjingCount
    
    lazy var kucingCountLabel: UILabel = {
        let label = UILabel()
        label.text = AppAccountManager.shared.kucingCount.description
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .textBlack
        label.textAlignment = .center
        return label
    }()
    
    lazy var anjingCountLabel: UILabel = {
        let label = UILabel()
        label.text = AppAccountManager.shared.anjingCount.description
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .textBlack
        return label
    }()
    
    let incrementKucingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let incrementAnjingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let decrementKucingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let decrementAnjingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let simpanButton: UIButton = {
        let button = UIButton()
        let label = UILabel()
        label.text = "Simpan"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        button.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 150).isActive = true
        label.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        button.backgroundColor = .customOrange
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.anjingCount = AppAccountManager.shared.anjingCount
        self.kucingCount = AppAccountManager.shared.kucingCount
        
        view.addSubview(anjingLabel)
        view.addSubview(incrementAnjingButton)
        view.addSubview(decrementAnjingButton)
        view.addSubview(anjingCountLabel)
        
        view.addSubview(kucingLabel)
        view.addSubview(incrementKucingButton)
        view.addSubview(decrementKucingButton)
        view.addSubview(kucingCountLabel)
        
        view.addSubview(simpanButton)
        
        setupNavBar()
        setupButtons()
        simpanButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
    }
    
    func setupNavBar() {
        let navView = UIView()
        navView.frame = CGRect(x: 0, y: 0, width: 354, height: 32)
        navView.backgroundColor = .white
        
        let navLabel = UILabel()
        navLabel.text = "Jumlah anabul"
        navLabel.textColor = .textBlack
        navLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        navLabel.frame = CGRect(x: 0, y: (32 - 23) / 2, width: 290, height: 23)
        
        navView.addSubview(navLabel)
        
        let closeButton = UIButton()
        let closeButtonImageView = UIImageView(image: UIImage(named: "sheet-close-button"))
        closeButtonImageView.contentMode = .scaleAspectFit
        closeButtonImageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        closeButtonImageView.layer.opacity = 0.8
        closeButton.addSubview(closeButtonImageView)
        closeButton.frame = CGRect(x: navView.frame.maxX - 32, y: 0, width: 32, height: 32)
        navView.addSubview(closeButton)
        
        closeButton.addTarget(self, action: #selector(closeSheet), for: .touchUpInside)
        navigationItem.titleView = navView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }
    
    func setupConstraints() {
        anjingLabel.translatesAutoresizingMaskIntoConstraints = false
        kucingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        kucingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        anjingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        incrementKucingButton.translatesAutoresizingMaskIntoConstraints = false
        incrementAnjingButton.translatesAutoresizingMaskIntoConstraints = false
        decrementKucingButton.translatesAutoresizingMaskIntoConstraints = false
        decrementAnjingButton.translatesAutoresizingMaskIntoConstraints = false
        
        simpanButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            kucingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            kucingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            kucingLabel.widthAnchor.constraint(equalToConstant: kucingLabel.width),
            kucingLabel.heightAnchor.constraint(equalToConstant: kucingLabel.height),
            
            anjingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            anjingLabel.topAnchor.constraint(equalTo: kucingLabel.bottomAnchor, constant: 29),
            anjingLabel.widthAnchor.constraint(equalToConstant: anjingLabel.width),
            anjingLabel.heightAnchor.constraint(equalToConstant: anjingLabel.height),
            
            // kucing counter
            incrementKucingButton.centerYAnchor.constraint(equalTo: kucingLabel.centerYAnchor),
            incrementKucingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            incrementKucingButton.widthAnchor.constraint(equalToConstant: 32),
            incrementKucingButton.heightAnchor.constraint(equalToConstant: 32),
            
            kucingCountLabel.trailingAnchor.constraint(equalTo: incrementKucingButton.leadingAnchor, constant: -16),
            kucingCountLabel.centerYAnchor.constraint(equalTo: kucingLabel.centerYAnchor),
            kucingCountLabel.widthAnchor.constraint(equalToConstant: 25),
            kucingCountLabel.heightAnchor.constraint(equalToConstant: 17),
            
            decrementKucingButton.centerYAnchor.constraint(equalTo: kucingLabel.centerYAnchor),
            decrementKucingButton.trailingAnchor.constraint(equalTo: kucingCountLabel.leadingAnchor, constant: -16),
            decrementKucingButton.widthAnchor.constraint(equalToConstant: 32),
            decrementKucingButton.heightAnchor.constraint(equalToConstant: 32),
            
            // anjing counter
            incrementAnjingButton.centerYAnchor.constraint(equalTo: anjingLabel.centerYAnchor),
            incrementAnjingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            incrementAnjingButton.widthAnchor.constraint(equalToConstant: 32),
            incrementAnjingButton.heightAnchor.constraint(equalToConstant: 32),
            
            anjingCountLabel.trailingAnchor.constraint(equalTo: incrementAnjingButton.leadingAnchor, constant: -16),
            anjingCountLabel.centerYAnchor.constraint(equalTo: anjingLabel.centerYAnchor),
            anjingCountLabel.widthAnchor.constraint(equalToConstant: 25),
            anjingCountLabel.heightAnchor.constraint(equalToConstant: 17),
            
            decrementAnjingButton.centerYAnchor.constraint(equalTo: anjingLabel.centerYAnchor),
            decrementAnjingButton.trailingAnchor.constraint(equalTo: anjingCountLabel.leadingAnchor, constant: -16),
            decrementAnjingButton.widthAnchor.constraint(equalToConstant: 32),
            decrementAnjingButton.heightAnchor.constraint(equalToConstant: 32),
            
            simpanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            simpanButton.topAnchor.constraint(equalTo: anjingLabel.bottomAnchor, constant: 30.5),
            simpanButton.widthAnchor.constraint(equalToConstant: 342),
            simpanButton.heightAnchor.constraint(equalToConstant: 44),

        ])
    }
    
    func setupButtons() {
        print("OKE")
        let anjingCount = Int(anjingCountLabel.text ?? "0")!
        let kucingCount = Int(kucingCountLabel.text ?? "0")!
        
        decrementAnjingButton.setImage(UIImage(named: "decrement-button"), for: .normal)
        if anjingCount == 0 {
            decrementAnjingButton.imageView?.tintColor = .lightGray.withAlphaComponent(0.6)

        } else {
            decrementAnjingButton.imageView?.tintColor = .customOrange
        }
        incrementAnjingButton.setImage(UIImage(named: "increment-button"), for: .normal)
        incrementAnjingButton.imageView?.tintColor = .customOrange
        
        decrementKucingButton.setImage(UIImage(named: "decrement-button"), for: .normal)
        if kucingCount == 0 {
            decrementKucingButton.imageView?.tintColor = .lightGray.withAlphaComponent(0.6)
        } else {
            decrementKucingButton.imageView?.tintColor = .customOrange
        }
        incrementKucingButton.setImage(UIImage(named: "increment-button"), for: .normal)
        incrementKucingButton.imageView?.tintColor = .customOrange
        
        
        // OBJC FUNCTIONS
        decrementKucingButton.addTarget(self, action: #selector(catDecrementButton), for: .touchUpInside)
        incrementKucingButton.addTarget(self, action: #selector(catIncrementButton), for: .touchUpInside)
        
        decrementAnjingButton.addTarget(self, action: #selector(dogDecrementButton), for: .touchUpInside)
        incrementAnjingButton.addTarget(self, action: #selector(dogIncrementButton), for: .touchUpInside)
        
    }
    
    @objc func closeSheet() {
        mainHeaderDelegate?.delegate?.dismiss(animated: true)
        
        if let controllerDelegate {
            dismiss(animated: true)
        }
    }
    
    @objc func catDecrementButton() {
        if self.kucingCount > 0 {
            self.kucingCount -= 1
            kucingCountLabel.text = self.kucingCount.description
        }
        
        if kucingCount == 0 {
            decrementKucingButton.imageView?.tintColor = .lightGray.withAlphaComponent(0.6)
        }
        
//        AppAccountManager.shared.kucingCount = self.kucingCount
    }
    
    @objc func catIncrementButton() {
        if self.kucingCount < 1 {
            self.kucingCount += 1            
        }
        kucingCountLabel.text = self.kucingCount.description
        decrementKucingButton.imageView?.tintColor = .customOrange
        decrementKucingButton.imageView?.layer.opacity = 1.0
        
//        AppAccountManager.shared.kucingCount = self.kucingCount
    }
    
    @objc func dogDecrementButton() {
        if self.anjingCount > 0 {
            self.anjingCount -= 1
            anjingCountLabel.text = self.anjingCount.description
        }
        
        if anjingCount == 0 {
            decrementAnjingButton.imageView?.tintColor = .lightGray.withAlphaComponent(0.6)
        }
        
//        AppAccountManager.shared.anjingCount = self.anjingCount
    }
    
    @objc func dogIncrementButton() {
        if self.anjingCount < 1 {
            self.anjingCount += 1
        }
        anjingCountLabel.text = self.anjingCount.description
        decrementAnjingButton.imageView?.tintColor = .customOrange
        decrementAnjingButton.imageView?.layer.opacity = 1.0
        
//        AppAccountManager.shared.anjingCount = self.anjingCount
    }
    
    @objc func saveData() {
        AppAccountManager.shared.anjingCount = self.anjingCount
        AppAccountManager.shared.kucingCount = self.kucingCount
        
        mainHeaderDelegate?.numberOfCatsAndDogsButton.catLabel.text = kucingCount.description
        mainHeaderDelegate?.numberOfCatsAndDogsButton.dogLabel.text = anjingCount.description
        
        mainHeaderDelegate?.kucingCount = self.kucingCount
        mainHeaderDelegate?.anjingCount = self.anjingCount
        
        mainHeaderDelegate?.delegate?.dismiss(animated: true)
        
        if let controllerDelegate {
            controllerDelegate.anjingCount = AppAccountManager.shared.anjingCount
            controllerDelegate.kucingCount = AppAccountManager.shared.kucingCount
            
            ubahControllerDelegate?.anjingCount = AppAccountManager.shared.anjingCount
            ubahControllerDelegate?.kucingCount = AppAccountManager.shared.kucingCount
            
            ubahControllerDelegate?.numberOfCatsAndDogsButton.catLabel.text =  AppAccountManager.shared.kucingCount.description
            ubahControllerDelegate?.numberOfCatsAndDogsButton.dogLabel.text =  AppAccountManager.shared.anjingCount.description
            
            dismiss(animated: true)
        }
        
        for i in 0..<AppAccountManager.shared.anjingCount {
            ReservationManager.shared.dogDetailOrders.append(PetDetailsForOrder())
        }
        
        for i in 0..<AppAccountManager.shared.kucingCount {
            ReservationManager.shared.catDetailOrders.append(PetDetailsForOrder())
        }
        
        
        delegate?.saveButtonTapped()
    }
}
