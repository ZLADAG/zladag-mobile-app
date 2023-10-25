//
//  YourOrdersViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import Foundation
import UIKit

class YourOrdersViewController: UIViewController {
    
    
    
    let userDefaults2 = UserDefaults.standard.value(forKeyPath: "keyPath1")
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        return imageView
    }()
    
    override func viewDidLoad() {
        UserDefaults.standard.setValue("nilai1", forKey: "key1")
        view.backgroundColor = .systemBackground
        var userDefaults = UserDefaults.standard.value(forKey: "key1") as! String
        print(userDefaults)
        
        UserDefaults.standard.setValue("nilai1Lagi", forKey: "key1")
        userDefaults = UserDefaults.standard.value(forKey: "key1") as! String
        print(userDefaults)
        print(userDefaults2)
    }
    
}
