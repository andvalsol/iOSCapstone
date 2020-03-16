//
//  Item.swift
//  ClothingApp
//
//  Created by Andrey Valverde Solera on 3/14/20.
//  Copyright © 2020 Andrey Valverde Solera. All rights reserved.
//

import Foundation

class Item {
    var name: String!
    var url: String!
    var price: String!
    var photos: [String]!
    var description: String!
    
    var isFavorite = false
    
    init(dictionary: Dictionary<String, AnyObject>) {
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let url = dictionary["url"] as? String {
            self.url = url
        }
        
        if let price = dictionary["price"] as? String {
            self.price = price
        }
        
        if let photos = dictionary["photos"] as? [String] {
            self.photos = photos
        }
        
        if let description = dictionary["description"] as? String {
            self.description = description
        }
    }
}
