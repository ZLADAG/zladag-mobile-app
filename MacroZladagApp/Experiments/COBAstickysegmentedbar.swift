//
//  COBAstickysegmentedbar.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 18/10/23.
//

import UIKit

class CobaStickysegmentedBar: UIViewController, UIScrollViewDelegate {
    // ... (your existing code)
    
    // Content Scroll View
    var scrollview: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false // Enable auto layout
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = true
        scrollView.backgroundColor = .customLightOrange
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return scrollView
    

    }()
    
    lazy var segmentedContainerView: UIView = {
        let segmentedView = UIView()
        segmentedView.translatesAutoresizingMaskIntoConstraints = false
        segmentedView.backgroundColor = .customBlue
        return segmentedView
    }()
    
    // Define a top constraint for the segmented view container
    var segmentedViewTopConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // ... (your existing code)
        // Scroll view
        view.addSubview(scrollview)

        NSLayoutConstraint.activate([
            scrollview.topAnchor.constraint(equalTo: view.topAnchor),
            scrollview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollview.bottomAnchor.constraint(equalTo: (view.topAnchor), constant: 0),
            scrollview.heightAnchor.constraint(equalToConstant: 900)
        ])
        scrollview.backgroundColor = .customOrange
        scrollview.contentSize.height = 900

        
        // Add the segmented control container to the view
        view.addSubview(segmentedContainerView)

        // Set up Auto Layout constraints for the segmented container
        segmentedViewTopConstraint = segmentedContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate([
            segmentedViewTopConstraint,
            segmentedContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedContainerView.heightAnchor.constraint(equalToConstant: 45),
        ])

        // ... (your existing code)

        // Set up the scroll view delegate to monitor scrolling
        scrollview.delegate = self
    }

    // Adjust the segmented view's position as the user scrolls
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y

        // You can adjust this value as needed to control when the segmented view sticks
        let threshold: CGFloat = 100

        if yOffset > threshold {
            // Stick the segmented view under the navigation bar
            segmentedViewTopConstraint.constant = yOffset - threshold
        } else {
            // Keep the segmented view at its original position
            segmentedViewTopConstraint.constant = 0
        }
    }

    // ... (your existing code)
}
