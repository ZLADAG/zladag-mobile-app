//
//  CoretanTambahAnabulViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 26/10/23.
//

import UIKit

class CoretanTambahAnabulViewController: UIViewController, ButtonBuatanDelegate  {

    let button = ButtonBuatan()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tambah Profil Anabul"
        
        view.backgroundColor = .white

        view.addSubview(button)
        button.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func letsgo() {
        navigationController?.pushViewController(TambahProfilAnabulViewController(), animated: true)
    }

}

class ButtonBuatan: UIButton {
    
    weak var delegate: ButtonBuatanDelegate?
    
    init() {
        super.init(frame: .zero)
        
        setTitle("tambah anablul", for: .normal)
        backgroundColor = .red
        
        addTarget(self, action: #selector(tambahAnabulButtonClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tambahAnabulButtonClicked() {
        delegate?.letsgo()
    }
}

protocol ButtonBuatanDelegate: AnyObject { // utk apa?
    func letsgo()
}
