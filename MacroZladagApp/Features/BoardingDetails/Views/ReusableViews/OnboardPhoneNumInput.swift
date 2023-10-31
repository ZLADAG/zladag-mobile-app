//
//  OnboardPhoneNumInput.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 29/10/23.
//

import UIKit

class OnboardPhoneNumInput: UIView {
    
    weak var delegate: OnboardButtonOutlineDelegate?

    var phoneInputField = PhoneNumTextField()
    var nextButton = PrimaryButtonFilled(
        btnTitle: "button"
    )
    private var phoneComponentStack : UIStackView!
    
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
    
    
    private func setUpComponents(_ btnTitle: String){
        nextButton.btn.titleLabel?.text = btnTitle
        nextButton.btn.isEnabled = false

        phoneComponentStack = UIStackView(arrangedSubviews: [phoneInputField, nextButton])
        phoneComponentStack.translatesAutoresizingMaskIntoConstraints = false
        phoneComponentStack.axis  = NSLayoutConstraint.Axis.vertical
        phoneComponentStack.distribution  = UIStackView.Distribution.fill
        phoneComponentStack.alignment = UIStackView.Alignment.fill
        phoneComponentStack.spacing   = 30.0
        
        setUpConstraints()

    }
    
    private func setUpConstraints(){
        
        self.addSubview(phoneComponentStack)
        NSLayoutConstraint.activate([
            // Set heigts
            phoneInputField.heightAnchor.constraint(equalToConstant: 49),
            
            // Set wraping constraint
            phoneComponentStack.topAnchor.constraint(equalTo: self.bottomAnchor),
            phoneComponentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            phoneComponentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

extension OnboardPhoneNumInput : PrimaryButtonFilledDelegate {
    func btnTapped() {
        
        
        
      
        
    }
}
extension OnboardPhoneNumInput: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField.text!.count > 10 {
            print("hueheheh")
        }
        return false
    }
}
