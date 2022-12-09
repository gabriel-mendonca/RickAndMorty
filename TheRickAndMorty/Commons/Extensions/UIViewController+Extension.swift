//
//  UIViewController+Extension.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 21/11/22.
//

import Foundation
import UIKit

extension UIViewController {

    internal func hideBottomTabBar(_ hidden: Bool) {
        self.hidesBottomBarWhenPushed = hidden
    }

    internal func hideNavigationBar(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    internal func showNavigationBar(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    internal func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
    
    internal func addToolbar(searchTextField: UISearchBar) {
            let toolbar = UIToolbar()
            toolbar.barStyle = UIBarStyle.default
            toolbar.isTranslucent = true
            let left = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.hideKeyboard))
            toolbar.setItems([left,spaceButton,doneButton], animated: true)
            toolbar.isUserInteractionEnabled = true
            toolbar.sizeToFit()
            
            searchTextField.inputAccessoryView = toolbar
        }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
