//
//  DatePickerViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 09/10/23.
//

import UIKit

class TEMPDatePickerViewController: UIViewController {

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
    
    lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Dari"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var endDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sampai"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    lazy var startDateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Pilih Tanggal"
        textField.borderStyle = .none
        textField.backgroundColor = .customGray
        textField.textColor = .customGray3
        
        textField.inputView = startDatePicker
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always

        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.rightViewMode = UITextField.ViewMode.always
        textField.rightView = UIImageView(image: UIImage(systemName: "calendar"))
        textField.rightView?.tintColor = .customOrange
        
        return textField
    }()
    
    lazy var endDateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.placeholder = "Pilih Tanggal"
        textField.borderStyle = .none
        textField.backgroundColor = .customGray
        textField.textColor = .customGray3
        
        textField.inputView = endDatePicker
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always

        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.rightViewMode = UITextField.ViewMode.always
        textField.rightView = UIImageView(image: UIImage(systemName: "calendar"))
        textField.rightView?.tintColor = .customOrange

        return textField
    }()
    
    lazy var startDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .date
        picker.minimumDate = Date()
        picker.tintColor = .customOrange
        picker.backgroundColor = .white
        picker.addTarget(self, action: #selector(startDatePickerValueChanged(_:)), for: .valueChanged)
        
        return picker
    }()
    
    lazy var endDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .date
        picker.minimumDate = Date()
        picker.tintColor = .customOrange
        picker.backgroundColor = .white
        picker.addTarget(self, action: #selector(endDatePickerValueChanged(_:)), for: .valueChanged)
        
        return picker
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
        
        stackView.addArrangedSubview(startDateLabel)
        stackView.addArrangedSubview(startDateTextField)
        
        return stackView
    }()
    
    lazy var endDateStackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false;

        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 5.0
        
        stackView.addArrangedSubview(endDateLabel)
        stackView.addArrangedSubview(endDateTextField)
//        stackView.backgroundColor = .customOrange

//        self.view.addSubview(stackView)
        return stackView
        
    }()
    
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(datePickerStackView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }

    //MARK: Functions
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            startDateTextField.heightAnchor.constraint(equalToConstant: 44),
            endDateTextField.heightAnchor.constraint(equalToConstant: 44),
            
            datePickerStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            datePickerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            datePickerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
        ])
        
        
    }
    
    func getDate(_ sender: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "in")
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: sender)
    }
    
    //MARK: Selector Function
    @objc func startDatePickerValueChanged(_ sender: UIDatePicker) {
        startDate = sender.date
        
        endDatePicker.minimumDate = startDate

        if (endDate != nil){
            let compareDate = startDate!.compare(endDate!)
            if compareDate != .orderedAscending {
                endDate = nil
                endDateTextField.text = nil
            }
        }
        
        let dateText = getDate(startDate!)
        startDateTextField.text = dateText
        
        let extractedStartDate = String(startDateTextField.text!.prefix(7))
        let extractedEndDate = String(endDateTextField.text!.prefix(7))
        
        delegate?.startDate = self.startDate
        delegate?.dateTextField.text = "\(extractedStartDate) - \(extractedEndDate)"
        
        // DEBUG
//        print("Start Date Selected: \(dateFormatter.string(from: sender.date))")

    }
    
    @objc func endDatePickerValueChanged(_ sender: UIDatePicker) {
        
        endDate = sender.date
        
        let dateText = getDate(endDate!)
        endDateTextField.text = dateText
        
        let extractedStartDate = String(startDateTextField.text!.prefix(7))
        let extractedEndDate = String(endDateTextField.text!.prefix(7))
        
        delegate?.startDate = self.startDate
        delegate?.dateTextField.text = "\(extractedStartDate) - \(extractedEndDate)"
        
        // DEBUG
//        print("End Date Selected: \(dateFormatter.string(from: sender.date))")
    }
    
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
