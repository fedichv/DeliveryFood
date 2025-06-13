//
//  OrderFactory.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 6/13/25.
//

import UIKit

final class OrderFactory {
    static func makeOrderScreen() -> UIViewController {
        let viewController = OrderViewController()
        return viewController
    }
}
