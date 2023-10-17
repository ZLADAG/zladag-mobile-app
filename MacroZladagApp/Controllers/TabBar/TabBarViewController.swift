//
//  TabBarViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    func configureTabBar() {
        let vc1 = HomeViewController()
//        let vc1 = SheetDuaViewController()
//        let vc1 = CobaViewController()
//        let vc1 = CobaViewController()
        let vc2 = YourOrdersViewController()
//        let vc2 = CobaTextFieldViewController()
        let vc3 = AccountViewController()
//        let vc3 = DatePickerViewController()
        
        vc1.title = ""
        vc2.title = "Your Orders"
        vc3.title = "Account"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "tabbar-home-icon"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Your Orders", image: UIImage(named: "tabbar-yourorders-icon"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Account", image: UIImage(named: "tabbar-account-icon"), tag: 3)
        
//        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
//        nav1.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
//        nav1.navigationController?.navigationBar.shadowImage = UIImage()
//        nav1.navigationController?.navigationBar.isTranslucent = true
//        nav1.navigationController?.view.backgroundColor = .clear
        
        self.tabBar.tintColor = .customOrange
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
