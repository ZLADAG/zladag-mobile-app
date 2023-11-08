//
//  RangeDatePickerViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 08/11/23.
//

import UIKit

protocol RangeDatePickerViewControllerDelegate: AnyObject {
//    func updateData(_ btn: UIButton)
//    func saveButtonTapped(_ btn: UIButton)
}

class RangeDatePickerViewController: UIViewController {
    
    weak var delegate: RangeDatePickerViewControllerDelegate?
    
    weak var parentVC: UIViewController?
    
    var startDateLabel: UILabel!
    var endDateLabel: UILabel!
    
    var dateInfoStack : UIStackView!
    var allContentStack: UIStackView!
    
    var datePicker: UIDatePicker!
    var saveButton: UIButton!
    
    var startDate = Date()
    var endDate = Date()
    var extractedAllDate = "-"
        
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setUpComponents()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        setUpComponents()
    }
    
    //MARK: Functions
    func setUpComponents() {
        let titleLabel = createTitleLabel("Pilih Tanggal Pengiriman")
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)

        let titleStartDateLabel = createTitleLabel("Dari Tanggal")
        startDateLabel = createLabel(startDate.description)

        let titleEndDateLabel = createTitleLabel("Sampai Tanggal")
        endDateLabel = createLabel(endDate.description)
        
        let startDateStackView = createVerticalStack([titleStartDateLabel, startDateLabel], 4)
        let endDateStackView = createVerticalStack([titleEndDateLabel, endDateLabel], 4)
        let dateInfoStack = createDateInfoStack([startDateStackView, endDateStackView])
        
        datePicker = createDatePicker()
        saveButton = createButton()
        
        let stack = createVerticalStack([datePicker, dateInfoStack, saveButton], 24)
        allContentStack = createVerticalStack([titleLabel, stack], 21)
        
        setupConstraints()

    }
    func setupConstraints() {
        view.addSubview(allContentStack)

        NSLayoutConstraint.activate([
            allContentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            allContentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            allContentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            allContentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        
        
    }
    
    func getDate(_ sender: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "in")
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: sender)
    }
    
    func extractDate() {
        let extractedStartDate = String(startDateLabel.text!.prefix(7))
        let extractedEndDate = String(endDateLabel.text!.prefix(7))
                
        if startDate == endDate {
            extractedAllDate = "\(startDateLabel.text!)"
        } else {
            extractedAllDate = "\(extractedStartDate) - \(extractedEndDate)"
        }
    }
    func getExtractedDate() -> String{
        extractDate()
        return extractedAllDate
    }
    
    //MARK: Selector Function
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        
        // Start Date
        startDate = sender.date
        
        let startDateText = getDate(startDate)
        startDateLabel.text = startDateText
        
        // End Date
        endDate = sender.date
        
        let endDateText = getDate(endDate)
        endDateLabel.text = endDateText
        
        // DEBUG
//        print("Date Selected: \(startDateText) - \(endDateText)")
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        print("Tapped")
        extractDate()
        print("extractedAllDate: \(extractedAllDate)")
//        delegate?.updateData(sender)
        dismiss(animated: true)
    }
    
}


extension RangeDatePickerViewController {
    
    private func createTitleLabel(_ text: String) -> UILabel {
        let label = createLabel(text)
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }
    private func createLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = text
        return label
    }
    
    private func createVerticalStack(_ views: [UIView],_ spacing: Double) -> UIStackView {
        let stackView   = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = spacing
        return stackView
    }
    private func createDateInfoStack(_ views: [UIView]) -> UIStackView {
        let stackView   = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 24.0
        return stackView
    }
    
    
    private func createDatePicker() -> UIDatePicker {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .date
        picker.minimumDate = Date()
        picker.tintColor = .customOrange
        picker.backgroundColor = .white
        picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        return picker
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Simpan", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .customOrange
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        return button
    }
}
