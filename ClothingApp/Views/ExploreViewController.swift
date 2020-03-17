//
//  ViewController.swift
//  ClothingApp
//
//  Created by Andrey Valverde Solera on 3/14/20.
//  Copyright © 2020 Andrey Valverde Solera. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let cellIdentifier = "ItemCollectionViewCell"
    
    private var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        // Do any additional setup after loading the view.
        getStoreItems()
        
        try? addReachabilityObserver()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    deinit {
        removeReachabilityObserver()
    }
    
    private func setupCollectionViewItemSize() {
        let lineSpacing: CGFloat = 5
        let interItemSpacing: CGFloat = 5
        
        let width: CGFloat = 190
        
        let height: CGFloat = width * 1.5
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = lineSpacing
        collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
        
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailViewController" {
            if let destinationViewController = segue.destination as? ItemDetailViewController {
                let item = sender as! Item
                
                destinationViewController.itemImage = item.url
                destinationViewController.itemName = item.name
                destinationViewController.itemPrice = item.price
                destinationViewController.itemPhotos = item.photos
                destinationViewController.itemDescription = item.description
            }
        }
    }
    
    private func getStoreItems() {
        self.loadingIndicator.isHidden = false
        
        FirebaseClient.getStoreItems(withStoreID: "FTK9O8NpAgJdJbwkEZCW") { (items, error) in
            self.loadingIndicator.isHidden = true
            
            if let _ = error {
                // Show the error a proper error message
                self.showError(errorMessage: "There was an error getting this store's items")
                
            } else {
                if let items = items {
                    self.items = items
                    
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    private func showError(errorMessage: String) {
        let alert = UIAlertController(title: "Alert", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ExploreViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Open the ItemDetailViewController
        performSegue(withIdentifier: "ItemDetailViewController", sender: items[indexPath.row])
    }
}

extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count // We only have one section
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        let item = items[indexPath.row]
        
        cell.itemImage.loadImage(urlString: item.url)
        cell.itemImage.layer.cornerRadius = 20
        cell.itemName.text = item.name
        cell.itemPrice.text = item.price
        
        return cell
    }
}

extension ExploreViewController: ReachabilityObserverDelegate {
    
    func reachabilityChanged(_ isReachable: Bool) {
        showError(errorMessage: "There's no network connection")
    }
}
