//
//  CoretanDropDownViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 01/11/23.
//

import UIKit

class CoretanDropDownViewController: UIViewController {

    let scrollView = UIScrollView()
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let tableView = UITableView()
    let dropDownButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(dropDownButton)
        view.addSubview(tableView)
        
        setupDropDownButton()
        setupTableView()
    }
    
    func kocakDidLoad() {
//        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 24),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24*2),
            contentView.heightAnchor.constraint(equalToConstant: 3000),
            
//            tableView.topAnchor
        ])
        
        setupDropDownButton()
        setupTableView()
    }
    
    func setupDropDownButton() {
//        scrollView.addSubview(dropDownButton)
        
        dropDownButton.setTitle("oke", for: .normal)
        dropDownButton.backgroundColor = .red
        
        dropDownButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dropDownButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            dropDownButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dropDownButton.widthAnchor.constraint(equalToConstant: 100),
            dropDownButton.heightAnchor.constraint(equalToConstant: 35),
            
        ])
        
        dropDownButton.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    @objc func click() {
        print("yeah")
        DispatchQueue.main.async {
//            UIView.animate(withDuration: 2) { _ in
//                self.tableView.isHidden = false
//            }
            UIView.animate(withDuration: 2.0) {
                self.tableView.isHidden = false
            } completion: { _ in
                
            }

            
        }
        
    }
    
    func setupTableView() {
//        scrollView.addSubview(tableView)
        
        tableView.backgroundColor = .green
        tableView.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: dropDownButton.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalToConstant: 400),
            tableView.heightAnchor.constraint(equalToConstant: 1000),
        ])
    }

}

extension CoretanDropDownViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "asdasd"
//        cell.backgroundColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
}
