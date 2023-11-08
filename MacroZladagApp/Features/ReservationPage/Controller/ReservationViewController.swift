//
//  ReservationViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 07/11/23.
//

import UIKit

class ReservationViewController: UIViewController {
    
    private var headerInputView: UIView!
    private var dateButton: HeaderInputButton!
    private var petAmountButton: HeaderInputButton!
    
    var date = ""
    let datePickerVC  = RangeDatePickerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpComponents()
        
        dateButton.delegate = self
        petAmountButton.delegate = self
        datePickerVC.delegate = self

    }
    
    private func setUpComponents() {
        headerInputView = createHeaderInput()
        
        setupConstraints()
    }
    private func setupConstraints() {
        view.addSubview(headerInputView)
        NSLayoutConstraint.activate([
            headerInputView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            headerInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func createHeaderInput() -> UIView {
        dateButton = HeaderInputButton("Tanggal", "7 Oct - 9 Oct 2023", .date)
        petAmountButton = HeaderInputButton("Anabul", "1 Kucing 2 Anjing", .petAmount)
        
        let stack = UIStackView(arrangedSubviews: [dateButton, petAmountButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 16
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customLightGray3
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        return view
    }
}

extension ReservationViewController: HeaderInputButtonDelegate {
    func btnTapped(_ senderButtonType: HeaderInputButton.ButtonType) {
        if senderButtonType == .date {
            dateButtonAction()
        } else if senderButtonType == .petAmount {
            petAmountButtonAction()
        }
    }
    
    private func dateButtonAction() {
        print("Date button tapped")
        let vc  = RangeDatePickerViewController()
        let navVc = UINavigationController(rootViewController: vc)
        
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 10
            sheet.detents = [
                .custom(resolver: { context in
                    0.83 * context.maximumDetentValue
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        present(navVc, animated: true) { [self] in
//            updateData(date)
        }
        
//        if (startDate != nil) {
//            vc.startDateLabel.text = String(vc.getDate(self.startDate!))
////            print(startDate)
//        } else {
//            vc.startDate = nil
//        }
//
//        if (endDate != nil) {
//            vc.endDateLabel.text = String(vc.getDate(self.endDate!))
////            print(endDate)
//        } else {
//            vc.endDate = nil
//        }
        
//        delegate?.navigationController?.present(navVc, animated: true, completion: nil)
    }
    
    private func petAmountButtonAction() {
        print("Pet Amount button tapped")
    }
    
}

extension ReservationViewController: RangeDatePickerViewControllerDelegate {
    func updateData(_ btn: UIButton) {
        
    }
}

