//
//  OnboardingFormViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 23/10/23.
//

import UIKit

class OnboardingFormViewController: UIViewController {
    
    private var titleStack: UIStackView!
    private var allComponentView: UIView!
    
    var signInButton: UIButton!
    
    var signUpPromptLB = OnboardPromptLabelButton(
        labelText: "Sudah punya akun?",
        buttonText: "Masuk"
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .customGray2
        
        setUpComponents()
        signUpPromptLB.delegate = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        setUpNavbar()
        
     
    }

    private func setUpComponents() {
        allComponentView = setUpAllComponent()
        
        view.addSubview(allComponentView)
        
        NSLayoutConstraint.activate([
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            
            allComponentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allComponentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allComponentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    private func setUpNavbar() {
        
        let defaultAppearance = UINavigationBarAppearance()
        defaultAppearance.configureWithOpaqueBackground()
        
        defaultAppearance.backgroundColor = .customOrange
        defaultAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        defaultAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = defaultAppearance
        navigationController?.navigationBar.compactAppearance = defaultAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = defaultAppearance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.setNavigationBarHidden(false, animated: false)

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
        signInButton = UIButton(configuration: .filled())
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.tintColor = .customOrange
        signInButton.addTarget(self, action: #selector(signInBtnTapped), for: .touchUpInside)
        
        signUpPromptLB.translatesAutoresizingMaskIntoConstraints = false
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
                .foregroundColor: UIColor.customBlue, // Change this to the color you want
//                .font: UIFont.boldSystemFont(ofSize: 16) // Customize the font if needed
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
    
    @objc func signInBtnTapped() {
        let signInVC = SignInByWhatsappViewController()
        signInVC.title = "Masuk dengan Nomor Whatsapp"
        
        navigationController?.pushViewController(signInVC, animated: true)
    }

}


extension OnboardingFormViewController: OnboardPromptLabelButtonDelegate {
    func defaultBtnTapped() {
        let signUpVC = CreateAccountViewController()
        signUpVC.title = "Buat Akun"
        
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}
