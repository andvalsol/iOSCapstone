//
//  Extensions.swift
//  ClothingApp
//
//  Created by Andrey Valverde Solera on 3/16/20.
//  Copyright © 2020 Andrey Valverde Solera. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(urlString: String) {
        let url = URL(string: urlString)
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
