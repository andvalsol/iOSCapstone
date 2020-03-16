//
//  ItemDetailViewController.swift
//  ClothingApp
//
//  Created by Andrey Valverde Solera on 3/15/20.
//  Copyright © 2020 Andrey Valverde Solera. All rights reserved.
//

import Foundation
import UIKit

class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var itemPhotosCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    
    private let itemDetailCollectionViewCellIdentifier = "ItemDetailViewControllerCell"
    
    var itemImage: String!
    
    var itemName: String!
    
    var itemPrice: String!
    
    var itemPhotos: [String]!
    
    var itemDescription: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ItemDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: itemDetailCollectionViewCellIdentifier)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        itemImageView.loadImage(urlString: itemImage)
        
        itemNameLabel.text = itemName
        itemPriceLabel.text = itemPrice
        itemDescriptionLabel.text = itemDescription
    }
}

extension ItemDetailViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ItemDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemDetailCollectionViewCellIdentifier, for: indexPath) as! ItemDetailCollectionViewCell
        
        cell.itemImage.loadImage(urlString: itemPhotos[indexPath.row])
        
        return cell
    }
}
