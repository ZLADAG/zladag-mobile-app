//
//  YourOrdersViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import Foundation
import UIKit

class YourOrdersViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        return imageView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        
        
        APICaller.shared.getRandomImage { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print("KACAU \(error)")
                
                DispatchQueue.main.async {
                    let vc = ErrorPageViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                break
            }
        }
    }
    
}
