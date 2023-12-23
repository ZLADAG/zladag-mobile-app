//
//  PilihAnabulViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 23/12/23.
//

import UIKit

class PilihAnabulViewController: UIViewController {
    
    let usersCats: [UsersPet]
    let usersDogs: [UsersPet]
    
    weak var reservationViewController: ReservationViewController?
    
    let tableView = UITableView()
    
    init(usersCats: [UsersPet], usersDogs: [UsersPet]) {
        self.usersCats = usersCats
        self.usersDogs = usersDogs
            
        
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        overrideUserInterfaceStyle = .light

        setupNavBar()
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AnabulTableViewCell.self, forCellReuseIdentifier: AnabulTableViewCell.identifier)
        tableView.register(AnabulTerpilihTableViewCell.self, forCellReuseIdentifier: AnabulTerpilihTableViewCell.identifier)
        tableView.register(AnabulTidakMemenuhiTableViewCell.self, forCellReuseIdentifier: AnabulTidakMemenuhiTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: NAVBAR
    
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        
        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
    
        let navView = UIView()
        navView.frame = CGRect(x: 0, y: 0, width: 354, height: 32)
        navView.backgroundColor = .clear
        
        let navLabel = UILabel()
        navLabel.text = "Pilih Profil Anabul"
        navLabel.backgroundColor = .clear
        navLabel.textColor = .textBlack
        navLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        navLabel.frame = CGRect(x: 0, y: (32 - 23) / 2, width: 290, height: 23)
        
        navView.addSubview(navLabel)
        
        let closeButton = UIButton()
        let closeButtonImageView = UIImageView(image: UIImage(named: "close-button-nobg"))
        closeButtonImageView.contentMode = .scaleAspectFit
        closeButtonImageView.backgroundColor = .clear
        closeButtonImageView.layer.opacity = 0.45
        closeButtonImageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        closeButton.addSubview(closeButtonImageView)
        closeButton.frame = CGRect(x: navView.frame.maxX - 32, y: 0, width: 32, height: 32)
        navView.addSubview(closeButton)
        
        closeButton.addTarget(self, action: #selector(closeSheet), for: .touchUpInside)
        navigationItem.titleView = navView
    }
    
    @objc func closeSheet() {
        dismiss(animated: true)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}


extension PilihAnabulViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //
    //
    //    }
    
}
