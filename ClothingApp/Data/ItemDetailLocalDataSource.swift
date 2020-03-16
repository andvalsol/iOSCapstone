//
//  ItemDetailLocalDataSource.swift
//  ClothingApp
//
//  Created by Andrey Valverde Solera on 3/16/20.
//  Copyright © 2020 Andrey Valverde Solera. All rights reserved.
//

import Foundation
import UIKit

class ItemDetailLocalDataSource {
    
    static let picturePath = "userPicture.png"
    static let userName = "UserName"
    
    class func getUserPicture() -> String? {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(ItemDetailLocalDataSource.picturePath)
        
        if fileManager.fileExists(atPath: imagePath) {
            return imagePath
        }
        
        return nil
    }
    
    class func saveUserPicture(image: UIImage) {
        //create an instance of the FileManager
        let fileManager = FileManager.default
        //get the image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(ItemDetailLocalDataSource.picturePath)
        
        //get the PNG data for this image
        let data = image.pngData()
        
        
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
    
    class func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: ItemDetailLocalDataSource.userName)
    }
    
    class func saveUserName(_ name: String) {
        UserDefaults.standard.set(name, forKey: ItemDetailLocalDataSource.userName)
    }
}
