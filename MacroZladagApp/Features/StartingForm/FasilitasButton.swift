//
//  FasilitasButton.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 01/11/23.
//

import UIKit

class FasilitasButton: UIButton {
    
    var name: String
    var apiParam: String
    
    var isClicked: Bool = false
    
    let label = UILabel()
    let iconImageView = UIImageView()
    
    init(for name: String, apiParam: String) {
        self.name = name
        self.apiParam = apiParam
        super.init(frame: .zero)
        
        frame.size = CGSize(width: 108, height: 109)
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        
        setupIconImageView()
        setupLabel()
        
        addTarget(self, action: #selector(clickFasilitasButton), for: .touchUpInside)
    }
    
    func setupLabel() {
        addSubview(label)
        
        label.text = self.name
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .textBlack
        label.textAlignment = .center
        
        if self.name.lowercased().contains("dokter hewan") {
            label.numberOfLines = 3
            label.frame.size = CGSize(width: 92, height: 54)
        } else {
            label.numberOfLines = 2
            label.frame.size = CGSize(width: 92, height: 36)
        }
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: label.height),
        ])
    }
    
    
    func setupIconImageView() {
        addSubview(iconImageView)
        
        iconImageView.image = UIImage(named: self.name.lowercased().replacing(" ", with: "-") + "-icon")
        iconImageView.frame.size = CGSize(width: 24, height: 24)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if self.name.lowercased().contains("dokter hewan") {
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        } else {
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        }
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: iconImageView.width),
            iconImageView.heightAnchor.constraint(equalToConstant: iconImageView.height),
        ])
    }
    
    @objc func clickFasilitasButton() {
        self.isClicked = !self.isClicked
        
        if self.isClicked {
            self.activateView()
        } else {
            self.deactivateView()
        }

    }
    
    func activateView() {
        layer.borderColor = UIColor.orange.cgColor
        layer.backgroundColor = UIColor.orangeWithOpacity.cgColor
    }
    
    func deactivateView() {
        layer.borderColor = UIColor.clear.cgColor
        layer.backgroundColor = UIColor.clear.cgColor
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}
