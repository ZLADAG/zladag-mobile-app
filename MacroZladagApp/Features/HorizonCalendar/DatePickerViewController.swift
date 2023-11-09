//
//  DatePickerViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 09/10/23.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    var delegate: MainHeaderCollectionReusableView?
    
    var startDate: Date?
    var endDate: Date?
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tanggal Penitipan"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var titleStartDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Dari"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var titleEndDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sampai"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var endDateLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var datePickerStackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 24.0
        
        stackView.addArrangedSubview(startDateStackView)
        stackView.addArrangedSubview(endDateStackView)
        
        return stackView
    }()
    
    lazy var startDateStackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 4.0
        
        stackView.addArrangedSubview(titleStartDateLabel)
        stackView.addArrangedSubview(startDateLabel)
        
        return stackView
    }()
    
    lazy var endDateStackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 5.0
        
        stackView.addArrangedSubview(titleEndDateLabel)
        stackView.addArrangedSubview(endDateLabel)
        //        stackView.addArrangedSubview(endDateTextField)
        //        stackView.backgroundColor = .customOrange
        
        //        self.view.addSubview(stackView)
        return stackView
        
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .date
        picker.minimumDate = Date()
        picker.tintColor = .customOrange
        picker.backgroundColor = .white
        picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        return picker
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Simpan", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .customOrange
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
//    override func loadView() {
//        super.loadView()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(datePickerStackView)
        view.addSubview(datePicker)
        view.addSubview(saveButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        extractDate()
//    }
    
    //MARK: Functions
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            datePickerStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            datePickerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            datePickerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            datePicker.topAnchor.constraint(equalTo:datePickerStackView.bottomAnchor, constant: 30),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.topAnchor.constraint(equalTo:datePicker.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
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
        
        var extractedAllDate = ""
        
        if startDate == endDate {
            extractedAllDate = "\(extractedStartDate)"
        } else {
            extractedAllDate = "\(extractedStartDate) - \(extractedEndDate)"
        }
        
        delegate?.minDate = self.startDate ?? Date()
        delegate?.maxDate = self.endDate ?? Date()
        delegate?.dateFieldView.thisLabel.text = "\(extractedAllDate)"
    }
    
    //MARK: Selector Function
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        
        // Start Date
        startDate = sender.date
        
        let startDateText = getDate(startDate!)
        startDateLabel.text = startDateText
        
        // End Date
        endDate = sender.date
        
        let endDateText = getDate(endDate!)
        endDateLabel.text = endDateText
        
        //        let extractedStartDate = String(startDateLabel.text!.prefix(7))
        //        let extractedEndDate = String(endDateLabel.text!.prefix(7))
        //
        //        delegate?.startDate = self.startDate
        //        delegate?.endDate = self.endDate
        //        delegate?.dateTextField.text = "\(extractedStartDate) - \(extractedEndDate)"
        
        // DEBUG
        print("Date Selected: \(startDateText) - \(endDateText)")
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        print("Tapped")
        
        extractDate()
        dismiss(animated: true)
    }
    
}
