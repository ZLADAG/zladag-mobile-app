//
//  SignInByWhatsappViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 23/10/23.
//

import UIKit

class SignInByWhatsappViewController: UIViewController {

    private let countryCode = "+62"

    private var phoneNumTF: UITextField!
    private var nextButton: UIButton!
    private var switchOnboardPageButton: UIButton!

    private var phoneInputView: UIView!
    private var phoneInputStack: UIStackView!
    private var switchOnboardPageStack: UIStackView!
    private var allComponentStack: UIStackView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        /// change status bar color to white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = true

        setUpComponents()
    }
    
    private func setUpComponents(){
        phoneInputStack = createCustomPhoneTF()
        nextButton = createNextButton()
        switchOnboardPageStack = createSwitchOnboardPageStack()
        
        let stack = UIStackView(arrangedSubviews: [phoneInputStack, nextButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.vertical
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing   = 30.0

        let stack2 = UIStackView(arrangedSubviews: [switchOnboardPageStack])
        stack2.translatesAutoresizingMaskIntoConstraints = false
        stack2.axis  = NSLayoutConstraint.Axis.vertical
        stack2.distribution  = UIStackView.Distribution.fill
        stack2.alignment = UIStackView.Alignment.center
        stack2.spacing   = 0.0

        
        allComponentStack = UIStackView(arrangedSubviews: [stack, stack2])
        allComponentStack.translatesAutoresizingMaskIntoConstraints = false
        allComponentStack.axis  = NSLayoutConstraint.Axis.vertical
        allComponentStack.distribution  = UIStackView.Distribution.fill
        allComponentStack.alignment = UIStackView.Alignment.fill
        allComponentStack.spacing   = 8.0
        
        view.addSubview(allComponentStack)
        setUpConstraints()
        
    }
    private func setUpConstraints(){
        
        NSLayoutConstraint.activate([
            // Set heigts
            phoneInputStack.heightAnchor.constraint(equalToConstant: 49),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Set wraping constraint
            allComponentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            allComponentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            allComponentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }

    
    // MARK: UI Creation
    private func createNextButton() -> UIButton {
        let button = createDefaultButton("Lanjut")
        button.configuration = .filled()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .customOrange
//        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        return button
    }
    private func createSwitchOnboardPageStack() -> UIStackView {
        let label = createDefaultLabel("Belum punya akun?")
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        
        switchOnboardPageButton = createDefaultButton("")
        let attributedText = NSMutableAttributedString(string: "Buat Akun")
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: (switchOnboardPageButton.titleLabel?.font.pointSize)!), range: range)
        switchOnboardPageButton.setAttributedTitle(attributedText, for: .normal)

        switchOnboardPageButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        switchOnboardPageButton.setContentHuggingPriority(.required, for: .horizontal)

        //        switchOnboardPageButton.addTarget(self, action: #selector(switchOnboardPageButtonTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [label, switchOnboardPageButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.horizontal
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing   = 4.0
        return stack
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
    
    private func createCustomPhoneTF()  -> UIStackView {
        let countryCode = "+62"
        
        let countryCodeLabel = createCountryCodeLabel(countryCode)
        phoneNumTF = createTextField()
    
        let phoneStack = UIStackView(arrangedSubviews: [countryCodeLabel, phoneNumTF])
        phoneStack.translatesAutoresizingMaskIntoConstraints = false
        phoneStack.axis  = NSLayoutConstraint.Axis.horizontal
        phoneStack.distribution  = UIStackView.Distribution.fill
        phoneStack.alignment = UIStackView.Alignment.fill
        phoneStack.spacing   = 16.0
        phoneStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        phoneStack.isLayoutMarginsRelativeArrangement = true
        phoneStack.backgroundColor = .customGray
        phoneStack.layer.cornerRadius = 8
        
        return phoneStack
    }
    
    private func createCountryCodeLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 12, weight: .regular) //font ikut UI, kekecilan karna fontname blm sesuai
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = text
        label.textColor = .customBlue
        label.numberOfLines = 0
        return label
    }
    
    private func createDefaultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = text
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }
    
    private func createTextField() -> UITextField {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .secondarySystemBackground
        field.placeholder = "000 0000 0000"
        field.returnKeyType = .continue
        field.textAlignment = .left
        return field
    }
    
}
