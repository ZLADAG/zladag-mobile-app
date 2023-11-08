//
//  IconButtonTinted.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 02/11/23.
//



import UIKit


// MARK: Protocols
protocol IconButtonTintedDelegate: AnyObject {
    func btnTapped(_ sender: UIButton)
}

class IconButtonTinted: UIView {

    weak var delegate: IconButtonTintedDelegate?

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
        btn = UIButton(configuration: .tinted())
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("   \(btnTitle)", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        btn.tintColor = .customOrange
        btn.setTitleColor(.customOrange, for: .normal)
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
        
        NSLayoutConstraint.activate([
            btn.heightAnchor.constraint(equalToConstant: 44),

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


