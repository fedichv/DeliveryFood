//
//  MainTabBarController.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/1/25.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .blue
        UITabBar.appearance().backgroundColor = .red
        UITabBar.appearance().layer.borderWidth = 2
        UITabBar.appearance().layer.borderColor = UIColor.blue.cgColor
    }
}
