//
//  CobaCobaViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 09/11/23.
//

import UIKit
import Foundation

class CobaCobaViewController: UIViewController {
    
    let button = UIButton()
    let label = UILabel()
    var minDate: Date = Date()
    var maxDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupButton()
        setupLabel()

    }
    
    func setupButton() {
        view.addSubview(button)
        
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        button.addTarget(self, action: #selector(onClickButton), for: .touchUpInside)
    }
    
    func setupLabel() {
        label.backgroundColor = .customLightGray3
        label.text = "oke\n\(Utils.getFormattedDate(date: self.minDate))\n\(Utils.getFormattedDate(date: self.maxDate))"
        label.numberOfLines = 3
        label.textAlignment = .center
        
        label.sizeToFit()
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 300),
            label.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        
    }
    
    @objc func onClickButton() {
        let vc  = CustomDatePickerViewController()
//        vc.mainViewController = self
        let navVc = UINavigationController(rootViewController: vc)
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 10
            sheet.detents = [
                .custom(resolver: { context in
                    0.75 * context.maximumDetentValue
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        self.navigationController?.present(navVc, animated: true, completion: nil)
    }
}
