//
//  HeaderInputCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 08/11/23.
//

import UIKit
protocol HeaderDateInputCollectionViewCellDelegate {
    func dateInputBtnTapped(cell: UICollectionViewCell, atIndexPath: IndexPath)

    func updateDateLabelText(dateText: String)
}
class HeaderDateInputCollectionViewCell: UICollectionViewCell {
    static let identifier = "HeaderDateInputCollectionViewCell"
    
    var delegate: HeaderDateInputCollectionViewCellDelegate?

    var datePickerButton : HeaderInputButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        datePickerButton = HeaderInputButton(AppAccountManager.shared.calendarTextDetails, .date)
        datePickerButton.delegate = self
        updateInfoLabel()
        addSubview(datePickerButton)
        NSLayoutConstraint.activate([
            datePickerButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            datePickerButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            datePickerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            datePickerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
    
    func updateInfoLabel() {
        self.datePickerButton.infoLabel.text = AppAccountManager.shared.calendarTextDetails
    }
   
    
}

extension HeaderDateInputCollectionViewCell: HeaderInputButtonDelegate {
    func btnTapped(_ senderButtonType: HeaderInputButton.ButtonType) {        
        if let indexPath = findCellIndexPath() {
            delegate?.dateInputBtnTapped(cell: self, atIndexPath: indexPath)
        } else {
            print("Unable to determine indexPath for the cell.")
        }
    }
    
    private func findCellIndexPath() -> IndexPath? {
        guard let collectionView = superview as? UICollectionView else {
            return nil
        }
        return collectionView.indexPath(for: self)
    }
}

