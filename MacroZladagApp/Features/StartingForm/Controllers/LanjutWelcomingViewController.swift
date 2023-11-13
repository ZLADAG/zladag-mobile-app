//
//  LanjutWelcomingViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 30/10/23.
//

import UIKit

class LanjutWelcomingViewController: UIViewController {
    
    var userProfileName: String?
    var phoneNumber: String?
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Masukan data anabul-mu"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .textBlack
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.text = "Untuk pengalaman lebih sesuai"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .customGrayForLabels
        label.textAlignment = .center
        return label
    }()
    
    let tambahAnabulButton = UIButton()
    let tambahAnabulButtonShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .customDarkOrange
        view.layer.cornerRadius = 21
        view.layer.masksToBounds = true
        return view
    }()
    
    let nantiSajaButton: UIButton = {
        let button = UIButton()
        let label = UILabel()
        label.text = "Nanti saja"
        label.textColor = .customOrange
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        button.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 78).isActive = true
        label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        button.backgroundColor = .customOrangeOpacityUbah
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        
        return button
    }()
    
    var prevTambahAnabulButtonFrame: CGRect = CGRect()
    
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
        
        setupLoadingScreen()
        postRequestAutoSignIn { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.setupHeaderLabels()
            strongSelf.setupTambahAnabulButton()
            strongSelf.setupLineBreakView()
            strongSelf.setupNantiSajaButton()
            
            strongSelf.prevTambahAnabulButtonFrame = strongSelf.tambahAnabulButton.frame
            strongSelf.spinner.stopAnimating()
            strongSelf.spinner.removeFromSuperview()
        }
        
        tambahAnabulButton.addTarget(self, action: #selector(clickTambahAnabulButton), for: .touchDown)
        tambahAnabulButton.addTarget(self, action: #selector(clickTambahAnabulButton2), for: .touchUpInside)
        tambahAnabulButton.addTarget(self, action: #selector(clickTambahAnabulButton3), for: .touchDragOutside)
        tambahAnabulButton.addTarget(self, action: #selector(clickTambahAnabulButton4), for: .touchUpOutside)
        
        nantiSajaButton.addTarget(self, action: #selector(onClickNantiSajaButton), for: .touchUpInside)
    }
    
    func postRequestAutoSignIn(completion: @escaping () -> ()) {
        guard let userProfileName, let phoneNumber else { return }
        
        let group = DispatchGroup()
        group.enter()
        
        var success = false
        AuthManager.shared.postRequestSignUp(name: userProfileName, phoneNumber: phoneNumber) { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let response):
                print("\nSIGN UP: \(response.success)")
                break
            case .failure(let error):
                print("ERROR WHEN SIGNING UP\n\(error)")
                break
            }
        }
        
        group.notify(queue: .main) {
            AuthManager.shared.postRequestSignInByPhoneNumber(phoneNumber: phoneNumber) { result in
                group.enter()
                defer {
                    group.leave()
                }
                
//                if success {} // TODO: PENJAGAAN KALAU API GAGAL
            }
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    func setupHeaderLabels() {
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.widthAnchor.constraint(equalToConstant: 342),
            mainLabel.heightAnchor.constraint(equalToConstant: 80),
            
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 8),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.widthAnchor.constraint(equalToConstant: 342),
            subLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    func setupTambahAnabulButton() {
        view.addSubview(tambahAnabulButtonShadowView)
        view.addSubview(tambahAnabulButton)
        
        tambahAnabulButton.backgroundColor = .customOrange
        tambahAnabulButton.layer.cornerRadius = 16
        tambahAnabulButton.layer.masksToBounds = true
        
        let plusImageView = UIImageView(image: UIImage(named: "plus-icon"))
        plusImageView.tintColor = .white
        let tambahAnabulLabel = UILabel()
        tambahAnabulLabel.text = "Tambah Anabul"
        tambahAnabulLabel.textColor = .white
        tambahAnabulLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        tambahAnabulButton.addSubview(plusImageView)
        tambahAnabulButton.addSubview(tambahAnabulLabel)
        
        tambahAnabulButton.translatesAutoresizingMaskIntoConstraints = false
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        tambahAnabulLabel.translatesAutoresizingMaskIntoConstraints = false
        tambahAnabulButtonShadowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tambahAnabulButton.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 80 - 4),
            tambahAnabulButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tambahAnabulButton.widthAnchor.constraint(equalToConstant: 151),
            tambahAnabulButton.heightAnchor.constraint(equalToConstant: 168),
            
            plusImageView.topAnchor.constraint(equalTo: tambahAnabulButton.topAnchor, constant: 38),
            plusImageView.centerXAnchor.constraint(equalTo: tambahAnabulButton.centerXAnchor),
            plusImageView.widthAnchor.constraint(equalToConstant: 54),
            plusImageView.heightAnchor.constraint(equalToConstant: 54),
            
            tambahAnabulLabel.topAnchor.constraint(equalTo: plusImageView.bottomAnchor, constant: 21),
            tambahAnabulLabel.centerXAnchor.constraint(equalTo: tambahAnabulButton.centerXAnchor),
            tambahAnabulLabel.widthAnchor.constraint(equalToConstant: 120),
            tambahAnabulLabel.heightAnchor.constraint(equalToConstant: 24),
            
            tambahAnabulButtonShadowView.topAnchor.constraint(equalTo: tambahAnabulButton.topAnchor, constant: 8),
            tambahAnabulButtonShadowView.centerXAnchor.constraint(equalTo: tambahAnabulButton.centerXAnchor),
            tambahAnabulButtonShadowView.widthAnchor.constraint(equalToConstant: 151 - 2),
            tambahAnabulButtonShadowView.heightAnchor.constraint(equalToConstant: 168),
        ])
    }
    
    func setupLineBreakView() {
        let atauLineBreakView = UIView()
        
        let leftLine = UIView()
        leftLine.backgroundColor = .customGrayForLabels
        
        let rightLine = UIView()
        rightLine.backgroundColor = .customGrayForLabels
        
        let atauLabel = UILabel()
        atauLabel.text = "Atau"
        atauLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        atauLabel.textColor = .customGrayForLabels
        
        view.addSubview(atauLineBreakView)
        atauLineBreakView.addSubview(leftLine)
        atauLineBreakView.addSubview(rightLine)
        atauLineBreakView.addSubview(atauLabel)
        
        atauLineBreakView.translatesAutoresizingMaskIntoConstraints = false
        leftLine.translatesAutoresizingMaskIntoConstraints = false
        rightLine.translatesAutoresizingMaskIntoConstraints = false
        atauLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            atauLineBreakView.topAnchor.constraint(equalTo: tambahAnabulButton.bottomAnchor, constant: 80),
            atauLineBreakView.centerXAnchor.constraint(equalTo: tambahAnabulButton.centerXAnchor),
            atauLineBreakView.widthAnchor.constraint(equalToConstant: 177),
            atauLineBreakView.heightAnchor.constraint(equalToConstant: 18),
            
            leftLine.leadingAnchor.constraint(equalTo: atauLineBreakView.leadingAnchor),
            leftLine.centerYAnchor.constraint(equalTo: atauLineBreakView.centerYAnchor),
            leftLine.widthAnchor.constraint(equalToConstant: 64),
            leftLine.heightAnchor.constraint(equalToConstant: 1),
            
            atauLabel.centerXAnchor.constraint(equalTo: atauLineBreakView.centerXAnchor),
            atauLabel.centerYAnchor.constraint(equalTo: atauLineBreakView.centerYAnchor),
            atauLabel.widthAnchor.constraint(equalToConstant: 35),
            atauLabel.heightAnchor.constraint(equalToConstant: 18),
            
            rightLine.trailingAnchor.constraint(equalTo: atauLineBreakView.trailingAnchor),
            rightLine.centerYAnchor.constraint(equalTo: atauLineBreakView.centerYAnchor),
            rightLine.widthAnchor.constraint(equalToConstant: 64),
            rightLine.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func setupNantiSajaButton() {
        view.addSubview(nantiSajaButton)
        
        nantiSajaButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nantiSajaButton.topAnchor.constraint(equalTo: tambahAnabulButton.bottomAnchor, constant: 178),
            nantiSajaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nantiSajaButton.widthAnchor.constraint(equalToConstant: 342),
            nantiSajaButton.heightAnchor.constraint(equalToConstant: 44),
        ])
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
    
    // MARK: OBJC BUTTONS
    
    // TOUCH DOWN
    @objc func clickTambahAnabulButton() { // _ sender: UIButton
        tambahAnabulButton.frame = CGRect(
            x: tambahAnabulButton.frame.minX,
            y: tambahAnabulButton.frame.minY + 8,
            width: tambahAnabulButton.frame.width,
            height: tambahAnabulButton.frame.height
        )
    }
    
    // TOUCH UP INSIDE
    @objc func clickTambahAnabulButton2() {
        tambahAnabulButton.frame = prevTambahAnabulButtonFrame
        print("clicked tambah anabul")
        
        let vc = TambahProfilAnabulViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // TOUCH DRAG OUTSIDE
    @objc func clickTambahAnabulButton3() {
        tambahAnabulButton.frame = tambahAnabulButton.frame
    }
    
    // TOUCH UP OUTSIDE
    @objc func clickTambahAnabulButton4() {
        tambahAnabulButton.frame = prevTambahAnabulButtonFrame
    }
    
    @objc func onClickNantiSajaButton() {
        print("clicked nanti saja")
        
        let mainAppTabBarVC = TabBarViewController()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen

        present(mainAppTabBarVC, animated: true)
    }
    
}
