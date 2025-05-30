//
//  HomeScreenViewModel.swift
//  DeliveryFood
//
//  Created by Владимир Федичев on 5/1/25.
//

import UIKit

class HomeScreenViewModel {
    var view: HomeScreenViewInput!
    
}

extension HomeScreenViewModel: HomeScreenViewOutput {
    func didChangeSearchText(_ text: String) {
    }
}


