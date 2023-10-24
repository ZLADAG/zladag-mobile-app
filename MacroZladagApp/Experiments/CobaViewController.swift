//
//  CobaViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 10/10/23.
//

import UIKit

class ModelSaya {
    var nama: String
    var umur: Int
    
    init(nama: String, umur: Int) {
        self.nama = nama
        self.umur = umur
    }
}

class CobaViewController: UIViewController {
    
    public var model = ModelSaya(nama: "oke", umur: 123)
    
    lazy var label: UILabel = {
        let label = UILabel()
        
        label.text = "ini nih: \(model.nama), \(model.umur)"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()

    let button: UIButton = {
        let button = UIButton()
        
        let label = UILabel()
        label.text = "anjay"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        
        button.addSubview(label)
//        label.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: button.topAnchor),
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])

        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray
        setupButton()
        setupLabel()
        setupNavigationBar2()
    }
    
    func setupNavigationBar2() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .customLightOrange
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .white
        
//        navigationController?.navigationBar.standardAppearance = appearance2
//        navigationController?.navigationBar.compactAppearance = appearance2
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance2
    }
    
    func setupLabel() {
        view.addSubview(label)
            
        label.backgroundColor = .systemMint
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250),
            label.widthAnchor.constraint(equalToConstant: 150),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupButton() {
        view.addSubview(button)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
//        button.addTarget(self, action: #selector(goToSheet), for: .touchUpInside)
        button.addTarget(self, action: #selector(presentSheet), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func goToSheet() {
        print(model.self.nama, model.umur)
        model.nama = "anjayxx"
        model.umur = 999
        label.text = "ini nih: \(model.nama), \(model.umur)"
        print(model.self.nama, model.umur)
    }
    
    @objc func presentCatsAndDogSheet() {
        let vc  = CatsAndDogsCounterViewController()
        let navVc = UINavigationController(rootViewController: vc)
        
        vc.modalPresentationStyle = .pageSheet
//        navVc.isModalInPresentation = true
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 10
            sheet.detents = [
                .custom(resolver: { context in
                    0.35 * context.maximumDetentValue
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        navigationController?.present(navVc, animated: true, completion: nil)
    }
    
    @objc func presentSheet() {
        let vc  = SheetDuaViewController()
        let navVc = UINavigationController(rootViewController: vc)
        
        vc.modalPresentationStyle = .pageSheet
//        navVc.isModalInPresentation = true
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 10
            sheet.detents = [
                .custom(resolver: { context in
                    1 * context.maximumDetentValue
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        navigationController?.present(navVc, animated: true, completion: nil)
        
    }
    
    
    
    
    

}
