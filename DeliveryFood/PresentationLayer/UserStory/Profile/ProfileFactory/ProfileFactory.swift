//
//  ProfileFactory.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 6/13/25.
//

import UIKit

final class ProfileFactory {
    static func makeProfileScreen() -> UIViewController {
        let viewController = ProfileViewController()
        return viewController
    }
}
