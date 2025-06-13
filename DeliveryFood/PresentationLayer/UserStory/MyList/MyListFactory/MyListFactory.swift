//
//  MyListFactory.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 6/13/25.
//

import UIKit

final class MyListFactory {
    static func makeMyListScreen() -> UIViewController {
        let viewController = MyListViewController()
        return viewController
    }
}
