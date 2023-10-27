//
//  OnboardingFormViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 23/10/23.
//

import UIKit

class OnboardingFormViewController: UIViewController {
    
    private var image: UIImageView!
    private var titleStack: UIStackView!
    private var allComponentView: UIView!
    
    var signInButton = PrimaryButtonFilled(
        btnTitle: "Buat Akun"
    )
    
    var signUpPromptLB = OnboardPromptLabelButton(
        labelText: "Sudah punya akun?",
        buttonText: "Masuk"
    )
    
    let loadingIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .customGray2
        
        setUpComponents()
        
        signInButton.delegate = self
        signUpPromptLB.delegate = self
        
        
        AppAccountManager.shared.isPhoneNumberExist()
        
    }
    
    
    private func setUpComponents() {
        image = createImage("photo.on.rectangle.angled")
        allComponentView = setUpAllComponent()
        
        view.addSubview(image)
        view.addSubview(allComponentView)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: allComponentView.topAnchor),
        ])
        NSLayoutConstraint.activate([
            allComponentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allComponentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allComponentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setUpAllComponent() -> UIView {
        titleStack = createTitleStack()
        let buttonStack = createButtonStack()
        
        let stack = UIStackView(arrangedSubviews: [titleStack, buttonStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.vertical
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing   = 50.0
        
        
        let subView = UIView()
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = .white
        subView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: subView.topAnchor, constant: 24),
            stack.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -74),
            stack.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -24),
        ])
        
        return subView
    }
    
    private func createImage(_ iconName: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: iconName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.tintColor = .customGray
        imageView.contentMode = .scaleAspectFit
        imageView.sizeToFit()
        
        return imageView
    }
    
    private func createTitleStack() -> UIStackView {
        let title = "Temukan penginapan terbaik untuk anabul kamu!"
        let attrSubText = "terbaik"
        let caption = "Corem ipsum dolor sit amet, consectetur adipiscing"
        
        let titleLabel = createAttrTitleLabel(title, attrSubText)
        let captLabel = createDefaultLabel(caption)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, captLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.vertical
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing   = 8.0
        
        return stack
    }
    
    private func createButtonStack() -> UIStackView {
        
        signUpPromptLB.defaultLabel.textColor = .customGray3
        
        let stack = UIStackView(arrangedSubviews: [signInButton, signUpPromptLB])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.vertical
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing   = 10.0
        
        return stack
        
    }
    
    private func createAttrTitleLabel(_ text: String, _ attrSubText: String) -> UILabel {
        let attributedString = NSMutableAttributedString(string: text)
        if let range = text.range(of: attrSubText) {
            let nsRange = NSRange(range, in: text)
            
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.customBlue,
            ]
            attributedString.addAttributes(attributes, range: nsRange)
        }
        
        let attributedLabel = createLabel()
        attributedLabel.font = .systemFont(ofSize: 32, weight: .medium)
        attributedLabel.textAlignment = .center
        attributedLabel.textColor = .black
        attributedLabel.attributedText = attributedString
        
        return attributedLabel
    }
    
    private func createDefaultLabel(_ text: String) -> UILabel {
        let label = createLabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .customGray3
        label.text = text
        return label
    }
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }
    
}

/// Primary Filled Button Protocols
extension OnboardingFormViewController: PrimaryButtonFilledDelegate {
    func btnTapped() {
        let signUpVC = CreateAccountViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}

/// Prompt Label Button Protocols
extension OnboardingFormViewController: OnboardPromptLabelButtonDelegate {
    func defaultBtnTapped() {
        let signInVC = SignInViewController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
}
