//
//  UserViewController.swift
//  ClothingApp
//
//  Created by Andrey Valverde Solera on 3/16/20.
//  Copyright © 2020 Andrey Valverde Solera. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UITextField!
    
    // Initialize the UIImagePickerController lazily, since it might not be used
    private lazy var pickerViewController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewController.delegate = self
        // Hide user image if the camera is not available
        userImage.isHidden = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        setUserPicture()
        setUserName()
    }
    
    @IBAction func pickImage(_ sender: Any) {
        pickerViewController.sourceType = .photoLibrary
        present(pickerViewController, animated: true, completion: nil)
    }
    
    @IBAction func textDidChange(_ sender: UITextField) {
        ItemDetailLocalDataSource.saveUserName(sender.text ?? "")
    }
    
    private func setUserPicture() {
        if let imagePath = ItemDetailLocalDataSource.getUserPicture() {
            userImage.image = UIImage(contentsOfFile: imagePath)
        }
    }
    
    private func setUserName() {
        userName.text = ItemDetailLocalDataSource.getUserName()
    }
}

extension UserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           // Function called when accesing the camera or the gallery
           if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               userImage.image = pickedImage
               
               ItemDetailLocalDataSource.saveUserPicture(image: pickedImage)
           }
           
           dismiss(animated: true, completion: nil)
       }
}
