//
//  FirebaseClient.swift
//  ClothingApp
//
//  Created by Andrey Valverde Solera on 3/14/20.
//  Copyright © 2020 Andrey Valverde Solera. All rights reserved.
//

import Foundation
import Firebase

class FirebaseClient {
    static let FirestoreRef = Firestore.firestore()
    static let ItemsToSaleLimit = 15
    
    enum QueryEndpoints {
        case getStoreItems(storeID: String, limit: Int)
        
        var query: Query {
            switch self {
            case .getStoreItems(let storeID, let itemsToSaleLimit):
                // Enable data persistence
                let settings = FirestoreSettings()
                settings.isPersistenceEnabled = true
                
                let db = FirebaseClient.FirestoreRef
                db.settings = settings
                
                return db
                    .collection("Stores")
                    .document(storeID)
                    .collection("ItemsForSale")
                    .limit(to: itemsToSaleLimit)
            }
        }
    }
    
    enum DocumentEndpoints {
        case getItemInfo(fromStoreID: String, itemID: String)
        
        var documentReference: DocumentReference {
            switch self {
            case .getItemInfo(let storeID, let itemID):
                return FirebaseClient.FirestoreRef
                    .collection("Stores")
                    .document(storeID)
                    .collection("ItemsForSale")
                    .document(itemID)
            }
        }
    }
    
    class func getStoreItems(withStoreID storeID: String, limit: Int = FirebaseClient.ItemsToSaleLimit, completion: @escaping ([Item]?, Error?) -> Void) {
        FirebaseClient.QueryEndpoints.getStoreItems(storeID: storeID, limit: limit).query.getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
                
                return
            }
            
            var items = [Item]()
            
            snapshot?.documents.forEach({ (document) in
                let item = self.getItemFrom(queryDocumentSnapshot: document)
                
                items.append(item)
            })
            
            completion(items, nil)
        }
    }
    
    class func getItemInfo(withStoreID storeID: String, itemID: String, completion: @escaping (Item?, Error?) -> Void) {
        FirebaseClient.DocumentEndpoints.getItemInfo(fromStoreID: storeID, itemID: itemID).documentReference.getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
                
                return
            }
            
            if let document = document {
                let item = self.getItemFrom(documentSnapshot: document)
                
                completion(item, nil)
            
            } else {
                completion(nil, CustomError("document is nil"))
            }
        }
    }
    
    class func getItemFrom(queryDocumentSnapshot document: QueryDocumentSnapshot) -> Item {
        let dictionary = document.data() as Dictionary<String, AnyObject>
        
        return Item(dictionary: dictionary)
    }
    
    class func getItemFrom(documentSnapshot document: DocumentSnapshot) -> Item {
        let dictionary = document.data() as! Dictionary<String, AnyObject>
        
        return Item(dictionary: dictionary)
    }
}
