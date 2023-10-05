//
//  ErrorPageViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 04/10/23.
//

import UIKit

class ErrorPageViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "somethingsWrong")
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        view.addSubview(imageView)
    }

}
