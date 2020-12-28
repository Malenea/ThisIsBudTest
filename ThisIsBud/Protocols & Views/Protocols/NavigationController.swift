//
//  NavigationController.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

class NavigationController : UINavigationController {

    override var preferredStatusBarStyle : UIStatusBarStyle {
        if let topVC = viewControllers.last { return topVC.preferredStatusBarStyle }
        return .default
    }

}
