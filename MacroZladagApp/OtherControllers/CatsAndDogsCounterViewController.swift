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
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .lightGray
        return label
    }()
    
    let anjingLabel: UILabel = {
        let label = UILabel()
        label.text = "Anjing"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .lightGray
        return label
    }()
    
    let dogIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dog-icon")
        imageView.tintColor = .customLightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let catIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cat-icon")
        imageView.tintColor = .customLightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let kucingContainer: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        uiView.layer.cornerRadius = 8
        uiView.layer.masksToBounds = true
        uiView.layer.borderColor = UIColor.customOrange.cgColor
        uiView.layer.borderWidth = 2
        return uiView
    }()
    
    let anjingContainer: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        uiView.layer.cornerRadius = 8
        uiView.layer.masksToBounds = true
        uiView.layer.borderColor = UIColor.customOrange.cgColor
        uiView.layer.borderWidth = 2
        return uiView
    }()
    
    public var kucingCount: Int = AppAccountManager.shared.kucingCount
    public var anjingCount: Int = AppAccountManager.shared.anjingCount
    
    lazy var kucingCountLabel: UILabel = {
        let label = UILabel()
//        label.text = self.kucingCount.description
        label.text = AppAccountManager.shared.kucingCount.description
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .textBlack
        label.textAlignment = .center
        return label
    }()
    
    lazy var anjingCountLabel: UILabel = {
        let label = UILabel()
//        label.text = self.anjingCount.description
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
        
        print(AppAccountManager.shared.calendarTextDetails)
        
        self.anjingCount = AppAccountManager.shared.anjingCount
        self.kucingCount = AppAccountManager.shared.kucingCount
        
        view.backgroundColor = .white
        
        view.addSubview(kucingContainer)
        view.addSubview(catIcon)
        view.addSubview(kucingLabel)
        view.addSubview(incrementKucingButton)
        view.addSubview(decrementKucingButton)
        view.addSubview(kucingCountLabel)

        view.addSubview(anjingContainer)
        view.addSubview(dogIcon)
        view.addSubview(anjingLabel)
        view.addSubview(incrementAnjingButton)
        view.addSubview(decrementAnjingButton)
        view.addSubview(anjingCountLabel)

        view.addSubview(simpanButton)
        
//        if let controllerDelegate {
//            kucingCountLabel.text = controllerDelegate.kucingCount.description
//            anjingCountLabel.text = controllerDelegate.anjingCount.description
//        }
//        
//        if let mainHeaderDelegate {
//            kucingCountLabel.text = mainHeaderDelegate.numberOfCatsAndDogsButton.catLabel.text
//            anjingCountLabel.text = mainHeaderDelegate.numberOfCatsAndDogsButton.dogLabel.text
//        }
        
        setupNavBar()
        setupButtons()
        simpanButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)

    }
    
    func setupNavBar() {
        let navView = UIView()
        navView.frame = CGRect(x: 0, y: 0, width: 354, height: 32)
        
        
        let navLabel = UILabel()
        navLabel.text = "Jumlah anabul"
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
        kucingContainer.translatesAutoresizingMaskIntoConstraints = false
        anjingContainer.translatesAutoresizingMaskIntoConstraints = false
        dogIcon.translatesAutoresizingMaskIntoConstraints = false
        catIcon.translatesAutoresizingMaskIntoConstraints = false
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
            anjingContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            anjingContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 48 + 16),
            anjingContainer.widthAnchor.constraint(equalToConstant: 342),
            anjingContainer.heightAnchor.constraint(equalToConstant: 68),
            
            kucingContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            kucingContainer.topAnchor.constraint(equalTo: anjingContainer.bottomAnchor, constant: 16),
            kucingContainer.widthAnchor.constraint(equalToConstant: 342),
            kucingContainer.heightAnchor.constraint(equalToConstant: 68),
            
            catIcon.leadingAnchor.constraint(equalTo: kucingContainer.leadingAnchor, constant: 16),
            catIcon.topAnchor.constraint(equalTo: kucingContainer.topAnchor, constant: 16),
            catIcon.widthAnchor.constraint(equalToConstant: 36),
            catIcon.heightAnchor.constraint(equalToConstant: 36),
            
            dogIcon.leadingAnchor.constraint(equalTo: anjingContainer.leadingAnchor, constant: 16),
            dogIcon.topAnchor.constraint(equalTo: anjingContainer.topAnchor, constant: 16),
            dogIcon.widthAnchor.constraint(equalToConstant: 36),
            dogIcon.heightAnchor.constraint(equalToConstant: 36),
            
            kucingLabel.leadingAnchor.constraint(equalTo: catIcon.trailingAnchor, constant: 8),
            kucingLabel.topAnchor.constraint(equalTo: catIcon.topAnchor, constant: 9),
            kucingLabel.widthAnchor.constraint(equalToConstant: 80),
            kucingLabel.heightAnchor.constraint(equalToConstant: 18),
            
            anjingLabel.leadingAnchor.constraint(equalTo: dogIcon.trailingAnchor, constant: 8),
            anjingLabel.topAnchor.constraint(equalTo: dogIcon.topAnchor, constant: 9),
            anjingLabel.widthAnchor.constraint(equalToConstant: 80),
            anjingLabel.heightAnchor.constraint(equalToConstant: 18),
            
            // kucing counter
            decrementKucingButton.leadingAnchor.constraint(equalTo: kucingContainer.leadingAnchor, constant: 220 - 15),
            decrementKucingButton.topAnchor.constraint(equalTo: kucingContainer.topAnchor, constant: 18),
            decrementKucingButton.widthAnchor.constraint(equalToConstant: 32),
            decrementKucingButton.heightAnchor.constraint(equalToConstant: 32),
            
            kucingCountLabel.leadingAnchor.constraint(equalTo: decrementKucingButton.trailingAnchor, constant: 16),
            kucingCountLabel.topAnchor.constraint(equalTo: kucingContainer.topAnchor, constant: 25.5),
            kucingCountLabel.widthAnchor.constraint(equalToConstant: 25),
            kucingCountLabel.heightAnchor.constraint(equalToConstant: 17),
            
            incrementKucingButton.leadingAnchor.constraint(equalTo: kucingCountLabel.trailingAnchor, constant: 16),
            incrementKucingButton.topAnchor.constraint(equalTo: kucingContainer.topAnchor, constant: 18),
            incrementKucingButton.widthAnchor.constraint(equalToConstant: 32),
            incrementKucingButton.heightAnchor.constraint(equalToConstant: 32),
            
            // anjing counter
            decrementAnjingButton.leadingAnchor.constraint(equalTo: anjingContainer.leadingAnchor, constant: 220 - 15),
            decrementAnjingButton.topAnchor.constraint(equalTo: anjingContainer.topAnchor, constant: 18),
            decrementAnjingButton.widthAnchor.constraint(equalToConstant: 32),
            decrementAnjingButton.heightAnchor.constraint(equalToConstant: 32),
            
            anjingCountLabel.leadingAnchor.constraint(equalTo: decrementAnjingButton.trailingAnchor, constant: 16),
            anjingCountLabel.topAnchor.constraint(equalTo: anjingContainer.topAnchor, constant: 25.5),
            anjingCountLabel.widthAnchor.constraint(equalToConstant: 25),
            anjingCountLabel.heightAnchor.constraint(equalToConstant: 17),
            
            incrementAnjingButton.leadingAnchor.constraint(equalTo: anjingCountLabel.trailingAnchor, constant: 16),
            incrementAnjingButton.topAnchor.constraint(equalTo: anjingContainer.topAnchor, constant: 18),
            incrementAnjingButton.widthAnchor.constraint(equalToConstant: 32),
            incrementAnjingButton.heightAnchor.constraint(equalToConstant: 32),
            
            simpanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            simpanButton.topAnchor.constraint(equalTo: kucingContainer.bottomAnchor, constant: 32),
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
        self.kucingCount += 1
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
        self.anjingCount += 1
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
        
        delegate?.saveButtonTapped()
    }
}
