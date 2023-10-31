//
//  OtpVerificationViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 23/10/23.
//

import UIKit

class OtpVerificationViewController: UIViewController {
    
    private var otpTimeLimit: TimeInterval = 60.0 // in seconds (1 min)
    private var otpTimeLeft : TimeInterval = 0.0 // in seconds
    
    private var isOtpEnded = true
    private var timer = Timer()
    
    var phoneNum = ""
    
    // MARK: UI Components
    private var header = OnboardHeader(title: "Verifikasi OTP", caption: "")
    
    private var otpFieldStack = OtpTextField()
    
    private var resendOtpPromptLB = OnboardPromptLabelButton(
        labelText: "Belum terima OTP?",
        buttonText: "Kirim ulang"
    )
    
    private var allComponentStack: UIStackView!
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setUpComponents()
        
        otpFieldStack.delegate = self
        resendOtpPromptLB.delegate = self
    }
    
    // MARK: Private Functions
    private func setUpComponents(){
        
        header.captionLabel.text = "Masukan OTP yang telah kami kirimkan ke \n\(phoneNum) via Whatsapp"
        
        /// Add time label
        resendOtpPromptLB.addTimeLabel(otpTimeLimit)
        resendOtpPromptLB.timeLabel.isHidden = true
        
        allComponentStack = UIStackView(arrangedSubviews: [otpFieldStack, resendOtpPromptLB])
        allComponentStack.translatesAutoresizingMaskIntoConstraints = false
        allComponentStack.axis  = NSLayoutConstraint.Axis.vertical
        allComponentStack.distribution  = UIStackView.Distribution.fill
        allComponentStack.alignment = UIStackView.Alignment.fill
        allComponentStack.spacing   = 36.0
        
        setUpConstraints()
        
    }
    private func setUpConstraints(){
        
        view.addSubview(header)
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        view.addSubview(allComponentStack)
        NSLayoutConstraint.activate([
            
            // Set wraping constraint
            allComponentStack.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 40),
            allComponentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            allComponentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
        
    }
    
    // MARK: Function
    func setUpTimer() {
        isOtpEnded = chackTimeLimit()
        
        if !isOtpEnded {
            otpTimeLeft = otpTimeLimit
            startTimer()
        }
    }
    private func chackTimeLimit() -> Bool{
        
        if otpTimeLimit > 0 {
            return false
        }
        return true
    }
    
    private func startTimer() {
        /// Initialization of the Timer with interval every inputted second with the function call.
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func endTimer() {
        timer.invalidate()
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = totalSeconds / 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // MARK: Selectors
    @objc func updateTime() {
        resendOtpPromptLB.timeLabel.text = " di \(timeFormatted(Int(otpTimeLeft)))"
        
        resendOtpPromptLB.defaultBtn.isEnabled = false
        resendOtpPromptLB.timeLabel.isHidden = false
        
        if otpTimeLeft > 0 {
            otpTimeLeft -= 1
        } else {
            /// Activate button to resend OTP
            resendOtpPromptLB.defaultBtn.isEnabled = true
            resendOtpPromptLB.timeLabel.isHidden = true
            endTimer()
        }
    }
    
}


extension OtpVerificationViewController: OtpTextFieldDelegate {
    func validateOtp() {
            
        let otpCode = otpFieldStack.getOtpCode()
            
        AppAccountManager.shared.validateOtpVerification(no: phoneNum, otpCode: otpCode, completion: { (isSuccess, message) in
            print("huahaha")
            if isSuccess {
                print("YEE")
                self.otpFieldStack.errorLabel.text = ""
                self.otpFieldStack.errorLabel.isHidden = true
                
                // MARK: ADD ACC HERE
                //...
                
            } else {
                print(message ?? "??")
                self.otpFieldStack.errorLabel.text = message!
                self.otpFieldStack.errorLabel.isHidden = false
            }
        })
        
    }
    
}

/// Prompt Label Button Protocol
extension OtpVerificationViewController: OnboardPromptLabelButtonDelegate {
    
    func defaultBtnTapped() {
        setUpTimer()
    }
    
}
