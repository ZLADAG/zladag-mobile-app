//
//  YourOrdersViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import Foundation
import UIKit

class YourOrdersViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        return imageView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
    }
    
}
