//
//  PrimaryButtonFilled.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 25/10/23.
//

import UIKit

// MARK: Protocols
protocol PrimaryButtonFilledDelegate: AnyObject {
    func btnTapped()
}

class PrimaryButtonFilled: UIView {

    weak var delegate: PrimaryButtonFilledDelegate?

    var btn: UIButton!
    
    // MARK: Initialize Methods
    init(btnTitle: String) {
        super.init(frame: .zero)
        setUpComponents(btnTitle)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Public Functions
    func addDefaultAlert(title: String, message:String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        return alert
    }
    
    func addOkAlert(title: String, message:String) -> UIAlertController {
        let alert = addDefaultAlert(title: title, message: message)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okAction)
        return alert
    }
    
    private func setUpComponents(_ text: String) {
        
        self.translatesAutoresizingMaskIntoConstraints = false

        btn = UIButton(configuration: .filled())
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(text, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.setTitleColor(.white, for: .normal)
        btn.tintColor = .customOrange
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        
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
    
    private func createDefaultButton(_ text: String) -> UIButton{
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.plain() // there are several options to choose from instead of .plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button.configuration = configuration
            
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = .customOrange
        
        return button
    }
    
    // MARK: Selectors
    @objc func btnTapped() {
        delegate?.btnTapped()
    }

}
