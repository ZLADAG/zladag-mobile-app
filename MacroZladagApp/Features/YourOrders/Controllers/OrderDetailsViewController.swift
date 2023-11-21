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
    var sheetViewController: OrderDetailsSheetViewController?
    
    init(orderId: String) {
        self.orderId = orderId
        super.init(nibName: nil, bundle: nil)
    }
    
    // LEFT BAR BUTTON ACTS AS BACK BUTTON
    let leftBarButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        let backImageView = UIImageView(image: UIImage(named: "rounded-barbackbutton"))
        backImageView.contentMode = .scaleAspectFit
        backImageView.frame.size = CGSize(width: 32, height: 32)
        
        button.addSubview(backImageView)
        
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        
        backImageView.frame = CGRect(
            x: (button.frame.width - backImageView.width) / 2,
            y: (button.frame.height - backImageView.height) / 2,
            width: backImageView.width,
            height: backImageView.height
        )
        
        return button
    }()
    
    // MARK: BACKGROUND IMAGE
    var backgroundImageString: String = ""
    let backgroundImageView = UIImageView()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .customOrange
        spinner.backgroundColor = .clear
        return spinner
    }()
    
    let button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orangeOpacityBackground
        navigationItem.title = ""
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .textBlack
        
        setupLoadingScreen()
        fetchData {
            if let viewModel = self.viewModel {
                DispatchQueue.main.async { [weak self] in
                    self?.spinner.hidesWhenStopped = true
                    self?.spinner.stopAnimating()
                    
                    self?.setupNavigationBar()
                    self?.setupBackgroundImageView()
                    self?.setupSheet(viewModel: viewModel)
                }
            }
        }
        
        
    }
    
    func setupNavigationBar() {
        navigationItem.setHidesBackButton(true, animated: true)
        
        navigationController?.navigationBar.backgroundColor = .clear
        
        leftBarButton.addTarget(self, action: #selector(onClickBackBarButton), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        
        self.backgroundImageString = "menunggu-bg"
        backgroundImageView.image = UIImage(named: backgroundImageString)
        
        backgroundImageView.frame.size = CGSize(width: view.width, height: view.height)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    
    func setupSheet(viewModel: OrderDetailsByIdViewModel) {
        let vc  = OrderDetailsSheetViewController(viewModel: viewModel)
        vc.scrollView.isScrollEnabled = false
        
        let navVc = UINavigationController(rootViewController: vc)
        
        self.sheetViewController = vc
        navVc.presentationController?.delegate = self
        
        navVc.isModalInPresentation = true
        navVc.modalPresentationStyle = .fullScreen
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 16
            sheet.detents = [
                .custom(resolver: { context in
                    0.99 * context.maximumDetentValue
                }),
                .medium()
            ]
            
            sheet.prefersGrabberVisible = false
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        }
        
        navigationController?.present(navVc, animated: true)
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
    
    // MARK: FETCH DATA
    
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
                    petName: response.data.pet.name,
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
                
                print("\nFINISHED FETCHING ORDER BY ID")
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
    
    @objc func onClickBackBarButton() {
        self.sheetViewController?.dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}

// MARK: Sheet Presentation Controller
extension OrderDetailsViewController: UISheetPresentationControllerDelegate {
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        
        guard let currentDetent = sheetPresentationController.selectedDetentIdentifier?.rawValue else { return }
        
        if currentDetent.contains("dynamic") {
            self.sheetViewController?.scrollView.isScrollEnabled = true
            self.sheetViewController?.sheetPresentationController?.prefersGrabberVisible = true
        } else if currentDetent.contains("medium") {
            self.sheetViewController?.scrollView.isScrollEnabled = false
            self.sheetViewController?.sheetPresentationController?.prefersGrabberVisible = false
        }
        
    }
    
}


