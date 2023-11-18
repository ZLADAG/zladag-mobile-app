//
//  OrderDetailsViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/11/23.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    
    var viewModel: OrderDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        navigationItem.title = "Order Details"
        self.viewModel = OrderDetailsViewModel(hotelName: "ok")
        
        // TODO: COBA MAIN NAVBAR TINT COLOR
        
        
    }

}
