//
//  TabBarViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    let navbarLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Dekat Saya"
        label.textColor = .blue
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let navbarDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "1 Okt 2023, 1 Malam, 1 Kucing"
        label.textColor = .customGrayForIcons
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let navbarUbahButton: UIButton = {
        let button = UIButton()
        
        let label = UILabel()
        label.text = "Ubah"
        label.textColor = .customOrange
        label.font = .systemFont(ofSize: 12, weight: .bold)
        
        button.setTitle("Ubah", for: .normal)
        button.setTitleColor(.customOrange, for: .normal)
        button.backgroundColor = .orangeWithOpacity
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        configureTabBar()
    }
    
    func configureTabBar() {
        let vc1 = HomeViewController()
        let vc2 = OrdersViewController()
        let vc3 = ProfileViewController()
        
        vc1.title = ""
        vc2.title = ""
        vc3.title = ""
//
//        vc1.navigationItem.largeTitleDisplayMode = .always
//        vc2.navigationItem.largeTitleDisplayMode = .always
//        vc3.navigationItem.largeTitleDisplayMode = .always
//        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        
        nav1.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(named: "tabbar-home-icon"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(named: "tabbar-yourorders-icon"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Your Pet", image: UIImage(named: "tabbar-account-icon"), tag: 3)
        
//        nav1.navigationBar.prefersLargeTitles = true
//        nav2.navigationBar.prefersLargeTitles = true
//        nav3.navigationBar.prefersLargeTitles = true
        
//        nav1.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
//        nav1.navigationController?.navigationBar.shadowImage = UIImage()
//        nav1.navigationController?.navigationBar.isTranslucent = true
//        nav1.navigationController?.view.backgroundColor = .clear
        
        let titleView: UIView = {
            let view = UIView()
            view.backgroundColor = .red
            return view
        }()
        
        titleView.addSubview(navbarLocationLabel)
        titleView.addSubview(navbarDetailsLabel)
        
//        titleView.translatesAutoresizingMaskIntoConstraints = false
//        navbarLocationLabel.translatesAutoresizingMaskIntoConstraints = false
//        navbarDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            titleView.topAnchor
//        ])
        
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        navbarLocationLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        navbarDetailsLabel.frame = CGRect(x: 0, y: navbarLocationLabel.bottom, width: 100, height: 20)
        
//        navigationController?.navigationItem.titleView = titleView
        nav1.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .done, target: nil, action: nil)
        nav1.navigationItem.titleView = titleView
        
        self.tabBar.tintColor = .customOrange
//        setViewControllers([nav2, nav1, nav3], animated: true)
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
