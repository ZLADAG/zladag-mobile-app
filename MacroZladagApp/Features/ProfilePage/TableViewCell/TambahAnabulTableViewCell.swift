//
//  TambahAnabulTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 08/11/23.
//

import UIKit

class TambahAnabulTableViewCell: UITableViewCell {
    
    static let identifier = "TambahAnabulTableViewCell"
    
    weak var mainViewController: ProfileViewController?
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orangeButtonWithOpacity
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        
        
        return button
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        selectionStyle = .none
        backgroundColor = .white
        
    }
    
    func configure() {
        addSubview(button)
        
        button.frame.size = CGSize(width: 342, height: 44)
        button.frame = CGRect(
            x: frame.midX - button.width/2,
            y: 16,
            width: button.width,
            height: button.height
        )
        
        let label = UILabel()
        label.text = "Tambah Anabul"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .customOrange
        label.sizeToFit()
        
        button.addSubview(label)

        label.frame.origin = CGPoint(
            x: button.frame.midX - ((label.width + 30) / 2),
            y: 12
        )

        let plusIcon = UIImageView(image: UIImage(named: "plus-icon"))
        plusIcon.tintColor = .customOrange
        plusIcon.contentMode = .scaleAspectFill
        
        button.addSubview(plusIcon)
        
        plusIcon.frame.size = CGSize(width: 20, height: 20)
        plusIcon.frame.origin = CGPoint(x: label.left - plusIcon.width - 10, y: label.frame.midY - (plusIcon.height / 2))
        
        button.addTarget(self, action: #selector(onClickTambahAnabulButton), for: .touchUpInside)
    }
    
    @objc func onClickTambahAnabulButton() {
        guard let mainViewController else { return }
        
        mainViewController.navigationController?.pushViewController(TambahProfilAnabulViewController(), animated: true)
    }

}
