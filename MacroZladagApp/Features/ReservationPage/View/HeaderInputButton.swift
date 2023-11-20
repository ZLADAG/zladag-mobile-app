//
//  HeaderInputButton.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 07/11/23.
//

import UIKit

protocol HeaderInputButtonDelegate: AnyObject {
    func btnTapped(_ senderButtonType: HeaderInputButton.ButtonType)
}

class HeaderInputButton: UIView {
    enum ButtonType {
           case date
           case petAmount
       }
    
    weak var delegate: HeaderInputButtonDelegate?
    
    var btn: UIStackView!
    var btnType: ButtonType!
    var infoLabel: UILabel!
    
    // MARK: Initialize Methods
    init(_ inputValue: String, _ buttonType: ButtonType) {
        super.init(frame: .zero)
        setUpComponents(inputValue, buttonType)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpComponents(_ inputValue: String, _ buttonType: ButtonType) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 4
        self.layer.backgroundColor = UIColor.white.cgColor
        
        /// Set button type
        self.btnType = buttonType
        
        var titleLabel: UILabel!
        var icon: UIImageView!
        
        switch buttonType {
        case .date:
            titleLabel = createTitleLabel("Tanggal")
            icon = createIcon("calendar")
        case .petAmount:
            titleLabel = createTitleLabel("Anabul")
            icon = createIcon("pawprint.fill")
        }
        
        infoLabel = createDefaultLabel("\(inputValue)")
//        setInfoLabelText(inputValue)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, infoLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 4.0
        
        btn = UIStackView(arrangedSubviews: [stack, icon])
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.axis = .horizontal
        btn.alignment = .center
        btn.distribution = .fill
        btn.spacing = 4.0
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnTapped)))
        
        self.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            btn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            btn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            btn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    
    
    func getInfoLabelText() -> String {
        return infoLabel.text ?? "text empty"
    }
    func setInfoLabelText(_ text: String) {
        infoLabel.text = text
    }
    
    // MARK: Selectors
    @objc func btnTapped() {
        // Define the clicked effect
        UIView.animate(withDuration: 0.1, animations: {
            self.backgroundColor = UIColor.customLightGray3
        }) { _ in
            UIView.animate(withDuration: 0.05) {
                self.backgroundColor = UIColor.white 
            }
        }
        
        delegate?.btnTapped(self.btnType)
        
    }
    
    // MARK: Create Label
    private func createTitleLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .customLightGray
        return label
    }
    private func createDefaultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.text = text
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }
    
    // MARK: Create icon
    private func createIcon(_ iconName:String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(systemName: iconName)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .customOrange
        imageView.clipsToBounds = true
        
        let iconSize = 18.0
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: iconSize),
            imageView.widthAnchor.constraint(equalToConstant: iconSize),
        ])
        
        return imageView
    }
    
    
}
