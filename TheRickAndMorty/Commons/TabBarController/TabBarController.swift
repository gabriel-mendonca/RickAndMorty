//
//  TabBarController.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 25/05/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = true
        self.tabBar.barTintColor = .red
        self.tabBar.unselectedItemTintColor = .blue
        self.tabBar.tintColor = .darkGray
    }
}
