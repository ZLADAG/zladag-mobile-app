//
//  OrderLabelView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 16/11/23.
//

import UIKit

class OrderLabelView: UIView {
    
    let orderLabel: OrderLabel
    
    let label = UILabel()
    
    init(orderLabel: OrderLabel) {
        self.orderLabel = orderLabel
        super.init(frame: .zero)
        
        switch orderLabel {
        case .menunggu:
            backgroundColor = .orderLabelBlueBG
            label.textColor = .orderLabelBlue
        case .selesai:
            backgroundColor = .orderLabelGrayBG
            label.textColor = .orderLabelGray
        case .gagal:
            backgroundColor = .orderLabelRedBG
            label.textColor = .orderLabelRed
        }
        
        layer.cornerRadius = 4
        layer.masksToBounds = true
        
        setupLabel()
        frame.size = CGSize(width: label.width + 16, height: label.height + 6)
        label.frame = CGRect(x: 8, y: 3, width: label.width, height: label.height)
        
    }
    
    private func setupLabel() {
        addSubview(label)
        
        label.text = orderLabel.rawValue
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.frame.size = CGSize(width: label.width, height: label.height)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}
