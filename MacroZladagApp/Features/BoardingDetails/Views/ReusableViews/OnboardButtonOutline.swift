//
//  OnboardButtonOutline.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 26/10/23.
//

import UIKit
// MARK: Protocols
protocol OnboardButtonOutlineDelegate: AnyObject {
    func btnTapped(_ sender: UIButton)
}

class OnboardButtonOutline: UIView {
    
    weak var delegate: OnboardButtonOutlineDelegate?

    var iconName: String!
    var btn: UIButton!
        
    // MARK: Initialize Methods
    init(iconName: String, btnTitle: String) {
        super.init(frame: .zero)
        setUpComponents(iconName, btnTitle)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Private Functions
    private func setUpComponents(_ iconName: String, _ btnTitle: String){
        self.translatesAutoresizingMaskIntoConstraints = false

    
        btn = UIButton(configuration: .borderedProminent())
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(btnTitle, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.setTitleColor(.black, for: .normal)
        
        btn.tintColor = .white
        btn.layer.borderColor = UIColor.customGray.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 25
        btn.contentHorizontalAlignment = .center
        btn.layer.masksToBounds = true

        
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        
        let icon = UIImage(systemName: iconName)!
        
        btn.setImage(icon, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        setUpConstraints()
    }
    private func setUpConstraints() {
        self.addSubview(btn)
        
        NSLayoutConstraint.activate([            btn.heightAnchor.constraint(equalToConstant: 50),

            btn.topAnchor.constraint(equalTo: self.topAnchor),
            btn.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            btn.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            btn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    
    // MARK: Selectors
    @objc func btnTapped(_ sender: UIButton) {
        delegate?.btnTapped(sender)
    }
}
