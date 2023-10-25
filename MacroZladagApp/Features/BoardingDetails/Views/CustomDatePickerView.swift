//
//  File.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 09/10/23.
//

import UIKit

class CustomDatePickerView: UIView {

    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        return picker
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDatePicker()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDatePicker()
    }

    private func setupDatePicker() {
        addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
