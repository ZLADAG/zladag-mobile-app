//
//  CatsAndDogsCounterViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 09/10/23.
//

import UIKit

class CatsAndDogsCounterViewController: UIViewController {

    var delegate: MainHeaderCollectionReusableView?
    
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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let catIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cat-icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let container1: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        uiView.layer.cornerRadius = 8
        uiView.layer.masksToBounds = true
        uiView.layer.borderColor = UIColor.customOrange.cgColor
        uiView.layer.borderWidth = 2
        return uiView
    }()
    
    let container2: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        uiView.layer.cornerRadius = 8
        uiView.layer.masksToBounds = true
        uiView.layer.borderColor = UIColor.customOrange.cgColor
        uiView.layer.borderWidth = 2
        return uiView
    }()
    
    public var kucingCount: Int = 0
    public var anjingCount: Int = 0
    
    lazy var kucingCountLabel: UILabel = {
        let label = UILabel()
        label.text = kucingCount.description
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var anjingCountLabel: UILabel = {
        let label = UILabel()
        label.text = anjingCount.description
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let incrementButton1: UIButton = {
        let button = UIButton()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "increment-button")
        imageView.contentMode = .scaleAspectFit
        
        button.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: button.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
        
        return button
    }()
    
    let incrementButton2: UIButton = {
        let button = UIButton()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "increment-button")
        imageView.contentMode = .scaleAspectFit
        
        button.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: button.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
        
        return button
    }()
    
    let decrementButton1: UIButton = {
        let button = UIButton()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "decrement-button")
        imageView.contentMode = .scaleAspectFit
        
        button.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: button.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
        
        return button
    }()
    
    let decrementButton2: UIButton = {
        let button = UIButton()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "decrement-button")
        imageView.contentMode = .scaleAspectFit
        
        button.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: button.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customGray
        
        view.addSubview(container1)
        view.addSubview(container2)
        view.addSubview(dogIcon)
        view.addSubview(catIcon)
        view.addSubview(anjingLabel)
        view.addSubview(kucingLabel)
        
        view.addSubview(kucingCountLabel)
        view.addSubview(anjingCountLabel)
        
        view.addSubview(incrementButton1)
        view.addSubview(decrementButton1)
        
        view.addSubview(incrementButton2)
        view.addSubview(decrementButton2)
        
        setupButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }
    
    func setupConstraints() {
        container1.translatesAutoresizingMaskIntoConstraints = false
        container2.translatesAutoresizingMaskIntoConstraints = false
        dogIcon.translatesAutoresizingMaskIntoConstraints = false
        catIcon.translatesAutoresizingMaskIntoConstraints = false
        anjingLabel.translatesAutoresizingMaskIntoConstraints = false
        kucingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        kucingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        anjingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        incrementButton1.translatesAutoresizingMaskIntoConstraints = false
        incrementButton2.translatesAutoresizingMaskIntoConstraints = false
        decrementButton1.translatesAutoresizingMaskIntoConstraints = false
        decrementButton2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            container1.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            container1.widthAnchor.constraint(equalToConstant: 342),
            container1.heightAnchor.constraint(equalToConstant: 68),
            
            container2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            container2.topAnchor.constraint(equalTo: container1.bottomAnchor, constant: 16),
            container2.widthAnchor.constraint(equalToConstant: 342),
            container2.heightAnchor.constraint(equalToConstant: 68),
            
            catIcon.leadingAnchor.constraint(equalTo: container1.leadingAnchor, constant: 16),
            catIcon.topAnchor.constraint(equalTo: container1.topAnchor, constant: 16),
            catIcon.widthAnchor.constraint(equalToConstant: 36),
            catIcon.heightAnchor.constraint(equalToConstant: 36),
            
            dogIcon.leadingAnchor.constraint(equalTo: container2.leadingAnchor, constant: 16),
            dogIcon.topAnchor.constraint(equalTo: container2.topAnchor, constant: 20),
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
            decrementButton1.leadingAnchor.constraint(equalTo: container1.leadingAnchor, constant: 220 - 15),
            decrementButton1.topAnchor.constraint(equalTo: container1.topAnchor, constant: 18),
            decrementButton1.widthAnchor.constraint(equalToConstant: 32),
            decrementButton1.heightAnchor.constraint(equalToConstant: 32),
            
            kucingCountLabel.leadingAnchor.constraint(equalTo: decrementButton1.trailingAnchor, constant: 16),
            kucingCountLabel.topAnchor.constraint(equalTo: container1.topAnchor, constant: 25.5),
            kucingCountLabel.widthAnchor.constraint(equalToConstant: 25),
            kucingCountLabel.heightAnchor.constraint(equalToConstant: 17),
            
            incrementButton1.leadingAnchor.constraint(equalTo: kucingCountLabel.trailingAnchor, constant: 16),
            incrementButton1.topAnchor.constraint(equalTo: container1.topAnchor, constant: 18),
            incrementButton1.widthAnchor.constraint(equalToConstant: 32),
            incrementButton1.heightAnchor.constraint(equalToConstant: 32),
            
            // anjing counter
            decrementButton2.leadingAnchor.constraint(equalTo: container2.leadingAnchor, constant: 220 - 15),
            decrementButton2.topAnchor.constraint(equalTo: container2.topAnchor, constant: 18),
            decrementButton2.widthAnchor.constraint(equalToConstant: 32),
            decrementButton2.heightAnchor.constraint(equalToConstant: 32),
            
            anjingCountLabel.leadingAnchor.constraint(equalTo: decrementButton2.trailingAnchor, constant: 16),
            anjingCountLabel.topAnchor.constraint(equalTo: container2.topAnchor, constant: 25.5),
            anjingCountLabel.widthAnchor.constraint(equalToConstant: 25),
            anjingCountLabel.heightAnchor.constraint(equalToConstant: 17),
            
            incrementButton2.leadingAnchor.constraint(equalTo: anjingCountLabel.trailingAnchor, constant: 16),
            incrementButton2.topAnchor.constraint(equalTo: container2.topAnchor, constant: 18),
            incrementButton2.widthAnchor.constraint(equalToConstant: 32),
            incrementButton2.heightAnchor.constraint(equalToConstant: 32),

        ])
    }
    
    func setupButtons() {
        decrementButton1.addTarget(self, action: #selector(catDecrementButton), for: .touchUpInside)
        incrementButton1.addTarget(self, action: #selector(catIncrementButton), for: .touchUpInside)
        
        decrementButton2.addTarget(self, action: #selector(dogDecrementButton), for: .touchUpInside)
        incrementButton2.addTarget(self, action: #selector(dogIncrementButton), for: .touchUpInside)
    }
    
    @objc func catDecrementButton() {
        if self.kucingCount > 0 {
            self.kucingCount -= 1
            kucingCountLabel.text = self.kucingCount.description
            delegate?.numberOfCatsAndDogsButton.catLabel.text = self.kucingCount.description
        }
    }
    
    @objc func catIncrementButton() {
        self.kucingCount += 1
        kucingCountLabel.text = self.kucingCount.description
        delegate?.numberOfCatsAndDogsButton.catLabel.text = self.kucingCount.description
    }
    
    @objc func dogDecrementButton() {
        if self.anjingCount > 0 {
            self.anjingCount -= 1
            anjingCountLabel.text = self.anjingCount.description
            delegate?.numberOfCatsAndDogsButton.dogLabel.text = self.anjingCount.description
        }
    }
    
    @objc func dogIncrementButton() {
        self.anjingCount += 1
        anjingCountLabel.text = self.anjingCount.description
        delegate?.numberOfCatsAndDogsButton.dogLabel.text = self.anjingCount.description
    }
}
