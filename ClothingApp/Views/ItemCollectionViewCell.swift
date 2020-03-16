//
//  ItemCollectionViewCell.swift
//  ClothingApp
//
//  Created by Andrey Valverde Solera on 3/15/20.
//  Copyright © 2020 Andrey Valverde Solera. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemName: UILabel!

    @IBOutlet weak var itemImage: UIImageView!
    
    
    @IBOutlet weak var itemPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
