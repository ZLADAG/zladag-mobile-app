//
//  OnboardPromptLabelButton.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 25/10/23.
//

import UIKit

// MARK: Protocols
protocol OnboardPromptLabelButtonDelegate: AnyObject {
    func defaultBtnTapped()
}

class OnboardPromptLabelButton: UIView {
    
    weak var delegate: OnboardPromptLabelButtonDelegate?
    
    var defaultBtn: UIButton!
    var defaultLabel: UILabel!
    var timeLabel: UILabel!
    
    private var labelBtnStack: UIStackView!
    private var btnStack: UIStackView!
    
    private var timelimit = 0.0
    
    // MARK: Initialize Methods
    init(labelText: String, buttonText: String) {
        super.init(frame: .zero)
        setUpComponents(labelText, buttonText)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: Public Functions
    func setTimelimit(num: TimeInterval) {
        self.timelimit = num
    }
    
    // MARK: Private Functions
    private func setUpComponents(_ lblText: String, _ btnText: String){
        labelBtnStack = createLabelBtnStack(lblText, btnText)
        setUpConstraints()
    }
    
    private func setUpConstraints(){
        
        self.addSubview(labelBtnStack)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Set wraping constraint
        NSLayoutConstraint.activate([
            labelBtnStack.topAnchor.constraint(equalTo: self.topAnchor),
            labelBtnStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            labelBtnStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    
    // MARK: UI Creation
    func addTimeLabel(_ time: TimeInterval) {
        timelimit = time
        /// Promp button time label
        timeLabel = createDefaultLabel(" di \(timelimit)")
        timeLabel.textColor = .systemGray2
        timeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        timeLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        btnStack.addArrangedSubview(timeLabel)
    }
    
    private func createLabelBtnStack(_ lblText: String, _ btnText: String) -> UIStackView {
        
        /// Prompt label
        defaultLabel = createDefaultLabel(lblText)
        defaultLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        defaultLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        /// Prompt button
        defaultBtn = createDefaultButton("")
        let attributedText = NSMutableAttributedString(string: btnText)
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: (defaultBtn.titleLabel?.font.pointSize)!), range: range)
        defaultBtn.setAttributedTitle(attributedText, for: .normal)
        
        defaultBtn.setContentCompressionResistancePriority(.required, for: .horizontal)
        defaultBtn.setContentHuggingPriority(.required, for: .horizontal)
        defaultBtn.addTarget(self, action: #selector(defaultBtnTapped), for: .touchUpInside)
        
        /// Promp button time label
//        timeLabel = createDefaultLabel(" di \(timelimit)")
//        timeLabel.textColor = .systemGray2
//        timeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
//        timeLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        btnStack = UIStackView(arrangedSubviews: [defaultBtn])
        btnStack.translatesAutoresizingMaskIntoConstraints = false
        btnStack.axis  = NSLayoutConstraint.Axis.horizontal
        btnStack.distribution  = UIStackView.Distribution.fill
        btnStack.alignment = UIStackView.Alignment.fill
        btnStack.spacing   = 0.0
        
        let stack = UIStackView(arrangedSubviews: [defaultLabel, btnStack])
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
    
    private func createDefaultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = text
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }
    
    // MARK: Selectors
    @objc func defaultBtnTapped() {
        delegate?.defaultBtnTapped()
    }
    
}
