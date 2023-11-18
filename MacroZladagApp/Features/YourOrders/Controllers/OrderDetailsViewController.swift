//
//  OrderDetailsViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/11/23.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    
    let orderId: String
    var viewModel: OrderDetailsByIdViewModel? = nil
    
    init(orderId: String) {
        self.orderId = orderId
        super.init(nibName: nil, bundle: nil)
    }
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .customOrange
        spinner.backgroundColor = .clear
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orangeOpacityBackground
        navigationItem.title = "Order Details"
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .textBlack
        
        
        // TODO: COBA MAIN NAVBAR TINT
        
        setupLoadingScreen()
        
        fetchData {
            print(self.orderId)
            print()
            print(self.viewModel!)
            
            DispatchQueue.main.async { [weak self] in
                self?.spinner.hidesWhenStopped = true
                self?.spinner.stopAnimating()
                
                self?.setupUI()
            }
        }
    }
    
    private func setupUI() {
        setupScrollView()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalToConstant: view.width),
            contentView.heightAnchor.constraint(equalToConstant: 5000),
        ])
    }
    
    
    func setupLoadingScreen() {
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        spinner.startAnimating()
    }
    
    private func fetchData(completion: (() -> ())? = nil) {
        APICaller.shared.getOrderDetailsById(orderId: self.orderId) { result in
            switch result {
            case .success(let response):
                self.viewModel = OrderDetailsByIdViewModel(
                    boardingSlug: response.data.boarding.slug,
                    boardingName: response.data.boarding.name,
                    subdistrict: response.data.boarding.subdistrict,
                    province: response.data.boarding.province,
                    contactLink: response.data.boarding.contactLink,
                    petId: response.data.pet.id,
                    peName: response.data.pet.name,
                    petBreed: response.data.pet.petBreed,
                    petAge: response.data.pet.age,
                    petImage: response.data.pet.image,
                    orderId: response.data.order.id,
                    checkInDate: response.data.order.checkInDate,
                    checkOutDate: response.data.order.checkOutDate,
                    orderStatus: response.data.order.status,
                    boardingCage: BoardingCageNameAndPrice(
                        name: response.data.order.boardingCage.name,
                        price: response.data.order.boardingCage.price),
                    boardingServices: response.data.order.boardingServices.compactMap({ boardingService in
                        return BoardingService(
                            name: boardingService.name,
                            price: boardingService.price
                        )
                    }),
                    note: response.data.order.note,
                    totalLodgingPrice: response.data.order.totalLodgingPrice,
                    totalAddOnPrice: response.data.order.totalAddOnPrice,
                    serviceFee: response.data.order.serviceFee,
                    totalAllPrice: response.data.order.totalAllPrice
                )
                
                print("\nFINISH FETCHING ORDER BY ID")
                completion?()
                break
            case .failure(let error):
                print("ERROR WHEN FETCHING getOrderDetailsById")
                print("\(error)\n")
                break
            }
        }
    }
    
    // MARK: @objc UIControl functions
    
    required init(coder: NSCoder) {
        fatalError()
    }

}


