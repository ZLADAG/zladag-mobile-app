//
//  OrderDetailsSheetViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 20/11/23.
//

import UIKit

class OrderDetailsSheetViewController: UIViewController {

    let viewModel: OrderDetailsByIdViewModel
    
    init(viewModel: OrderDetailsByIdViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: SCROLL VIEW
    
    let scrollView = UIScrollView()
    let contentView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.green.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    // MARK: MAIN & SUB LABELS
    let mainLabel = UILabel()
    let subLabel = UILabel()
    var mainLabelString = "Menunggu konfirmasi"
    var subLabelString = "Pet hotel akan segera mengkonfirmasi pesananmu"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(viewModel.boardingName)
        
        setupNavBar()
        setupUI()
    }
    
    func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        
        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    private func setupUI() {
        setupScrollView()
        setupMainAndSubLabels()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.delegate = self
        
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -56 + 24),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalToConstant: view.width - (24 * 2)),
            contentView.heightAnchor.constraint(equalToConstant: 5000),
        ])
    }
    
    private func setupMainAndSubLabels() {
        scrollView.addSubview(mainLabel)
        scrollView.addSubview(subLabel)
        
        mainLabel.backgroundColor = .clear
        mainLabel.text = self.mainLabelString
        mainLabel.textColor = .textBlack
        mainLabel.textAlignment = .center
        mainLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        subLabel.backgroundColor = .clear
        subLabel.text = self.subLabelString
        subLabel.textColor = .grey1
        subLabel.textAlignment = .center
        subLabel.numberOfLines = 2
        subLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 20),

            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 4),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.widthAnchor.constraint(equalToConstant: 332),
            subLabel.heightAnchor.constraint(equalToConstant:  36 + 2),
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

extension OrderDetailsSheetViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navigationController?.navigationBar.transform = .init(
            translationX: 0,
            y: -56 + 24
        )
    }
}
