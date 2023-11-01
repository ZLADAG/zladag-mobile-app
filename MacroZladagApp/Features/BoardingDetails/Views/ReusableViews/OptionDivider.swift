//
//  OptionDivider.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 30/10/23.
//

import UIKit

class OptionDivider: UIView {
    
    var dividerLabel: UILabel!
    
    private var dividerStack: UIStackView!
    
    // MARK: Initialize Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Private Functions
    private func setUpComponents(){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        dividerLabel = createDefaultLabel("Atau")
       
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addSeparator(of: 1)
        stack.axis  = NSLayoutConstraint.Axis.vertical
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.trailing
        

        let stack2 = UIStackView()
        stack2.translatesAutoresizingMaskIntoConstraints = false
        stack2.addSeparator(of: 1)
        stack2.axis  = NSLayoutConstraint.Axis.vertical
        stack2.distribution  = UIStackView.Distribution.fill
        stack2.alignment = UIStackView.Alignment.leading

        dividerStack = UIStackView(arrangedSubviews: [stack, dividerLabel, stack2])
        
        dividerStack.translatesAutoresizingMaskIntoConstraints = false
        dividerStack.axis  = NSLayoutConstraint.Axis.horizontal
        dividerStack.distribution  = UIStackView.Distribution.fill
        dividerStack.alignment = UIStackView.Alignment.center
        dividerStack.spacing   = 8.0
       
        
        setUpConstraints()
    }
    private func setUpConstraints() {
        self.addSubview(dividerStack)
        
        NSLayoutConstraint.activate([
//            dividerStack.heightAnchor.constraint(equalToConstant: 18),
            
            dividerStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
            dividerStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -28),
            dividerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 83),
            dividerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -83),
        ])
    }
    
    private func createDefaultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = text
        label.textColor = .systemGray3
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }
}


extension UIStackView {
    func addSeparator(of size: CGFloat) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray3
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: size),
            view.widthAnchor.constraint(equalToConstant: 64),
            

        ])
       
        addArrangedSubview(view)
    }
}
