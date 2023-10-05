//
//  BoardingDetailsViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 04/10/23.
//

import UIKit

class BoardingDetailsViewController: UIViewController {

    let viewModel: BoardingsCellViewModel
    
    init(viewModel: BoardingsCellViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil) // INI APA SIH
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(nameLabel)
        view.backgroundColor = .customGray
    }
    
    override func viewDidLayoutSubviews() {
        nameLabel.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        nameLabel.backgroundColor = .red
        nameLabel.text = viewModel.name
    }
    
}
