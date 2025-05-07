//
//  HomeScreenView.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/1/25.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        tabBarItem = .init(title: "Home", image: UIImage(systemName: "house"), tag: 0)
    }
    
    
}
