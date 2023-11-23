//
//  ReservationSuccessPageViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 17/11/23.
//

import UIKit

class ReservationSuccessPageViewController: UIViewController {
    
    var upperViewController: ReservationViewController?

    var orderHistoryButton : PrimaryButtonFilled!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpComponents()
    }
    
    func setUpComponents() {
        /// Illustration
        let illustrationImg = UIImageView()
        illustrationImg.translatesAutoresizingMaskIntoConstraints = false
        illustrationImg.image = UIImage(systemName: "checkmark")
        illustrationImg.tintColor = UIColor.customOrange
        illustrationImg.contentMode = .scaleAspectFit
        illustrationImg.clipsToBounds = true
        
        /// Message
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = .systemFont(ofSize: 24, weight: .bold)
        messageLabel.textColor = .textBlack
        messageLabel.numberOfLines = 0
        messageLabel.text = "Pesananmu Kami Terima"
        messageLabel.textAlignment = .center
        
        let subMessageLabel = UILabel()
        subMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        subMessageLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subMessageLabel.textColor = .customLightGray
        subMessageLabel.numberOfLines = 0
        subMessageLabel.text = "Kami akan menginformasikan secepatnya ya! maksimal 1x24 jam"
        subMessageLabel.textAlignment = .center
        
        let allMessageStack = UIStackView(arrangedSubviews: [messageLabel, subMessageLabel])
        allMessageStack.translatesAutoresizingMaskIntoConstraints = false
        allMessageStack.axis = .vertical
        allMessageStack.alignment = .fill
        allMessageStack.distribution = .fill
        allMessageStack.spacing = 8
        
        let imageMessageWrap = UIStackView(arrangedSubviews: [illustrationImg, allMessageStack])
        imageMessageWrap.translatesAutoresizingMaskIntoConstraints = false
        imageMessageWrap.axis = .vertical
        imageMessageWrap.alignment = .center
        imageMessageWrap.distribution = .fill
        imageMessageWrap.spacing = 24
        
        /// Order history button
        orderHistoryButton = PrimaryButtonFilled(btnTitle: "Lihat Pesanan Anda")
        orderHistoryButton.delegate = self
        
        let allContent = UIStackView(arrangedSubviews: [imageMessageWrap, orderHistoryButton])
        allContent.translatesAutoresizingMaskIntoConstraints = false
        allContent.axis = .vertical
        allContent.alignment = .fill
        allContent.distribution = .fill
        allContent.spacing = 66
        
        /// Constraints
        view.addSubview(allContent)
        NSLayoutConstraint.activate([
            allContent.topAnchor.constraint(equalTo: view.topAnchor, constant: 148),
            allContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            allContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
        
        NSLayoutConstraint.activate([
            illustrationImg.widthAnchor.constraint(equalToConstant: 182),
            illustrationImg.heightAnchor.constraint(equalToConstant: 182),
        ])
    }

}

extension ReservationSuccessPageViewController : PrimaryButtonFilledDelegate {
    func btnTapped() {
        print("ReservationSuccessPageViewController tapped")
        dismiss(animated: true)
        self.upperViewController?.navigationController?.popToRootViewController(animated: true)
    }
}
