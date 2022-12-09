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
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .blue
        self.tabBar.tintColor = .darkGray
        configAppearanceTabBar()
        
    }
    
    private func configAppearanceTabBar() {
        let coloredAppearance = UITabBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .white
               
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = coloredAppearance
            UITabBar.appearance().standardAppearance = coloredAppearance
        } else {
            UITabBar.appearance().backgroundColor = .white
        }
    }
}
