//
//  SheetDuaViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 10/10/23.
//

import UIKit

class SheetDuaViewController: UIViewController {

    let scrollVIew = UIScrollView()
    
    var textButton: String = "mantap"
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let view1: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let view2: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let view3: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle(self.textButton, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollVIew)
//        scrollVIew.backgroundColor = .systemMint
        
        scrollVIew.addSubview(contentView)
        
        scrollVIew.addSubview(view1)
        scrollVIew.addSubview(view2)
        scrollVIew.addSubview(view3)
        
        scrollVIew.addSubview(button)
        
        setupConstraints()
        setupNavigationBar2()
        button.addTarget(self, action: #selector(mantap), for: .touchUpInside)
    }
    
    func setupNavigationBar2() {
        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        navigationController?.view.backgroundColor = .clear
        navigationController?.view.backgroundColor = .red
        
//        navigationController?.navigationBar.standardAppearance = appearance2
//        navigationController?.navigationBar.compactAppearance = appearance2
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance2
    }
    
    @objc func mantap() {
//        delegate?.dismiss(animated: true)
        navigationController?.dismiss(animated: true)
    }
    
    func setupConstraints() {
        scrollVIew.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view1.translatesAutoresizingMaskIntoConstraints = false
        view2.translatesAutoresizingMaskIntoConstraints = false
        view3.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            scrollVIew.topAnchor.constraint(equalTo: view.topAnchor, constant: -56),
            scrollVIew.topAnchor.constraint(equalTo: view.topAnchor),
            scrollVIew.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollVIew.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollVIew.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollVIew.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollVIew.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollVIew.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollVIew.heightAnchor, multiplier: 3),
            
            view1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            view1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            view1.widthAnchor.constraint(equalToConstant: 200),
            view1.heightAnchor.constraint(equalToConstant: 200),
            
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: 135),
            view2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            view2.widthAnchor.constraint(equalToConstant: 200),
            view2.heightAnchor.constraint(equalToConstant: 200),

            view3.topAnchor.constraint(equalTo: view2.bottomAnchor, constant: 135),
            view3.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            view3.widthAnchor.constraint(equalToConstant: 200),
            view3.heightAnchor.constraint(equalToConstant: 200),
        
            button.trailingAnchor.constraint(equalTo: view2.leadingAnchor, constant: -25),
            button.topAnchor.constraint(equalTo: view2.topAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 44),
            
        ])
    }
    
}
