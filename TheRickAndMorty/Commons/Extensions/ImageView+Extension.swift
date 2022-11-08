//
//  ImageView+Extension.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 23/08/22.
//

import UIKit


extension UIImageView {
    
    func renderImageView(urlImage: String) {
        if let urlPhoto = URL(string: urlImage) {
            URLSession.shared.dataTask(with: urlPhoto) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    let image = UIImage(data: data)
                    self.image = image
                }
            }.resume()
        }
    }
}
